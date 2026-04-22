#!/usr/bin/env python3
# ============================================
# Projet 5 - Monitoring de site web
# Script Python : analyse des données du log
# ============================================

import sys
import re
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from collections import Counter

def lire_log(fichier):
    """Lit le fichier log et retourne les entrées parsées."""
    entrees = []
    with open(fichier, 'r') as f:
        for ligne in f:
            # Format : DATE | URL: ... | CODE: ... | TEMPS: ...s
            match = re.search(
                r'(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}).*CODE: (\d+).*TEMPS: ([\d.]+)',
                ligne
            )
            if match:
                entrees.append({
                    'date': match.group(1),
                    'code': int(match.group(2)),
                    'temps': float(match.group(3))
                })
    return entrees

def analyser(entrees):
    """Calcule les statistiques."""
    if not entrees:
        return None
    temps = [e['temps'] for e in entrees]
    codes = [e['code'] for e in entrees]
    return {
        'total': len(entrees),
        'ok': codes.count(200),
        'erreurs': len([c for c in codes if c != 200]),
        'moy': round(sum(temps) / len(temps), 3),
        'min': round(min(temps), 3),
        'max': round(max(temps), 3),
        'codes': dict(Counter(codes))
    }

def generer_rapport(stats, fichier_out):
    """Écrit le rapport texte."""
    with open(fichier_out, 'w') as f:
        f.write("=== RAPPORT DE MONITORING ===\n\n")
        f.write(f"Vérifications totales : {stats['total']}\n")
        f.write(f"Réponses OK (200)     : {stats['ok']}\n")
        f.write(f"Erreurs               : {stats['erreurs']}\n")
        f.write(f"Temps moyen           : {stats['moy']} s\n")
        f.write(f"Temps minimum         : {stats['min']} s\n")
        f.write(f"Temps maximum         : {stats['max']} s\n")
        f.write(f"\nCodes HTTP détectés   : {stats['codes']}\n")
        if stats['erreurs'] > 0:
            f.write("\nALERTE : Des erreurs ont été détectées !\n")
    print(f"Rapport écrit dans {fichier_out}")

def generer_graphique(entrees):
    """Génère un graphique du temps de réponse."""
    temps = [e['temps'] for e in entrees]
    labels = [e['date'][-8:] for e in entrees]  # heure seulement
    plt.figure(figsize=(10, 4))
    plt.plot(range(len(temps)), temps, marker='o', color='steelblue', linewidth=1.5)
    plt.xticks(range(len(labels)), labels, rotation=45, fontsize=8)
    plt.ylabel('Temps de réponse (s)')
    plt.title('Évolution du temps de réponse')
    plt.tight_layout()
    plt.savefig('output/graphique.png')
    print("Graphique sauvegardé dans output/graphique.png")

# ---- Point d'entrée ----
if __name__ == '__main__':
    log_file = sys.argv[1] if len(sys.argv) > 1 else 'data/sample.log'
    rapport_file = sys.argv[2] if len(sys.argv) > 2 else 'output/rapport.txt'

    entrees = lire_log(log_file)
    if not entrees:
        print("Aucune donnée trouvée dans le log.")
        sys.exit(1)

    stats = analyser(entrees)
    generer_rapport(stats, rapport_file)
    generer_graphique(entrees)

    print(f"\nAnalyse terminée : {stats['total']} entrée(s) traitée(s).")
