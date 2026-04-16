import requests
import time
import matplotlib.pyplot as plt
from datetime import datetime
import os

DATA_FILE = "data/sites.txt"
OUTPUT_DIR = "output"
REPORT_FILE = os.path.join(OUTPUT_DIR, "rapport.txt")
GRAPH_FILE = os.path.join(OUTPUT_DIR, "temps_reponse.png")

os.makedirs(OUTPUT_DIR, exist_ok=True)

sites = []
with open(DATA_FILE, "r", encoding="utf-8") as f:
    for line in f:
        line = line.strip()
        if line:
            sites.append(line)

resultats = []

for site in sites:
    try:
        start = time.time()
        response = requests.get(site, timeout=10)
        end = time.time()

        temps_reponse = round((end - start) * 1000, 2)
        code = response.status_code
        statut = "Disponible" if code == 200 else f"Code {code}"

        resultats.append({
            "site": site,
            "statut": statut,
            "code": code,
            "temps": temps_reponse
        })

    except Exception as e:
        resultats.append({
            "site": site,
            "statut": f"Erreur: {str(e)}",
            "code": 0,
            "temps": 0
        })

with open(REPORT_FILE, "w", encoding="utf-8") as f:
    f.write("RAPPORT DE SURVEILLANCE WEB\n")
    f.write("=" * 40 + "\n")
    f.write(f"Date: {datetime.now()}\n\n")

    for r in resultats:
        f.write(f"Site   : {r['site']}\n")
        f.write(f"Statut : {r['statut']}\n")
        f.write(f"Code   : {r['code']}\n")
        f.write(f"Temps  : {r['temps']} ms\n")
        f.write("-" * 40 + "\n")

sites_noms = [r["site"].replace("https://", "") for r in resultats]
temps = [r["temps"] for r in resultats]

plt.bar(sites_noms, temps)
plt.title("Temps de réponse des sites web")
plt.xlabel("Sites")
plt.ylabel("Temps (ms)")
plt.xticks(rotation=15)
plt.tight_layout()
plt.savefig(GRAPH_FILE)

print("Analyse terminée.")
