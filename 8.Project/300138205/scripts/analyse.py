#!/usr/bin/env python3
"""
analyse.py - Analyse des données COVID-19
Génère graphiques et statistiques à partir du JSON produit par analyse.ps1
"""

import json
import os
import sys
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as mticker
import seaborn as sns
from datetime import datetime

# ── Configuration ──────────────────────────────────────────────
DATA_FILE   = os.path.join(os.path.dirname(__file__), "..", "data", "covid_data.json")
OUTPUT_DIR  = os.path.join(os.path.dirname(__file__), "..", "output")
os.makedirs(OUTPUT_DIR, exist_ok=True)

PALETTE     = ["#E63946", "#457B9D", "#2A9D8F", "#E9C46A", "#F4A261"]
plt.rcParams.update({
    "font.family":     "DejaVu Sans",
    "figure.dpi":      150,
    "axes.spines.top": False,
    "axes.spines.right": False,
})

# ── Chargement ────────────────────────────────────────────────
print("\n=== ANALYSE COVID-19 ===")
print(f"Chargement : {DATA_FILE}")

with open(DATA_FILE, encoding="utf-8") as f:
    raw = json.load(f)

meta       = raw["metadata"]
global_d   = raw["global"]
df_pays    = pd.DataFrame(raw["countries"])
df_hist    = pd.DataFrame(raw["historical"])
df_hist["date"] = pd.to_datetime(df_hist["date"])
df_hist     = df_hist.sort_values("date")

print(f"Source      : {meta['source']}")
print(f"Extraction  : {meta['extracted']}")
print(f"Pays        : {', '.join(meta['pays'])}")

# ── Fonctions utilitaires ─────────────────────────────────────
def fmt(n):
    return f"{n:,.0f}".replace(",", " ")

def save_fig(name):
    path = os.path.join(OUTPUT_DIR, name)
    plt.savefig(path, bbox_inches="tight", facecolor="white")
    plt.close()
    print(f"  [OK] Graphique sauvegardé : {path}")
    return path

# ═══════════════════════════════════════════════════════════════
# GRAPHIQUE 1 — Cas confirmés par pays (barres horizontales)
# ═══════════════════════════════════════════════════════════════
print("\n[1/5] Cas confirmés par pays...")
fig, ax = plt.subplots(figsize=(10, 5))
df_s = df_pays.sort_values("cases")
bars = ax.barh(df_s["country"], df_s["cases"] / 1e6, color=PALETTE[:len(df_s)], edgecolor="white", height=0.6)
for bar, val in zip(bars, df_s["cases"] / 1e6):
    ax.text(bar.get_width() + 0.3, bar.get_y() + bar.get_height() / 2,
            f"{val:.1f} M", va="center", fontsize=9)
ax.set_xlabel("Cas confirmés (en millions)", fontsize=11)
ax.set_title("Cas COVID-19 confirmés par pays", fontsize=14, fontweight="bold", pad=15)
ax.xaxis.set_major_formatter(mticker.FuncFormatter(lambda x, _: f"{x:.0f} M"))
ax.set_xlim(0, df_s["cases"].max() / 1e6 * 1.15)
plt.tight_layout()
save_fig("graphique_01_cas_par_pays.png")

# ═══════════════════════════════════════════════════════════════
# GRAPHIQUE 2 — Décès par pays
# ═══════════════════════════════════════════════════════════════
print("[2/5] Décès par pays...")
fig, ax = plt.subplots(figsize=(10, 5))
df_s = df_pays.sort_values("deaths", ascending=False)
ax.bar(df_s["country"], df_s["deaths"] / 1e3, color=PALETTE[:len(df_s)], edgecolor="white", width=0.6)
for i, (_, row) in enumerate(df_s.iterrows()):
    ax.text(i, row["deaths"] / 1e3 + 5, f"{row['deaths']/1e3:.0f}k", ha="center", fontsize=9)
ax.set_ylabel("Décès (en milliers)", fontsize=11)
ax.set_title("Décès COVID-19 par pays", fontsize=14, fontweight="bold", pad=15)
ax.yaxis.set_major_formatter(mticker.FuncFormatter(lambda x, _: f"{x:.0f}k"))
plt.tight_layout()
save_fig("graphique_02_deces_par_pays.png")

# ═══════════════════════════════════════════════════════════════
# GRAPHIQUE 3 — Taux de mortalité et guérison (double axe)
# ═══════════════════════════════════════════════════════════════
print("[3/5] Taux de mortalité et de guérison...")
fig, ax1 = plt.subplots(figsize=(10, 5))
x = range(len(df_pays))
labels = df_pays["country"].tolist()
w = 0.35

bars1 = ax1.bar([i - w/2 for i in x], df_pays["mortalityRate"], width=w,
                color="#E63946", label="Taux de mortalité (%)", alpha=0.85)
ax2 = ax1.twinx()
bars2 = ax2.bar([i + w/2 for i in x], df_pays["recoveryRate"], width=w,
                color="#2A9D8F", label="Taux de guérison (%)", alpha=0.85)

ax1.set_xticks(list(x)); ax1.set_xticklabels(labels, fontsize=10)
ax1.set_ylabel("Mortalité (%)", color="#E63946", fontsize=11)
ax2.set_ylabel("Guérison (%)", color="#2A9D8F", fontsize=11)
ax1.set_title("Taux de mortalité vs taux de guérison par pays",
              fontsize=14, fontweight="bold", pad=15)
lines1, labels1 = ax1.get_legend_handles_labels()
lines2, labels2 = ax2.get_legend_handles_labels()
ax1.legend(lines1 + lines2, labels1 + labels2, loc="lower right", fontsize=9)
plt.tight_layout()
save_fig("graphique_03_taux_mortalite_guerison.png")

# ═══════════════════════════════════════════════════════════════
# GRAPHIQUE 4 — Évolution historique France
# ═══════════════════════════════════════════════════════════════
print("[4/5] Évolution historique - France...")
fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(12, 8), sharex=True)
fig.suptitle("Évolution COVID-19 en France (30 derniers jours)",
             fontsize=14, fontweight="bold", y=1.01)

ax1.fill_between(df_hist["date"], df_hist["daily_new"],
                 alpha=0.4, color="#457B9D", label="Nouveaux cas")
ax1.plot(df_hist["date"], df_hist["daily_new"],
         color="#457B9D", linewidth=2, marker="o", markersize=3)
ax1.set_ylabel("Nouveaux cas / jour", fontsize=10)
ax1.yaxis.set_major_formatter(mticker.FuncFormatter(lambda x, _: f"{x:,.0f}"))
ax1.legend(fontsize=9)
ax1.grid(axis="y", alpha=0.3)

ax2.fill_between(df_hist["date"], df_hist["daily_deaths"],
                 alpha=0.4, color="#E63946", label="Nouveaux décès")
ax2.plot(df_hist["date"], df_hist["daily_deaths"],
         color="#E63946", linewidth=2, marker="o", markersize=3)
ax2.set_ylabel("Décès / jour", fontsize=10)
ax2.set_xlabel("Date", fontsize=10)
ax2.legend(fontsize=9)
ax2.grid(axis="y", alpha=0.3)
fig.autofmt_xdate(rotation=30)
plt.tight_layout()
save_fig("graphique_04_evolution_france.png")

# ═══════════════════════════════════════════════════════════════
# GRAPHIQUE 5 — Cas pour 1 million d'habitants (comparaison normalisée)
# ═══════════════════════════════════════════════════════════════
print("[5/5] Cas pour 1 million d'habitants...")
fig, ax = plt.subplots(figsize=(10, 5))
df_s = df_pays.sort_values("casesPerMillion", ascending=False)
colors = [PALETTE[i % len(PALETTE)] for i in range(len(df_s))]
bars = ax.bar(df_s["country"], df_s["casesPerMillion"], color=colors, edgecolor="white", width=0.6)
for bar, val in zip(bars, df_s["casesPerMillion"]):
    ax.text(bar.get_x() + bar.get_width() / 2, bar.get_height() + 500,
            f"{val:,.0f}", ha="center", fontsize=9)
ax.set_ylabel("Cas pour 1 million d'habitants", fontsize=11)
ax.set_title("Impact relatif par pays (cas / million d'habitants)",
             fontsize=14, fontweight="bold", pad=15)
ax.yaxis.set_major_formatter(mticker.FuncFormatter(lambda x, _: f"{x:,.0f}"))
plt.tight_layout()
save_fig("graphique_05_cas_par_million.png")

# ═══════════════════════════════════════════════════════════════
# RAPPORT TEXTE
# ═══════════════════════════════════════════════════════════════
print("\nGénération du rapport texte...")
rapport_path = os.path.join(OUTPUT_DIR, "rapport.txt")
ts = datetime.now().strftime("%d/%m/%Y à %H:%M")

with open(rapport_path, "w", encoding="utf-8") as f:
    f.write("=" * 65 + "\n")
    f.write("        RAPPORT D'ANALYSE — DONNÉES COVID-19\n")
    f.write(f"        Généré le {ts}\n")
    f.write("=" * 65 + "\n\n")

    f.write("SOURCE DES DONNÉES\n")
    f.write("-" * 40 + "\n")
    f.write(f"  API       : {meta['source']}\n")
    f.write(f"  Endpoint  : {meta['endpoint']}\n")
    f.write(f"  Extraction: {meta['extracted']}\n\n")

    f.write("STATISTIQUES MONDIALES\n")
    f.write("-" * 40 + "\n")
    f.write(f"  Cas confirmés  : {fmt(global_d['cases'])}\n")
    f.write(f"  Décès          : {fmt(global_d['deaths'])}\n")
    f.write(f"  Guérisons      : {fmt(global_d['recovered'])}\n")
    f.write(f"  Cas actifs     : {fmt(global_d['active'])}\n")
    mort_mondiale = round(global_d['deaths'] / global_d['cases'] * 100, 2)
    f.write(f"  Létalité monde : {mort_mondiale} %\n\n")

    f.write("STATISTIQUES PAR PAYS\n")
    f.write("-" * 40 + "\n")
    header = f"  {'Pays':<12} {'Cas':>12} {'Décès':>10} {'Létalité':>10} {'Guérison':>10}\n"
    f.write(header)
    f.write("  " + "-" * 58 + "\n")
    for _, row in df_pays.sort_values("cases", ascending=False).iterrows():
        f.write(f"  {row['country']:<12} {fmt(row['cases']):>12} "
                f"{fmt(row['deaths']):>10} {row['mortalityRate']:>9.2f}% "
                f"{row['recoveryRate']:>9.2f}%\n")

    f.write("\nANALYSE — FRANCE (30 DERNIERS JOURS)\n")
    f.write("-" * 40 + "\n")
    f.write(f"  Période    : {df_hist['date'].min().strftime('%d/%m/%Y')} → "
            f"{df_hist['date'].max().strftime('%d/%m/%Y')}\n")
    f.write(f"  Moy. cas/j : {df_hist['daily_new'].mean():,.0f}\n")
    f.write(f"  Max cas/j  : {df_hist['daily_new'].max():,.0f} "
            f"({df_hist.loc[df_hist['daily_new'].idxmax(), 'date'].strftime('%d/%m/%Y')})\n")
    f.write(f"  Moy. décès : {df_hist['daily_deaths'].mean():,.0f}\n")
    f.write(f"  Total décès: {df_hist['daily_deaths'].sum():,}\n")

    f.write("\nCONCLUSIONS\n")
    f.write("-" * 40 + "\n")
    top = df_pays.sort_values("cases", ascending=False).iloc[0]
    low = df_pays.sort_values("mortalityRate").iloc[0]
    f.write(f"  • Pays le plus touché en valeur absolue : {top['country']} "
            f"({fmt(top['cases'])} cas)\n")
    f.write(f"  • Pays avec le plus faible taux de létalité : {low['country']} "
            f"({low['mortalityRate']}%)\n")
    f.write(f"  • Létalité mondiale : {mort_mondiale}%\n")
    f.write(f"  • 5 graphiques générés dans : output/\n")
    f.write("\n" + "=" * 65 + "\n")

print(f"  [OK] Rapport sauvegardé : {rapport_path}")

# ── Résumé console ────────────────────────────────────────────
print("\n" + "="*50)
print("  ANALYSE TERMINÉE")
print(f"  Pays analysés     : {len(df_pays)}")
print(f"  Graphiques créés  : 5")
print(f"  Rapport texte     : output/rapport.txt")
print("="*50 + "\n")
