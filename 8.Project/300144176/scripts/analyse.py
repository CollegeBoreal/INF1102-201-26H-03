# ============================================================
# analyse.py - Analyse des données météo (Weatherstack)
# Description : Lit le fichier JSON météo, génère statistiques,
#               un graphique et un rapport texte.
# Usage       : python3 scripts/analyse.py data/meteo.json
# ============================================================

import sys
import json
import os
from datetime import datetime
import matplotlib.pyplot as plt

# --- Vérification des arguments ---
if len(sys.argv) < 2:
    print("❌ Usage : python3 analyse.py <fichier_json>")
    sys.exit(1)

json_file = sys.argv[1]

if not os.path.exists(json_file):
    print(f"❌ Fichier introuvable : {json_file}")
    sys.exit(1)

# --- Chargement des données JSON ---
with open(json_file, encoding="utf-8-sig") as f:
    data = json.load(f)

# --- Extraction des informations (structure Weatherstack) ---
location    = data.get("location", {})
current     = data.get("current", {})

ville       = location.get("name", "Inconnue")
pays        = location.get("country", "??")
heure_locale = location.get("localtime", "??")

temp        = current.get("temperature", 0)
ressenti    = current.get("feelslike", 0)
humidite    = current.get("humidity", 0)
vitesse_vent = current.get("wind_speed", 0)
direction_vent = current.get("wind_dir", "??")
pression    = current.get("pressure", 0)
visibilite  = current.get("visibility", 0)
nuages      = current.get("cloudcover", 0)
uv_index    = current.get("uv_index", 0)
description = current.get("weather_descriptions", ["??"])[0]

horodatage  = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

# --- Affichage console ---
print("=" * 55)
print(f"📍 Ville         : {ville}, {pays}")
print(f"🗓️  Date/Heure   : {horodatage}")
print(f"🕐 Heure locale  : {heure_locale}")
print(f"🌡️  Température  : {temp} °C (ressenti {ressenti} °C)")
print(f"💧 Humidité      : {humidite} %")
print(f"🌬️  Vent          : {vitesse_vent} km/h ({direction_vent})")
print(f"🌥️  Nuages        : {nuages} %")
print(f"👁️  Visibilité    : {visibilite} km")
print(f"🔵 Pression      : {pression} hPa")
print(f"☀️  Indice UV     : {uv_index}")
print(f"📝 Conditions    : {description}")
print("=" * 55)

# --- Génération du rapport texte ---
output_dir = os.path.join(os.path.dirname(json_file), "..", "output")
os.makedirs(output_dir, exist_ok=True)
rapport_path = os.path.join(output_dir, "rapport.txt")

with open(rapport_path, "w", encoding="utf-8") as f:
    f.write("=" * 55 + "\n")
    f.write(f"  RAPPORT MÉTÉO — {ville}, {pays}\n")
    f.write("=" * 55 + "\n")
    f.write(f"Date analyse   : {horodatage}\n")
    f.write(f"Heure locale   : {heure_locale}\n")
    f.write(f"Conditions     : {description}\n")
    f.write(f"Température    : {temp} °C (ressenti {ressenti} °C)\n")
    f.write(f"Humidité       : {humidite} %\n")
    f.write(f"Vent           : {vitesse_vent} km/h ({direction_vent})\n")
    f.write(f"Nuages         : {nuages} %\n")
    f.write(f"Visibilité     : {visibilite} km\n")
    f.write(f"Pression       : {pression} hPa\n")
    f.write(f"Indice UV      : {uv_index}\n")
    f.write("=" * 55 + "\n")

print(f"\n✅ Rapport texte sauvegardé : {rapport_path}")

# --- Génération du graphique ---
labels  = ["Temp\n(°C)", "Ressenti\n(°C)", "Humidité\n(%)", "Vent\n(km/h)", "Nuages\n(%)", "UV"]
valeurs = [temp, ressenti, humidite, vitesse_vent, nuages, uv_index]
couleurs = ["#FF6B6B", "#FFA07A", "#4FC3F7", "#81C784", "#B0BEC5", "#FFD54F"]

fig, ax = plt.subplots(figsize=(10, 5))
bars = ax.bar(labels, valeurs, color=couleurs, edgecolor="white", linewidth=1.3)

for bar, val in zip(bars, valeurs):
    ax.text(
        bar.get_x() + bar.get_width() / 2,
        bar.get_height() + 0.5,
        str(val),
        ha="center", va="bottom", fontsize=11, fontweight="bold"
    )

ax.set_title(f"Météo actuelle — {ville}, {pays}\n{description} | {horodatage}", fontsize=13, fontweight="bold")
ax.set_ylabel("Valeur")
ax.set_ylim(0, max(valeurs) * 1.3)
ax.grid(axis="y", linestyle="--", alpha=0.4)
plt.tight_layout()

graph_path = os.path.join(output_dir, "meteo.png")
plt.savefig(graph_path, dpi=150)
print(f"📊 Graphique sauvegardé : {graph_path}")
plt.show()
