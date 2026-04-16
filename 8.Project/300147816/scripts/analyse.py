import sys
import json
import os
from datetime import datetime

def analyser():
    # On définit le chemin fixe vers le fichier JSON
    # Comme ton script est dans 'scripts/', on remonte d'un cran pour trouver 'data/'
    fichier = "data/air_quality.json"
    
    # Sécurité : on vérifie si le fichier existe
    if not os.path.exists(fichier):
        print(f"Erreur : Le fichier {fichier} est introuvable.")
        return

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

        # On s'assure que le dossier output existe
        if not os.path.exists('output'):
            os.makedirs('output')

        # Génération du rapport
        with open('output/rapport.txt', 'w') as out:
            out.write(f"RAPPORT QUALITÉ DE L'AIR - {tps}\n")
            out.write(f"Station : {ville}\n")
            out.write(f"Indice AQI : {aqi}\n")
            out.write(f"Diagnostic : {niveau}\n")
            
        print(f"Analyse réussie pour {ville} (AQI: {aqi})")

if __name__ == "__main__":
    # On appelle la fonction sans passer d'argument sys.argv
    analyser()
