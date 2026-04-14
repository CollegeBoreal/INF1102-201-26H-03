#!/usr/bin/env python3
"""
=============================================================
 Projet IDH Afrique — Analyse du Développement Humain
 Étudiant : Frank Laurel | ID : 300143951
 Cours    : Techniques des Systèmes Informatiques (TSI)
 Collège  : Collège Boréal — Session Hiver 2025
=============================================================
"""

import os
import re
import sys
import csv
import json
import time
import argparse
import requests
import pandas as pd
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker
import seaborn as sns
from datetime import datetime
from collections import defaultdict

# ─────────────────────────────────────────────
#  CONFIGURATION GLOBALE
# ─────────────────────────────────────────────
BASE_DIR    = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA_DIR    = os.path.join(BASE_DIR, "data", "raw")
OUTPUT_DIR  = os.path.join(BASE_DIR, "output")
RAPPORT_TXT = os.path.join(OUTPUT_DIR, "rapport.txt")
LOG_FILE    = os.path.join(OUTPUT_DIR, "execution.log")

os.makedirs(DATA_DIR, exist_ok=True)
os.makedirs(OUTPUT_DIR, exist_ok=True)

# Pays étudiés : Cameroun en focus + comparatifs africains
COUNTRIES = {
    "CM": "Cameroun",
    "NG": "Nigeria",
    "ZA": "Afrique du Sud",
    "GH": "Ghana",
    "SN": "Sénégal",
    "KE": "Kenya",
    "CI": "Côte d'Ivoire",
    "ET": "Éthiopie",
}

# Indicateurs World Bank
INDICATORS = {
    "NY.GDP.PCAP.CD": "PIB_par_habitant_USD",
    "SP.DYN.LE00.IN": "Esperance_de_vie_ans",
    "SH.DYN.MORT":    "Mortalite_infantile_pour_1000",
    "SE.ADT.LITR.ZS": "Taux_alphabetisation_pct",
    "EG.ELC.ACCS.ZS": "Acces_electricite_pct",
    "IT.NET.USER.ZS": "Acces_internet_pct",
}

BASE_URL = (
    "https://api.worldbank.org/v2/country/{country}"
    "/indicator/{indicator}?format=json&per_page=50&mrv=30"
)

# REGEX — validation et nettoyage des données
REGEX_COUNTRY_CODE = re.compile(r'^[A-Z]{2}$')
REGEX_YEAR         = re.compile(r'^\d{4}$')
REGEX_NUMERIC      = re.compile(r'^-?\d+(\.\d+)?$')
REGEX_NULL_VALUES   = re.compile(r'^(null|none|na|n/a|-)$', re.IGNORECASE)


# ─────────────────────────────────────────────
#  LOGGING
# ─────────────────────────────────────────────
def log(message: str, level: str = "INFO"):
    """Journalise un message dans le fichier log et sur stdout."""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    entry = f"[{timestamp}] [{level}] {message}"
    print(entry)
    with open(LOG_FILE, "a", encoding="utf-8") as f:
        f.write(entry + "\n")


# ─────────────────────────────────────────────
#  RÉCUPÉRATION DES DONNÉES
# ─────────────────────────────────────────────
def fetch_indicator(country_code: str, indicator_code: str, dry_run: bool = False) -> list:
    """
    Appelle l'API World Bank et retourne une liste de (year, value).
    Gère les erreurs réseau et valide les codes avec REGEX.
    """
    # Validation REGEX des paramètres
    if not REGEX_COUNTRY_CODE.match(country_code):
        log(f"Code pays invalide : {country_code}", "ERROR")
        return []

    if dry_run:
        log(f"[DRY-RUN] Simulation pour {country_code} / {indicator_code}")
        return [(str(y), round(50 + y * 0.1, 2)) for y in range(2000, 2023)]

    url = BASE_URL.format(country=country_code, indicator=indicator_code)
    try:
        response = requests.get(url, timeout=15)
        response.raise_for_status()
        raw = response.json()

        # L'API retourne [metadata, data]
        if not isinstance(raw, list) or len(raw) < 2:
            log(f"Réponse API inattendue pour {country_code}/{indicator_code}", "WARN")
            return []

        records = []
        for entry in raw[1]:
            year  = str(entry.get("date", ""))
            value = entry.get("value")

            # Validation REGEX année
            if not REGEX_YEAR.match(year):
                continue

            # Nettoyage valeur nulle
            if value is None:
                continue
            str_val = str(value).strip()
            if REGEX_NULL_VALUES.match(str_val):
                continue
            if not REGEX_NUMERIC.match(str_val):
                continue

            records.append((year, float(value)))

        records.sort(key=lambda x: x[0])
        return records

    except requests.exceptions.Timeout:
        log(f"Timeout pour {country_code}/{indicator_code}", "ERROR")
        return []
    except requests.exceptions.RequestException as e:
        log(f"Erreur réseau : {e}", "ERROR")
        return []
    except (json.JSONDecodeError, IndexError, KeyError) as e:
        log(f"Erreur parsing JSON : {e}", "ERROR")
        return []


def collect_all_data(dry_run: bool = False) -> dict:
    """
    Collecte toutes les données pour tous les pays et indicateurs.
    Retourne un dict : {indicator_name: {country_name: [(year, value)]}}
    """
    log("=" * 60)
    log("DÉMARRAGE DE LA COLLECTE DES DONNÉES — World Bank API")
    log("=" * 60)

    all_data = defaultdict(dict)
    total = len(COUNTRIES) * len(INDICATORS)
    count = 0

    for code, country_name in COUNTRIES.items():
        for indicator_code, indicator_name in INDICATORS.items():
            count += 1
            log(f"[{count}/{total}] {country_name} — {indicator_name}")
            records = fetch_indicator(code, indicator_code, dry_run)
            all_data[indicator_name][country_name] = records

            # Sauvegarde JSON brute
            json_path = os.path.join(DATA_DIR, f"{code}_{indicator_code.replace('.', '_')}.json")
            with open(json_path, "w", encoding="utf-8") as jf:
                json.dump({"pays": country_name, "indicateur": indicator_name, "donnees": records}, jf, ensure_ascii=False, indent=2)

            if not dry_run:
                time.sleep(0.5)  # Respect rate limit API

    log("Collecte terminée.")
    return dict(all_data)


# ─────────────────────────────────────────────
#  EXPORT CSV
# ─────────────────────────────────────────────
def export_csv(all_data: dict):
    """Exporte chaque indicateur dans un fichier CSV séparé."""
    log("Export des données en CSV...")
    for indicator_name, country_data in all_data.items():
        csv_path = os.path.join(DATA_DIR, f"{indicator_name}.csv")
        with open(csv_path, "w", newline="", encoding="utf-8") as csvf:
            writer = csv.writer(csvf)
            writer.writerow(["Annee"] + list(country_data.keys()))

            # Collecte toutes les années
            all_years = sorted(set(
                year for records in country_data.values() for year, _ in records
            ))

            for year in all_years:
                row = [year]
                for country_name, records in country_data.items():
                    val_map = dict(records)
                    row.append(val_map.get(year, ""))
                writer.writerow(row)
        log(f"  → {csv_path}")


# ─────────────────────────────────────────────
#  GRAPHIQUES
# ─────────────────────────────────────────────
def get_latest_values(country_data: dict) -> dict:
    """Retourne la dernière valeur disponible par pays."""
    latest = {}
    for country, records in country_data.items():
        if records:
            latest[country] = records[-1][1]
    return latest


def plot_evolution(indicator_name: str, country_data: dict, title: str, ylabel: str):
    """Graphique d'évolution temporelle pour un indicateur."""
    fig, ax = plt.subplots(figsize=(12, 6))
    colors = plt.cm.Set2.colors

    for i, (country, records) in enumerate(country_data.items()):
        if not records:
            continue
        years  = [int(r[0]) for r in records]
        values = [r[1] for r in records]
        lw = 3 if country == "Cameroun" else 1.5
        ls = "-" if country == "Cameroun" else "--"
        ax.plot(years, values, label=country, color=colors[i % len(colors)],
                linewidth=lw, linestyle=ls, marker='o', markersize=3)

    ax.set_title(f"{title}\n(Source : World Bank API)", fontsize=14, fontweight='bold', pad=15)
    ax.set_xlabel("Année", fontsize=12)
    ax.set_ylabel(ylabel, fontsize=12)
    ax.legend(loc='best', fontsize=9)
    ax.grid(True, alpha=0.3)
    ax.xaxis.set_major_locator(mticker.MaxNLocator(integer=True))

    plt.tight_layout()
    path = os.path.join(OUTPUT_DIR, f"graph_{indicator_name}.png")
    plt.savefig(path, dpi=150, bbox_inches='tight')
    plt.close()
    log(f"  → Graphique sauvegardé : {path}")
    return path


def plot_bar_latest(indicator_name: str, country_data: dict, title: str, ylabel: str):
    """Graphique en barres — valeurs les plus récentes par pays."""
    latest = get_latest_values(country_data)
    if not latest:
        return None

    countries = list(latest.keys())
    values    = list(latest.values())
    colors    = ["#e74c3c" if c == "Cameroun" else "#3498db" for c in countries]

    fig, ax = plt.subplots(figsize=(10, 5))
    bars = ax.bar(countries, values, color=colors, edgecolor='white', linewidth=0.5)
    ax.bar_label(bars, fmt='%.1f', padding=3, fontsize=9)
    ax.set_title(f"{title} — Comparaison récente\n(Source : World Bank)", fontsize=13, fontweight='bold')
    ax.set_ylabel(ylabel, fontsize=11)
    ax.set_xlabel("Pays", fontsize=11)
    plt.xticks(rotation=20, ha='right')
    ax.grid(axis='y', alpha=0.3)

    # Légende couleurs
    from matplotlib.patches import Patch
    legend_elements = [Patch(facecolor='#e74c3c', label='Cameroun (focus)'),
                       Patch(facecolor='#3498db', label='Autres pays africains')]
    ax.legend(handles=legend_elements, loc='upper right', fontsize=9)

    plt.tight_layout()
    path = os.path.join(OUTPUT_DIR, f"bar_{indicator_name}.png")
    plt.savefig(path, dpi=150, bbox_inches='tight')
    plt.close()
    return path


def plot_heatmap(all_data: dict):
    """Heatmap des valeurs normalisées — tous indicateurs × tous pays."""
    log("Génération de la heatmap globale...")

    # Construction de la matrice pays × indicateurs
    matrix = {}
    labels_fr = {
        "PIB_par_habitant_USD":             "PIB/hab (USD)",
        "Esperance_de_vie_ans":             "Esp. vie (ans)",
        "Mortalite_infantile_pour_1000":    "Mort. infantile/1000",
        "Taux_alphabetisation_pct":         "Alphabétisation (%)",
        "Acces_electricite_pct":            "Électricité (%)",
        "Acces_internet_pct":              "Internet (%)",
    }

    for indicator_name, country_data in all_data.items():
        latest = get_latest_values(country_data)
        for country, val in latest.items():
            if country not in matrix:
                matrix[country] = {}
            matrix[country][labels_fr.get(indicator_name, indicator_name)] = val

    df = pd.DataFrame(matrix).T.fillna(0)

    # Normalisation 0–100 par colonne
    df_norm = (df - df.min()) / (df.max() - df.min() + 1e-9) * 100

    fig, ax = plt.subplots(figsize=(11, 7))
    sns.heatmap(df_norm, annot=df.round(1), fmt='g', cmap='YlOrRd',
                linewidths=0.5, linecolor='white', ax=ax,
                cbar_kws={'label': 'Score normalisé (0–100)'})

    ax.set_title("Tableau de bord IDH — Afrique subsaharienne\n"
                 "(valeurs réelles annotées, couleur = score normalisé)",
                 fontsize=13, fontweight='bold', pad=15)
    ax.set_xlabel("Indicateur", fontsize=11)
    ax.set_ylabel("Pays", fontsize=11)
    plt.xticks(rotation=25, ha='right', fontsize=9)
    plt.tight_layout()

    path = os.path.join(OUTPUT_DIR, "heatmap_idh.png")
    plt.savefig(path, dpi=150, bbox_inches='tight')
    plt.close()
    log(f"  → Heatmap : {path}")
    return path


# ─────────────────────────────────────────────
#  RAPPORT TEXTE
# ─────────────────────────────────────────────
def generate_rapport(all_data: dict):
    """Génère le rapport texte output/rapport.txt."""
    log("Génération du rapport texte...")
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    lines = [
        "=" * 65,
        "  RAPPORT — ANALYSE DU DÉVELOPPEMENT HUMAIN EN AFRIQUE",
        f"  Généré le : {now}",
        f"  Étudiant  : Frank Laurel | ID : 300143951",
        f"  Cours     : TSI — Collège Boréal",
        "=" * 65,
        "",
        f"  Pays analysés : {', '.join(COUNTRIES.values())}",
        f"  Indicateurs   : {len(INDICATORS)}",
        f"  Source        : World Bank Open Data API",
        "",
    ]

    label_map = {
        "PIB_par_habitant_USD":          ("PIB par habitant (USD)",       "USD"),
        "Esperance_de_vie_ans":          ("Espérance de vie",              "ans"),
        "Mortalite_infantile_pour_1000": ("Mortalité infantile (/ 1 000)", "‰"),
        "Taux_alphabetisation_pct":      ("Taux d'alphabétisation",        "%"),
        "Acces_electricite_pct":         ("Accès à l'électricité",        "%"),
        "Acces_internet_pct":           ("Accès à Internet",              "%"),
    }

    for indicator_name, country_data in all_data.items():
        label, unit = label_map.get(indicator_name, (indicator_name, ""))
        lines.append(f"{'─' * 65}")
        lines.append(f"  📊 {label}")
        lines.append(f"{'─' * 65}")

        latest = get_latest_values(country_data)
        if not latest:
            lines.append("  Aucune donnée disponible.")
            lines.append("")
            continue

        sorted_countries = sorted(latest.items(), key=lambda x: x[1], reverse=True)
        for rank, (country, val) in enumerate(sorted_countries, 1):
            marker = " ◀ FOCUS" if country == "Cameroun" else ""
            lines.append(f"  {rank:>2}. {country:<20} {val:>10.2f} {unit}{marker}")

        # Statistiques
        values = list(latest.values())
        lines.append("")
        lines.append(f"  Moyenne : {sum(values)/len(values):.2f} {unit}")
        lines.append(f"  Max     : {max(values):.2f} {unit}")
        lines.append(f"  Min     : {min(values):.2f} {unit}")
        lines.append("")

    lines += [
        "=" * 65,
        "  CONCLUSION",
        "=" * 65,
        "",
        "  Ce rapport présente une analyse comparative des indicateurs",
        "  de développement humain pour 8 pays d'Afrique subsaharienne.",
        "  Le Cameroun est mis en évidence comme pays de référence.",
        "",
        "  Les données proviennent exclusivement de l'API publique",
        "  de la Banque Mondiale (World Bank Open Data).",
        "",
        "  Pour les visualisations détaillées, consulter :",
        "  → output/graph_*.png     (évolutions temporelles)",
        "  → output/bar_*.png       (comparaisons récentes)",
        "  → output/heatmap_idh.png (tableau de bord global)",
        "  → RAPPORT.ipynb          (rapport interactif Jupyter)",
        "",
        "=" * 65,
    ]

    with open(RAPPORT_TXT, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))

    log(f"Rapport texte généré : {RAPPORT_TXT}")


# ─────────────────────────────────────────────
#  GRAPHIQUES — APPELS COMPLETS
# ─────────────────────────────────────────────
def generate_all_graphs(all_data: dict):
    """Génère tous les graphiques."""
    log("=" * 60)
    log("GÉNÉRATION DES GRAPHIQUES")
    log("=" * 60)

    graph_configs = {
        "PIB_par_habitant_USD":          ("PIB par habitant (USD)",       "USD"),
        "Esperance_de_vie_ans":          ("Espérance de vie",              "Années"),
        "Mortalite_infantile_pour_1000": ("Mortalité infantile / 1 000",  "Pour 1 000 naissances"),
        "Taux_alphabetisation_pct":      ("Taux d'alphabétisation",       "Pourcentage (%)"),
        "Acces_electricite_pct":         ("Accès à l'électricité",        "Pourcentage (%)"),
        "Acces_internet_pct":           ("Accès à Internet",             "Pourcentage (%)"),
    }

    for indicator_name, (title, ylabel) in graph_configs.items():
        country_data = all_data.get(indicator_name, {})
        if not country_data:
            continue
        log(f"Graphique : {title}")
        plot_evolution(indicator_name, country_data, title, ylabel)
        plot_bar_latest(indicator_name, country_data, title, ylabel)

    plot_heatmap(all_data)


# ─────────────────────────────────────────────
#  POINT D'ENTRÉE
# ─────────────────────────────────────────────
def main():
    parser = argparse.ArgumentParser(
        description="Analyse IDH Afrique — Frank Laurel 300143951"
    )
    parser.add_argument("--dry-run", action="store_true",
                        help="Mode test sans appels API réels")
    args = parser.parse_args()

    log("╔══════════════════════════════════════════════════════════╗")
    log("║   PROJET IDH AFRIQUE — Frank Laurel — ID: 300143951     ║")
    log("║   Collège Boréal — TSI — Session Hiver 2025             ║")
    log("╚══════════════════════════════════════════════════════════╝")

    if args.dry_run:
        log("MODE DRY-RUN ACTIVÉ — Données simulées", "WARN")

    # 1. Collecte des données
    all_data = collect_all_data(dry_run=args.dry_run)

    # 2. Export CSV
    export_csv(all_data)

    # 3. Graphiques
    generate_all_graphs(all_data)

    # 4. Rapport texte
    generate_rapport(all_data)

    log("=" * 60)
    log("✅ ANALYSE COMPLÈTE TERMINÉE AVEC SUCCÈS")
    log(f"   Rapport    : {RAPPORT_TXT}")
    log(f"   Graphiques : {OUTPUT_DIR}/graph_*.png")
    log(f"   Données    : {DATA_DIR}/")
    log("=" * 60)


if __name__ == "__main__":
    main()
