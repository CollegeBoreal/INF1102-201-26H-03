import sys
import requests
import time
from datetime import datetime

def monitorer_site(url, output_file):
    resultats = []
    
    for i in range(5):
        try:
            debut = time.time()
            response = requests.get(url, timeout=10)
            duree = round(time.time() - debut, 2)
            resultats.append({
                'status': response.status_code,
                'duree': duree
            })
        except Exception as e:
            resultats.append({'status': 0, 'duree': 0})
        time.sleep(1)

    total = len(resultats)
    succes = len([r for r in resultats if r['status'] == 200])
    erreurs = total - succes
    temps_moyen = round(sum(r['duree'] for r in resultats) / total, 2)

    with open(output_file, 'w') as f:
        f.write(f"Rapport de monitoring - {datetime.now().date()}\n")
        f.write("-----------------------------------\n")
        f.write(f"Site surveillé : {url}\n")
        f.write(f"Total requêtes : {total}\n")
        f.write(f"Succès (200)   : {succes}\n")
        f.write(f"Erreurs        : {erreurs}\n")
        f.write(f"Temps moyen    : {temps_moyen}s\n")

    print("✅ Analyse terminée")

if __name__ == "__main__":
    output_file = sys.argv[2] if len(sys.argv) > 2 else "output/rapport.txt"
    monitorer_site("https://www.google.com", output_file)
