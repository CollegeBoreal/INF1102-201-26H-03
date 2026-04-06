"""
=============================================================
  NEWS SCRAPER & ANALYSER - analyse.py
=============================================================
  Auteur  : Projet pédagogique Python
  Version : 1.0
  Usage   : python analyse.py [--site cnn|bbc]

  Ce script :
    1. Scrappe les titres et résumés d'un site d'actualités
    2. Nettoie et analyse le texte (fréquence des mots)
    3. Génère un histogramme et un nuage de mots
    4. Sauvegarde les données brutes (JSON) et un rapport texte
=============================================================
"""

# ── Bibliothèques standard ──────────────────────────────────
import argparse          # Pour lire les arguments en ligne de commande
import json              # Pour sauvegarder les données au format JSON
import os                # Pour créer les dossiers
import re                # Expressions régulières (nettoyage du texte)
import string            # Ponctuation
import time              # Pour ajouter des délais entre les requêtes
from collections import Counter  # Comptage des mots
from datetime import datetime    # Horodatage

# ── Bibliothèques tierces ───────────────────────────────────
import requests                          # Télécharger des pages web
from bs4 import BeautifulSoup            # Parser le HTML
import matplotlib.pyplot as plt          # Graphiques
import matplotlib.patches as mpatches
import pandas as pd                      # Manipulation des données

# WordCloud est optionnel : on gère l'absence proprement
try:
    from wordcloud import WordCloud
    WORDCLOUD_AVAILABLE = True
except ImportError:
    WORDCLOUD_AVAILABLE = False
    print("[INFO] wordcloud non installé — nuage de mots désactivé.")
    print("       Installez-le avec : pip install wordcloud\n")


# ══════════════════════════════════════════════════════════════
#  CONFIGURATION GÉNÉRALE
# ══════════════════════════════════════════════════════════════

# Dossiers de sortie (relatifs au script)
BASE_DIR    = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA_DIR    = os.path.join(BASE_DIR, "data")
OUTPUT_DIR  = os.path.join(BASE_DIR, "output")

# Créer les dossiers s'ils n'existent pas
os.makedirs(DATA_DIR,   exist_ok=True)
os.makedirs(OUTPUT_DIR, exist_ok=True)

# User-Agent réaliste : on se présente comme un navigateur Chrome
HEADERS = {
    "User-Agent": (
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
        "AppleWebKit/537.36 (KHTML, like Gecko) "
        "Chrome/124.0.0.0 Safari/537.36"
    ),
    "Accept-Language": "en-US,en;q=0.9",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
}

# Délai poli entre chaque requête (secondes)
REQUEST_DELAY = 1.5

# Mots vides anglais (stopwords) : mots très courants sans intérêt analytique
STOPWORDS = {
    "the","a","an","and","or","but","in","on","at","to","for",
    "of","with","by","from","is","are","was","were","be","been",
    "have","has","had","do","does","did","will","would","could",
    "should","may","might","that","this","these","those","it",
    "its","as","up","out","about","after","before","over","than",
    "into","not","no","so","if","then","when","who","which","all",
    "more","also","their","they","he","she","we","you","i","my",
    "our","your","his","her","us","them","said","say","says","can",
    "new","just","now","get","got","one","two","three","he's",
    "she's","it's","they're","we're","what","how","why","where",
    "been","there","s","t","re","ve","ll","d","m",
}

# Configuration des sites supportés
SITES = {
    "bbc": {
        "url": "https://www.bbc.com/news",
        "label": "BBC News",
        "title_selectors":   ["h3", "h2"],
        "summary_selectors": ["p"],
        "article_limit": 30,   # Nombre max d'articles à analyser
    },
    "cnn": {
        "url": "https://edition.cnn.com",
        "label": "CNN",
        "title_selectors":   ["span.container__headline-text", "h3", "h2"],
        "summary_selectors": ["div.container__description", "p"],
        "article_limit": 30,
    },
}


# ══════════════════════════════════════════════════════════════
#  ÉTAPE 1 — SCRAPING
# ══════════════════════════════════════════════════════════════

def fetch_page(url: str) -> BeautifulSoup | None:
    """
    Télécharge une page web et retourne un objet BeautifulSoup.

    BeautifulSoup transforme le code HTML brut en un objet Python
    que l'on peut interroger facilement (comme une base de données).

    Args:
        url: L'adresse de la page à télécharger.

    Returns:
        Un objet BeautifulSoup, ou None en cas d'erreur.
    """
    print(f"[SCRAPING] Connexion à : {url}")
    try:
        # On attend un peu avant chaque requête → comportement humain
        time.sleep(REQUEST_DELAY)

        response = requests.get(url, headers=HEADERS, timeout=15)
        response.raise_for_status()   # Lève une exception si code HTTP ≥ 400

        # "html.parser" est le parseur HTML intégré à Python (pas besoin d'installer lxml)
        soup = BeautifulSoup(response.text, "html.parser")
        print(f"[OK] Page téléchargée ({len(response.text):,} caractères)")
        return soup

    except requests.exceptions.ConnectionError:
        print(f"[ERREUR] Impossible de se connecter à {url}.")
        print("         Vérifiez votre connexion internet.")
    except requests.exceptions.Timeout:
        print(f"[ERREUR] Le site {url} met trop de temps à répondre.")
    except requests.exceptions.HTTPError as e:
        print(f"[ERREUR] Réponse HTTP inattendue : {e}")
    except Exception as e:
        print(f"[ERREUR] Problème inattendu : {e}")

    return None


def extract_articles(soup: BeautifulSoup, config: dict) -> list[dict]:
    """
    Extrait les titres et résumés depuis le HTML de la page.

    On cherche les balises HTML qui contiennent les titres (h2, h3…)
    et les résumés (p). Les sélecteurs sont définis dans SITES{}.

    Args:
        soup:   Page HTML parsée.
        config: Configuration du site (sélecteurs, limite).

    Returns:
        Liste de dictionnaires {"title": ..., "summary": ...}.
    """
    articles = []
    seen_texts = set()   # Évite les doublons

    # ── Extraction des titres ──────────────────────────────
    titles = []
    for selector in config["title_selectors"]:
        found = soup.select(selector)
        if found:
            titles = [el.get_text(strip=True) for el in found]
            break   # On s'arrête au premier sélecteur qui fonctionne

    # ── Extraction des résumés ─────────────────────────────
    summaries = []
    for selector in config["summary_selectors"]:
        found = soup.select(selector)
        if found:
            summaries = [el.get_text(strip=True) for el in found
                         if len(el.get_text(strip=True)) > 40]  # Filtrer les <p> trop courts
            break

    # ── Assemblage des articles ────────────────────────────
    limit = config["article_limit"]
    for i, title in enumerate(titles[:limit]):
        if len(title) < 10 or title in seen_texts:
            continue   # Ignorer les titres trop courts ou les doublons

        summary = summaries[i] if i < len(summaries) else ""
        seen_texts.add(title)

        articles.append({
            "title":   title,
            "summary": summary,
            "source":  config["label"],
            "scraped_at": datetime.now().isoformat(),
        })

    print(f"[OK] {len(articles)} articles extraits.")
    return articles


# ══════════════════════════════════════════════════════════════
#  ÉTAPE 2 — NETTOYAGE DU TEXTE
# ══════════════════════════════════════════════════════════════

def clean_text(text: str) -> list[str]:
    """
    Transforme un texte brut en liste de mots "propres".

    Étapes :
        1. Tout mettre en minuscules
        2. Supprimer la ponctuation et les chiffres
        3. Découper en mots (tokenisation)
        4. Retirer les mots vides (stopwords) et les mots trop courts

    Args:
        text: Le texte brut à nettoyer.

    Returns:
        Liste de mots significatifs.
    """
    # 1. Minuscules
    text = text.lower()

    # 2. Supprimer tout ce qui n'est pas une lettre ou un espace
    #    re.sub remplace les correspondances par ""
    text = re.sub(r"[^a-z\s]", " ", text)

    # 3. Découper en mots (split sur les espaces)
    words = text.split()

    # 4. Filtrer : on garde uniquement les mots significatifs
    words = [
        w for w in words
        if w not in STOPWORDS    # Pas un mot vide
        and len(w) > 3           # Plus de 3 lettres
        and not w.isdigit()      # Pas un nombre
    ]

    return words


def analyse_articles(articles: list[dict]) -> tuple[Counter, list[str]]:
    """
    Concatène tout le texte et comptabilise les mots.

    Args:
        articles: Liste des articles extraits.

    Returns:
        Un Counter (dictionnaire mot → fréquence) et la liste de tous les mots.
    """
    all_words = []

    for article in articles:
        # On combine titre et résumé dans un seul bloc de texte
        full_text = f"{article['title']} {article['summary']}"
        words = clean_text(full_text)
        all_words.extend(words)

    word_counts = Counter(all_words)
    print(f"[OK] {len(all_words)} mots analysés, {len(word_counts)} mots uniques trouvés.")
    return word_counts, all_words


# ══════════════════════════════════════════════════════════════
#  ÉTAPE 3 — VISUALISATIONS
# ══════════════════════════════════════════════════════════════

def plot_histogram(word_counts: Counter, site_label: str, top_n: int = 10) -> str:
    """
    Génère un histogramme des N mots les plus fréquents.

    matplotlib est la bibliothèque de référence pour les graphiques
    en Python. On crée ici un graphique à barres horizontales.

    Args:
        word_counts: Fréquences des mots.
        site_label:  Nom du site (pour le titre du graphique).
        top_n:       Nombre de mots à afficher.

    Returns:
        Chemin du fichier image sauvegardé.
    """
    top_words = word_counts.most_common(top_n)
    words  = [w for w, _ in top_words]
    counts = [c for _, c in top_words]

    # ── Style du graphique ─────────────────────────────────
    fig, ax = plt.subplots(figsize=(10, 6))
    fig.patch.set_facecolor("#0f0f1a")
    ax.set_facecolor("#0f0f1a")

    # Dégradé de couleurs du bleu au violet
    colors = plt.cm.cool([i / top_n for i in range(top_n)])

    bars = ax.barh(words[::-1], counts[::-1], color=colors[::-1],
                   edgecolor="#ffffff22", linewidth=0.5)

    # Étiquettes de valeur sur chaque barre
    for bar, count in zip(bars, counts[::-1]):
        ax.text(bar.get_width() + 0.2, bar.get_y() + bar.get_height() / 2,
                str(count), va="center", ha="left",
                color="white", fontsize=9, fontweight="bold")

    # ── Mise en forme ──────────────────────────────────────
    ax.set_title(f"Top {top_n} mots — {site_label}",
                 color="white", fontsize=14, fontweight="bold", pad=15)
    ax.set_xlabel("Fréquence", color="#aaaacc", fontsize=10)
    ax.tick_params(colors="white", labelsize=9)
    ax.spines["top"].set_visible(False)
    ax.spines["right"].set_visible(False)
    ax.spines["bottom"].set_color("#333355")
    ax.spines["left"].set_color("#333355")
    ax.xaxis.label.set_color("#aaaacc")

    plt.tight_layout(pad=2)

    out_path = os.path.join(OUTPUT_DIR, "histogram.png")
    plt.savefig(out_path, dpi=150, bbox_inches="tight",
                facecolor=fig.get_facecolor())
    plt.close()
    print(f"[OK] Histogramme sauvegardé → {out_path}")
    return out_path


def plot_wordcloud(all_words: list[str], site_label: str) -> str | None:
    """
    Génère un nuage de mots (WordCloud).

    Un nuage de mots affiche les mots les plus fréquents en plus grands.
    Plus un mot est grand, plus il apparaît souvent dans les articles.

    Args:
        all_words:  Liste de tous les mots nettoyés.
        site_label: Nom du site.

    Returns:
        Chemin du fichier image, ou None si wordcloud n'est pas installé.
    """
    if not WORDCLOUD_AVAILABLE:
        return None

    text = " ".join(all_words)

    wc = WordCloud(
        width=1200, height=600,
        background_color="#0f0f1a",
        colormap="cool",
        max_words=80,
        prefer_horizontal=0.8,
        collocations=False,   # Évite les paires de mots dupliquées
    ).generate(text)

    fig, ax = plt.subplots(figsize=(12, 6))
    fig.patch.set_facecolor("#0f0f1a")
    ax.imshow(wc, interpolation="bilinear")
    ax.axis("off")
    ax.set_title(f"Nuage de mots — {site_label}",
                 color="white", fontsize=14, fontweight="bold", pad=10)

    out_path = os.path.join(OUTPUT_DIR, "wordcloud.png")
    plt.savefig(out_path, dpi=150, bbox_inches="tight",
                facecolor=fig.get_facecolor())
    plt.close()
    print(f"[OK] Nuage de mots sauvegardé → {out_path}")
    return out_path


# ══════════════════════════════════════════════════════════════
#  ÉTAPE 4 — SAUVEGARDE DES DONNÉES
# ══════════════════════════════════════════════════════════════

def save_json(articles: list[dict], word_counts: Counter) -> str:
    """
    Sauvegarde les données brutes au format JSON.

    JSON (JavaScript Object Notation) est un format texte universel
    pour stocker et échanger des données structurées.

    Args:
        articles:    Liste des articles scrappés.
        word_counts: Fréquences des mots.

    Returns:
        Chemin du fichier JSON créé.
    """
    data = {
        "generated_at": datetime.now().isoformat(),
        "total_articles": len(articles),
        "top_words": dict(word_counts.most_common(50)),
        "articles": articles,
    }

    out_path = os.path.join(DATA_DIR, "news_data.json")
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

    print(f"[OK] Données JSON sauvegardées → {out_path}")
    return out_path


def save_report(word_counts: Counter, site_label: str, total_articles: int) -> str:
    """
    Génère un rapport texte lisible avec les résultats de l'analyse.

    Args:
        word_counts:    Fréquences des mots.
        site_label:     Nom du site analysé.
        total_articles: Nombre d'articles scrappés.

    Returns:
        Chemin du fichier rapport.
    """
    top10 = word_counts.most_common(10)
    timestamp = datetime.now().strftime("%d/%m/%Y à %H:%M")

    lines = [
        "=" * 60,
        f"  RAPPORT D'ANALYSE — {site_label.upper()}",
        f"  Généré le {timestamp}",
        "=" * 60,
        "",
        f"  Articles analysés : {total_articles}",
        f"  Mots uniques      : {len(word_counts)}",
        "",
        "─" * 60,
        "  TOP 10 DES MOTS LES PLUS FRÉQUENTS",
        "─" * 60,
        "",
    ]

    for rank, (word, count) in enumerate(top10, 1):
        bar = "█" * min(count, 40)
        lines.append(f"  {rank:2}. {word:<20} {count:>4} fois  {bar}")

    lines += [
        "",
        "─" * 60,
        "  INTERPRÉTATION",
        "─" * 60,
        "",
    ]

    # Interprétation automatique basée sur les mots dominants
    top_words_list = [w for w, _ in top10]
    interpretation = generate_interpretation(top_words_list, site_label)
    for line in interpretation:
        lines.append(f"  {line}")

    lines += ["", "=" * 60, "  Fin du rapport", "=" * 60]

    out_path = os.path.join(OUTPUT_DIR, "rapport.txt")
    with open(out_path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))

    print(f"[OK] Rapport texte sauvegardé → {out_path}")
    return out_path


def generate_interpretation(top_words: list[str], site_label: str) -> list[str]:
    """
    Génère une interprétation textuelle automatique des mots dominants.

    On associe des thèmes aux mots-clés pour déduire les grandes
    catégories de sujets traités par le site ce jour-là.

    Args:
        top_words:  Les 10 mots les plus fréquents.
        site_label: Nom du site.

    Returns:
        Liste de phrases d'interprétation.
    """
    themes = {
        "politique":   {"government","president","minister","party","election","vote","senate","congress","parliament"},
        "économie":    {"economy","market","price","inflation","trade","growth","recession","dollar","bank","stock"},
        "conflit":     {"war","attack","military","troops","conflict","ukraine","russia","israel","gaza","killed"},
        "santé":       {"health","hospital","disease","vaccine","covid","cancer","treatment","medical","drug"},
        "technologie": {"ai","technology","data","digital","cyber","software","tech","internet","robot","model"},
        "climate":     {"climate","weather","fire","flood","storm","carbon","energy","environment","pollution"},
        "sport":       {"game","team","player","win","match","league","championship","olympic","score"},
    }

    detected = []
    for theme, keywords in themes.items():
        if keywords.intersection(top_words):
            detected.append(theme)

    lines = [
        f"Les actualités de {site_label} ce jour portent principalement sur :",
        "",
    ]

    if detected:
        for theme in detected:
            lines.append(f"  • {theme.capitalize()}")
    else:
        lines.append("  • Sujets variés (aucun thème dominant identifié)")

    lines += [
        "",
        "Cette analyse est basée sur la fréquence des mots dans les",
        "titres et résumés des articles. Les résultats reflètent",
        "les préoccupations éditoriales du site à ce moment précis.",
    ]

    return lines


# ══════════════════════════════════════════════════════════════
#  POINT D'ENTRÉE PRINCIPAL
# ══════════════════════════════════════════════════════════════

def main():
    # ── Lecture des arguments ──────────────────────────────
    parser = argparse.ArgumentParser(
        description="Scraper et analyseur de news (CNN ou BBC)"
    )
    parser.add_argument(
        "--site",
        choices=["cnn", "bbc"],
        default="bbc",
        help="Site à scrapper : 'cnn' ou 'bbc' (défaut: bbc)"
    )
    args = parser.parse_args()

    config     = SITES[args.site]
    site_label = config["label"]

    print("\n" + "=" * 60)
    print(f"  NEWS ANALYSER — {site_label}")
    print("=" * 60 + "\n")

    # ÉTAPE 1 : Scraping ───────────────────────────────────
    print("── ÉTAPE 1 : Scraping ─────────────────────────────────")
    soup = fetch_page(config["url"])
    if soup is None:
        print("[ABANDON] Impossible de continuer sans données.")
        return

    articles = extract_articles(soup, config)
    if not articles:
        print("[ABANDON] Aucun article extrait. La structure HTML a peut-être changé.")
        return

    # ÉTAPE 2 : Analyse textuelle ──────────────────────────
    print("\n── ÉTAPE 2 : Analyse textuelle ────────────────────────")
    word_counts, all_words = analyse_articles(articles)

    print("\n  Top 10 mots les plus fréquents :")
    for rank, (word, count) in enumerate(word_counts.most_common(10), 1):
        print(f"    {rank:2}. {word:<20} → {count} occurrences")

    # ÉTAPE 3 : Visualisations ─────────────────────────────
    print("\n── ÉTAPE 3 : Génération des graphiques ────────────────")
    plot_histogram(word_counts, site_label)
    plot_wordcloud(all_words, site_label)

    # ÉTAPE 4 : Sauvegarde ─────────────────────────────────
    print("\n── ÉTAPE 4 : Sauvegarde des fichiers ──────────────────")
    save_json(articles, word_counts)
    save_report(word_counts, site_label, len(articles))

    print("\n" + "=" * 60)
    print("  ANALYSE TERMINÉE AVEC SUCCÈS !")
    print(f"  Données  → {DATA_DIR}")
    print(f"  Graphiques → {OUTPUT_DIR}")
    print("=" * 60 + "\n")


if __name__ == "__main__":
    main()
