import requests
import time
from datetime import datetime

sites = [
    "https://www.google.com",
    "https://www.github.com",
    "https://www.wikipedia.org"
]

rapport = "output/rapport.txt"

with open(rapport, "w") as f:
    f.write(f"📊 Rapport Monitoring - {datetime.now()}\n")
    f.write("----------------------------------\n")

    for site in sites:
        try:
            debut = time.time()
            response = requests.get(site, timeout=5)
            duree = round(time.time() - debut, 2)
            statut = response.status_code
            f.write(f"✅ {site} - Status: {statut} - Temps: {duree}s\n")
        except Exception as e:
            f.write(f"❌ {site} - ERREUR: {e}\n")

print("✅ Rapport généré :", rapport)
