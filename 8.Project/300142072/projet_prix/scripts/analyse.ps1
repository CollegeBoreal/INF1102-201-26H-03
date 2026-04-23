#!/usr/bin/env python3
"""
analyse.py — Suivi de prix e-commerce
Scrape books.toscrape.com, enregistre les prix dans un CSV,
génère un graphique et un rapport texte.
"""

import sys
import os
import csv
import json
import re
from datetime import datetime
from collections import defaultdict

import requests
from bs4 import BeautifulSoup
import matplotlib.pyplot as plt
import matplotlib.dates as mdates

# ── Configuration ────────────────────────────────────────────
BASE_URL    = "https://books.toscrape.com/catalogue/"
CATEGORIES  = ["mystery", "science-fiction", "romance"]   # Catégories suivies
MAX_BOOKS   = 5                                            # Livres par catégorie

# ── Chemins ──────────────────────────────────────────────────
ROOT_DIR    = sys.argv[1] if len(sys.argv) > 1 else os.path.dirname(os.path.dirname(__file__))
CSV_FILE    = os.path.join(ROOT_DIR, "data", "prix_historique.csv")
RAPPORT_TXT = os.path.join(ROOT_DIR, "output", "rapport.txt")
GRAPH_FILE  = os.path.join(ROOT_DIR, "output", "evolution_prix.png")
JSON_CACHE  = os.path.join(ROOT_DIR, "data", "derniere_capture.json")

os.makedirs(os.path.join(ROOT_DIR, "data"),   exist_ok=True)
os.makedirs(os.path.join(ROOT_DIR, "output"), exist_ok=True)


# ════════════════════════════════════════════════════════════
#  1. SCRAPING
# ════════════════════════════════════════════════════════════

def convertir_etoiles(mot: str) -> int:
    """Convertit 'Three' → 3, etc."""
    mots = {"One": 1, "Two": 2, "Three": 3, "Four": 4, "Five": 5}
    return mots.get(mot, 0)


def scraper_categorie(categorie: str) -> list[dict]:
    """Scrape les N premiers livres d'une catégorie."""
    url = f"https://books.toscrape.com/catalogue/category/books/{categorie}_3/index.html"
    livres = []

    try:
        resp = requests.get(url, timeout=10)
        resp.raise_for_status()
    except requests.RequestException as e:
        print(f"  ⚠ Impossible d'accéder à {categorie} : {e}")
        return livres

    soup = BeautifulSoup(resp.text, "html.parser")
    articles = soup.select("article.product_pod")[:MAX_BOOKS]

    for art in articles:
        titre = art.h3.a["title"]
        prix_brut = art.select_one("p.price_color").text.strip()
        # Supprime le symbole £ et convertit en float
        prix = float(re.sub(r"[^\d.]", "", prix_brut))
        etoiles_classe = art.select_one("p.star-rating")["class"][1]
        etoiles = convertir_etoiles(etoiles_classe)
        dispo = art.select_one("p.availability").text.strip()

        livres.append({
            "date":       datetime.now().strftime("%Y-%m-%d %H:%M"),
            "categorie":  categorie,
            "titre":      titre,
            "prix":       prix,
            "etoiles":    etoiles,
            "disponible": dispo,
        })

    return livres


def scraper_tous() -> list[dict]:
    """Lance le scraping sur toutes les catégories."""
    tous = []
    for cat in CATEGORIES:
        print(f"  → Scraping catégorie : {cat}")
        livres = scraper_categorie(cat)
        tous.extend(livres)
        print(f"     {len(livres)} livre(s) récupéré(s)")
    return tous


# ════════════════════════════════════════════════════════════
#  2. SAUVEGARDE CSV
# ════════════════════════════════════════════════════════════

ENTETES = ["date", "categorie", "titre", "prix", "etoiles", "disponible"]


def sauvegarder_csv(livres: list[dict]):
    """Ajoute les nouvelles données au CSV historique."""
    fichier_existe = os.path.isfile(CSV_FILE)
    with open(CSV_FILE, "a", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=ENTETES)
        if not fichier_existe:
            writer.writeheader()
        writer.writerows(livres)
    print(f"  ✔ {len(livres)} entrées ajoutées dans {CSV_FILE}")


def charger_historique() -> list[dict]:
    """Lit tout le CSV historique."""
    if not os.path.isfile(CSV_FILE):
        return []
    with open(CSV_FILE, "r", encoding="utf-8") as f:
        return list(csv.DictReader(f))


# ════════════════════════════════════════════════════════════
#  3. ANALYSE
# ════════════════════════════════════════════════════════════

def analyser(historique: list[dict], derniers: list[dict]) -> dict:
    """Calcule les statistiques principales."""
    stats = {}

    # Prix moyen par catégorie (données actuelles)
    par_cat = defaultdict(list)
    for l in derniers:
        par_cat[l["categorie"]].append(l["prix"])

    stats["prix_moyen_cat"] = {
        cat: round(sum(prix) / len(prix), 2)
        for cat, prix in par_cat.items()
    }

    # Livre le moins cher et le plus cher
    if derniers:
        stats["moins_cher"] = min(derniers, key=lambda x: x["prix"])
        stats["plus_cher"]  = max(derniers, key=lambda x: x["prix"])
        stats["prix_global_moyen"] = round(
            sum(l["prix"] for l in derniers) / len(derniers), 2
        )

    # Variation de prix entre la capture précédente et la courante
    variations = []
    if len(historique) > len(derniers):
        anciens = {l["titre"]: float(l["prix"]) for l in historique[:-len(derniers)]}
        for l in derniers:
            if l["titre"] in anciens:
                diff = round(l["prix"] - anciens[l["titre"]], 2)
                if diff != 0:
                    variations.append({"titre": l["titre"], "variation": diff})

    stats["variations"] = variations
    return stats


# ════════════════════════════════════════════════════════════
#  4. GRAPHIQUE
# ════════════════════════════════════════════════════════════

def generer_graphique(historique: list[dict], derniers: list[dict]):
    """Génère deux graphiques : évolution + comparaison actuelle."""
    fig, axes = plt.subplots(1, 2, figsize=(14, 6))
    fig.suptitle("Suivi de prix — books.toscrape.com", fontsize=14, fontweight="bold")

    # ── Graphique 1 : prix actuels par catégorie ──────────────
    ax1 = axes[0]
    par_cat = defaultdict(list)
    for l in derniers:
        par_cat[l["categorie"]].append(l["prix"])

    categories = list(par_cat.keys())
    moyennes   = [round(sum(p)/len(p), 2) for p in par_cat.values()]
    couleurs   = ["#4C72B0", "#DD8452", "#55A868"]

    bars = ax1.bar(categories, moyennes, color=couleurs[:len(categories)], edgecolor="white")
    ax1.bar_label(bars, fmt="£%.2f", padding=3, fontsize=9)
    ax1.set_title("Prix moyen par catégorie (capture actuelle)")
    ax1.set_ylabel("Prix (£)")
    ax1.set_ylim(0, max(moyennes) * 1.3 if moyennes else 10)
    ax1.tick_params(axis="x", rotation=15)

    # ── Graphique 2 : scatter prix vs étoiles ─────────────────
    ax2 = axes[1]
    for cat, couleur in zip(categories, couleurs):
        livres_cat = [l for l in derniers if l["categorie"] == cat]
        ax2.scatter(
            [int(l["etoiles"]) for l in livres_cat],
            [l["prix"]         for l in livres_cat],
            label=cat, color=couleur, s=80, alpha=0.8
        )

    ax2.set_title("Prix vs Note (étoiles)")
    ax2.set_xlabel("Note (étoiles)")
    ax2.set_ylabel("Prix (£)")
    ax2.set_xticks([1, 2, 3, 4, 5])
    ax2.legend()

    plt.tight_layout()
    plt.savefig(GRAPH_FILE, dpi=120, bbox_inches="tight")
    plt.close()
    print(f"  ✔ Graphique sauvegardé : {GRAPH_FILE}")


# ════════════════════════════════════════════════════════════
#  5. RAPPORT TEXTE
# ════════════════════════════════════════════════════════════

def generer_rapport(derniers: list[dict], stats: dict):
    """Écrit output/rapport.txt."""
    now = datetime.now().strftime("%Y-%m-%d %H:%M")
    lignes = [
        "=" * 55,
        "  RAPPORT DE SUIVI DE PRIX — books.toscrape.com",
        f"  Généré le : {now}",
        "=" * 55,
        "",
        f"Catégories suivies : {', '.join(CATEGORIES)}",
        f"Nombre de livres analysés : {len(derniers)}",
        "",
        "── PRIX MOYENS PAR CATÉGORIE ──────────────────────────",
    ]

    for cat, moy in stats.get("prix_moyen_cat", {}).items():
        lignes.append(f"  {cat:<20} £{moy}")

    lignes += [
        "",
        f"Prix moyen global    : £{stats.get('prix_global_moyen', 'N/A')}",
    ]

    if "moins_cher" in stats:
        lc = stats["moins_cher"]
        lignes.append(f"Livre le moins cher  : {lc['titre'][:35]:<35} £{lc['prix']}")
    if "plus_cher" in stats:
        pc = stats["plus_cher"]
        lignes.append(f"Livre le plus cher   : {pc['titre'][:35]:<35} £{pc['prix']}")

    lignes += ["", "── VARIATIONS DE PRIX ─────────────────────────────────"]
    variations = stats.get("variations", [])
    if variations:
        for v in variations:
            signe = "▲" if v["variation"] > 0 else "▼"
            lignes.append(f"  {signe} {v['titre'][:40]:<40} {v['variation']:+.2f} £")
    else:
        lignes.append("  Aucune variation détectée (première capture ou prix stables).")

    lignes += [
        "",
        "── DÉTAIL DES LIVRES ──────────────────────────────────",
        f"  {'Titre':<35} {'Cat.':<20} {'Prix':>6}  {'★':>3}",
        "  " + "-" * 70,
    ]
    for l in sorted(derniers, key=lambda x: x["prix"]):
        titre = l["titre"][:34]
        lignes.append(
            f"  {titre:<35} {l['categorie']:<20} £{l['prix']:>5.2f}  {l['etoiles']:>2}★"
        )

    lignes += ["", "=" * 55]

    with open(RAPPORT_TXT, "w", encoding="utf-8") as f:
        f.write("\n".join(lignes))

    print(f"  ✔ Rapport texte : {RAPPORT_TXT}")


# ════════════════════════════════════════════════════════════
#  MAIN
# ════════════════════════════════════════════════════════════

if __name__ == "__main__":
    print("\n[Scraping en cours...]")
    derniers = scraper_tous()

    if not derniers:
        print("ERREUR : aucun livre récupéré. Vérifie ta connexion.")
        sys.exit(1)

    print("\n[Sauvegarde CSV...]")
    sauvegarder_csv(derniers)

    print("\n[Analyse...]")
    historique = charger_historique()
    stats = analyser(historique, derniers)

    print("\n[Génération du graphique...]")
    generer_graphique(historique, derniers)

    print("\n[Génération du rapport...]")
    generer_rapport(derniers, stats)

    # Cache JSON pour le Notebook
    with open(JSON_CACHE, "w", encoding="utf-8") as f:
        json.dump({"derniers": derniers, "stats": stats}, f, ensure_ascii=False, indent=2)

    print("\n✅ Analyse terminée avec succès !")
