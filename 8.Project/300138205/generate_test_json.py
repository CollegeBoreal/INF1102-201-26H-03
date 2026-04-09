#!/usr/bin/env python3
import json
import os
from datetime import datetime, timedelta
import random

# ── Configuration ──
OUTPUT_FILE = os.path.join("data", "covid_data.json")
os.makedirs(os.path.dirname(OUTPUT_FILE), exist_ok=True)

# Liste de pays pour le test
countries_list = ["France", "Germany", "Italy", "Spain", "Portugal"]

# Génération des données globales
global_data = {
    "cases": 0,
    "deaths": 0,
    "recovered": 0,
    "active": 0
}

# Génération des données par pays
countries_data = []
for country in countries_list:
    cases = random.randint(1000, 100000)
    deaths = random.randint(0, int(cases*0.05))
    recovered = random.randint(0, cases-deaths)
    active = cases - deaths - recovered
    mortality_rate = round(deaths / cases * 100, 2) if cases > 0 else 0
    recovery_rate = round(recovered / cases * 100, 2) if cases > 0 else 0
    
    countries_data.append({
        "country": country,
        "cases": cases,
        "deaths": deaths,
        "casesPerMillion": cases * random.randint(10,50),
        "mortalityRate": mortality_rate,
        "recoveryRate": recovery_rate
    })
    
    global_data["cases"] += cases
    global_data["deaths"] += deaths
    global_data["recovered"] += recovered
    global_data["active"] += active

# Génération des données historiques (30 jours pour France)
historical_data = []
today = datetime.today()
for i in range(30):
    day = today - timedelta(days=29-i)
    daily_new = random.randint(50, 500)
    daily_deaths = random.randint(0, 10)
    historical_data.append({
        "date": day.strftime("%Y-%m-%d"),
        "daily_new": daily_new,
        "daily_deaths": daily_deaths
    })

# Création du JSON complet
data_json = {
    "metadata": {
        "source": "API fictive",
        "endpoint": "/covid",
        "extracted": datetime.today().strftime("%d/%m/%Y"),
        "pays": countries_list
    },
    "global": global_data,
    "countries": countries_data,
    "historical": historical_data
}

# Sauvegarde dans le fichier
with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
    json.dump(data_json, f, indent=2)

print(f"[OK] Fichier généré : {OUTPUT_FILE}")
