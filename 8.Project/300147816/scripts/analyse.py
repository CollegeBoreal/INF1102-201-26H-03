import sys
import json
from datetime import datetime

def analyser(fichier):
    with open(fichier, 'r') as f:
        data = json.load(f)
    
    if data['status'] == 'ok':
        aqi = data['data']['aqi']
        ville = data['data']['city']['name']
        tps = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        
        # Logique de diagnostic
        if aqi <= 50: niveau = "Bon"
        elif aqi <= 100: niveau = "Modéré"
        else: niveau = "Insalubre"

        # Génération du livrable output/rapport.txt
        with open('output/rapport.txt', 'w') as out:
            out.write(f"RAPPORT QUALITÉ DE L'AIR - {tps}\n")
            out.write(f"Station : {ville}\n")
            out.write(f"Indice AQI : {aqi}\n")
            out.write(f"Diagnostic : {niveau}\n")
            
        print(f"Analyse réussie pour {ville} (AQI: {aqi})")

if __name__ == "__main__":
    analyser(sys.argv[1])
