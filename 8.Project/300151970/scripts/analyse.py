#!/usr/bin/env python3
# =============================================================
# Etudiant  : Babatunde Adissa Fadolle Arouna | 300151970
# Hiver     : 2026
# Programme : Techniques des systemes informatiques
# Cours     : INF 1102-201 Programmation de systemes
# Professeur: Brice Robert
# -------------------------------------------------------------
# FICHIER    : scripts/analyse.py
# DESCRIPTION: Lit le JSON meteo de 3 villes canadiennes,
#              genere 4 graphiques et un rapport texte
# TERMINAL   : VM Ubuntu via SSH
# COMMANDE   : python3 scripts/analyse.py data/meteo_raw.json output/rapport.txt
# =============================================================

import sys
import json
import os
import datetime
import matplotlib
matplotlib.use('Agg')  # Mode sans ecran (VM sans interface graphique)
import matplotlib.pyplot as plt
import numpy as np


# =============================================================
# FONCTION : Chargement et extraction des donnees JSON
# =============================================================
def charger_donnees(json_path):
    """Charge le fichier JSON et extrait les donnees des 3 villes."""
    with open(json_path, 'r', encoding='utf-8') as f:
        data = json.load(f)
    return data["villes"]


def extraire_meteo(villes_data):
    """Extrait et retourne les donnees meteo sous forme de listes."""
    return {
        "villes"        : [v["name"] for v in villes_data],
        "temps"         : [v["main"]["temp"] for v in villes_data],
        "temp_min"      : [v["main"]["temp_min"] for v in villes_data],
        "temp_max"      : [v["main"]["temp_max"] for v in villes_data],
        "temp_ressentie": [v["main"]["feels_like"] for v in villes_data],
        "humidites"     : [v["main"]["humidity"] for v in villes_data],
        "pressions"     : [v["main"]["pressure"] for v in villes_data],
        "nuages"        : [v["clouds"]["all"] for v in villes_data],
        "vents"         : [round(v["wind"]["speed"] * 3.6, 1) for v in villes_data],
        "conditions"    : [v["weather"][0]["description"].capitalize() for v in villes_data],
        "visibilite"    : [v.get("visibility", 0) / 1000 for v in villes_data],
        "lever"         : [datetime.datetime.fromtimestamp(v["sys"]["sunrise"]).strftime("%H:%M")
                           for v in villes_data],
        "coucher"       : [datetime.datetime.fromtimestamp(v["sys"]["sunset"]).strftime("%H:%M")
                           for v in villes_data],
    }


# =============================================================
# GRAPHIQUE 1 : Diagramme en bandes - Temperatures des 3 villes
# =============================================================
def graphique_barres_temperatures(m, output_dir):
    """Genere un diagramme en bandes comparant les temperatures des 3 villes."""
    fig, ax = plt.subplots(figsize=(11, 6))
    x     = np.arange(len(m["villes"]))
    width = 0.2

    # 4 series de barres cote a cote pour chaque ville
    b1 = ax.bar(x - width*1.5, m["temps"],          width, label='Actuelle',  color='#FF6B6B', edgecolor='black')
    b2 = ax.bar(x - width*0.5, m["temp_ressentie"], width, label='Ressentie', color='#FFA07A', edgecolor='black')
    b3 = ax.bar(x + width*0.5, m["temp_min"],       width, label='Minimale',  color='#87CEEB', edgecolor='black')
    b4 = ax.bar(x + width*1.5, m["temp_max"],       width, label='Maximale',  color='#FF4500', edgecolor='black')

    # Affichage des valeurs sur les barres
    for bars in [b1, b2, b3, b4]:
        for bar in bars:
            ax.text(bar.get_x() + bar.get_width()/2,
                    bar.get_height() + 0.2,
                    f'{bar.get_height():.1f}',
                    ha='center', va='bottom', fontsize=8, fontweight='bold')

    ax.set_title('Comparaison des temperatures - Toronto, Montreal, Vancouver',
                 fontsize=13, fontweight='bold')
    ax.set_ylabel('Temperature (C)')
    ax.set_xticks(x)
    ax.set_xticklabels(m["villes"], fontsize=12)
    ax.axhline(y=0, color='black', linestyle='--', linewidth=0.8)
    ax.legend()
    ax.set_ylim(0, max(m["temp_max"]) + 5)
    plt.tight_layout()

    path = os.path.join(output_dir, 'graph_barres_temperatures.png')
    plt.savefig(path, dpi=150)
    plt.close()
    print(f"Graphique 1 OK : {path}")


# =============================================================
# GRAPHIQUE 2 : Diagramme en bandes - Humidite, Nuages, Vent
# =============================================================
def graphique_barres_humidite_vent(m, output_dir):
    """Genere un diagramme en bandes comparant humidite, nuages et vent."""
    fig, ax = plt.subplots(figsize=(11, 6))
    x2     = np.arange(len(m["villes"]))
    width2 = 0.25

    b5 = ax.bar(x2 - width2, m["humidites"], width2, label='Humidite (%)', color='#4FC3F7', edgecolor='black')
    b6 = ax.bar(x2,          m["nuages"],    width2, label='Nuages (%)',   color='#B0BEC5', edgecolor='black')
    b7 = ax.bar(x2 + width2, m["vents"],     width2, label='Vent (km/h)', color='#81C784', edgecolor='black')

    for bars in [b5, b6, b7]:
        for bar in bars:
            ax.text(bar.get_x() + bar.get_width()/2,
                    bar.get_height() + 0.5,
                    f'{bar.get_height():.0f}',
                    ha='center', va='bottom', fontsize=8, fontweight='bold')

    ax.set_title('Comparaison Humidite, Nuages et Vent - 3 villes',
                 fontsize=13, fontweight='bold')
    ax.set_ylabel('Valeur')
    ax.set_xticks(x2)
    ax.set_xticklabels(m["villes"], fontsize=12)
    ax.legend()
    ax.set_ylim(0, max(m["humidites"] + m["nuages"] + m["vents"]) * 1.25)
    plt.tight_layout()

    path = os.path.join(output_dir, 'graph_barres_humidite_vent.png')
    plt.savefig(path, dpi=150)
    plt.close()
    print(f"Graphique 2 OK : {path}")


# =============================================================
# GRAPHIQUE 3 : Diagramme circulaire - Humidite des 3 villes
# =============================================================
def graphique_circulaire_humidite(m, output_dir):
    """Genere un diagramme circulaire de la repartition de l humidite."""
    fig, ax = plt.subplots(figsize=(7, 7))
    labels  = [f'{v}\n{h}%' for v, h in zip(m["villes"], m["humidites"])]
    couleurs= ['#FF6B6B', '#4FC3F7', '#81C784']

    wedges, texts, auto = ax.pie(
        m["humidites"],
        labels=labels,
        colors=couleurs,
        explode=(0.05, 0.05, 0.05),
        autopct='%1.1f%%',
        startangle=90,
        textprops={'fontsize': 12}
    )
    for a in auto:
        a.set_fontweight('bold')

    ax.set_title('Repartition de l humidite\nToronto vs Montreal vs Vancouver',
                 fontsize=13, fontweight='bold')
    plt.tight_layout()

    path = os.path.join(output_dir, 'graph_circulaire_humidite.png')
    plt.savefig(path, dpi=150)
    plt.close()
    print(f"Graphique 3 OK : {path}")


# =============================================================
# GRAPHIQUE 4 : Diagramme circulaire - Couverture nuageuse
# =============================================================
def graphique_circulaire_nuages(m, output_dir):
    """Genere un diagramme circulaire de la couverture nuageuse."""
    fig, ax = plt.subplots(figsize=(7, 7))
    labels  = [f'{v}\n{n}%' for v, n in zip(m["villes"], m["nuages"])]
    couleurs= ['#FF6B6B', '#4FC3F7', '#81C784']

    # Eviter le cas ou tous les nuages sont a 0
    nuages_safe = [max(n, 1) for n in m["nuages"]]

    wedges, texts, auto = ax.pie(
        nuages_safe,
        labels=labels,
        colors=couleurs,
        explode=(0.05, 0.05, 0.05),
        autopct='%1.1f%%',
        startangle=90,
        textprops={'fontsize': 12}
    )
    for a in auto:
        a.set_fontweight('bold')

    ax.set_title('Repartition de la couverture nuageuse\nToronto vs Montreal vs Vancouver',
                 fontsize=13, fontweight='bold')
    plt.tight_layout()

    path = os.path.join(output_dir, 'graph_circulaire_nuages.png')
    plt.savefig(path, dpi=150)
    plt.close()
    print(f"Graphique 4 OK : {path}")


# =============================================================
# RAPPORT TEXTE : Generation du fichier output/rapport.txt
# =============================================================
def generer_rapport(m, villes_data, rapport_path):
    """Genere le rapport texte complet dans output/rapport.txt."""
    lignes = [
        "=" * 60,
        "  RAPPORT METEO - 3 GRANDES VILLES DU CANADA",
        "=" * 60,
        "  Etudiant   : Babatunde Adissa Fadolle Arouna | 300151970",
        "  Hiver      : 2026",
        "  Programme  : Techniques des systemes informatiques",
        "  Cours      : INF 1102-201 Programmation de systemes",
        "  Professeur : Brice Robert",
        "=" * 60,
        f"  Date       : {datetime.datetime.now().strftime('%d/%m/%Y a %H:%M')}",
        "=" * 60,
        "",
    ]

    # Details pour chaque ville
    for i, v in enumerate(m["villes"]):
        lignes += [
            f"--- {v.upper()} ---",
            f"  Condition    : {m['conditions'][i]}",
            f"  Temperature  : {m['temps'][i]:.1f} C  (ressentie : {m['temp_ressentie'][i]:.1f} C)",
            f"  Min / Max    : {m['temp_min'][i]:.1f} C / {m['temp_max'][i]:.1f} C",
            f"  Humidite     : {m['humidites'][i]} %",
            f"  Pression     : {m['pressions'][i]} hPa",
            f"  Vent         : {m['vents'][i]} km/h",
            f"  Nuages       : {m['nuages'][i]} %",
            f"  Visibilite   : {m['visibilite'][i]:.1f} km",
            f"  Lever soleil : {m['lever'][i]}",
            f"  Coucher      : {m['coucher'][i]}",
            "",
        ]

    # Graphiques generes
    lignes += [
        "--- GRAPHIQUES GENERES ---",
        "  1. graph_barres_temperatures.png    (diagramme en bandes)",
        "  2. graph_barres_humidite_vent.png   (diagramme en bandes)",
        "  3. graph_circulaire_humidite.png    (diagramme circulaire)",
        "  4. graph_circulaire_nuages.png      (diagramme circulaire)",
        "",
        "--- INTERPRETATION ---",
        f"  Ville la plus chaude   : {m['villes'][m['temps'].index(max(m['temps']))]} ({max(m['temps'])} C)",
        f"  Ville la plus froide   : {m['villes'][m['temps'].index(min(m['temps']))]} ({min(m['temps'])} C)",
        f"  Ville la plus humide   : {m['villes'][m['humidites'].index(max(m['humidites']))]} ({max(m['humidites'])} %)",
        f"  Ville la plus nuageuse : {m['villes'][m['nuages'].index(max(m['nuages']))]} ({max(m['nuages'])} %)",
        f"  Vent le plus fort      : {m['villes'][m['vents'].index(max(m['vents']))]} ({max(m['vents'])} km/h)",
        "",
        "=" * 60,
        "  Source : OpenWeatherMap (api.openweathermap.org)",
        "  Genere automatiquement par analyse.py",
        "=" * 60,
    ]

    with open(rapport_path, 'w', encoding='utf-8') as f:
        f.write("\n".join(lignes))

    print(f"Rapport sauvegarde : {rapport_path}")
    print("\n" + "\n".join(lignes))


# =============================================================
# PROGRAMME PRINCIPAL
# =============================================================
def main():
    # Validation des arguments
    if len(sys.argv) < 3:
        print("Usage : python3 analyse.py <json> <rapport>")
        sys.exit(1)

    json_path    = sys.argv[1]
    rapport_path = sys.argv[2]
    output_dir   = os.path.dirname(rapport_path)
    os.makedirs(output_dir, exist_ok=True)

    if not os.path.exists(json_path):
        print(f"ERREUR : fichier JSON introuvable : {json_path}")
        sys.exit(1)

    print("\n[Python] Chargement des donnees JSON...")
    villes_data = charger_donnees(json_path)
    m           = extraire_meteo(villes_data)

    print(f"[Python] Villes chargees : {', '.join(m['villes'])}")
    for i, v in enumerate(m["villes"]):
        print(f"  {v:<12} : {m['temps'][i]} C | {m['humidites'][i]}% humidite | {m['conditions'][i]}")

    print("\n[Python] Generation des graphiques...")
    graphique_barres_temperatures(m, output_dir)
    graphique_barres_humidite_vent(m, output_dir)
    graphique_circulaire_humidite(m, output_dir)
    graphique_circulaire_nuages(m, output_dir)

    print("\n[Python] Generation du rapport texte...")
    generer_rapport(m, villes_data, rapport_path)

    print("\n[Python] Analyse complete.")


if __name__ == "__main__":
    main()
