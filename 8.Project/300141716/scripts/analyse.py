from datetime import date

rapport = f"""Projet : Suivi du prix de l'essence à Toronto

Date : {date.today()}

Ville suivie : Toronto
Prix essence : à compléter avec la source officielle
Prix du Brent : à compléter
Contexte :
- tensions au Moyen-Orient
- hausse récente du pétrole
- impact possible sur les prix locaux

Conclusion :
Les événements géopolitiques peuvent influencer le prix mondial du pétrole,
ce qui peut avoir un impact sur les prix de l'essence à Toronto.
"""

with open("output/rapport.txt", "w", encoding="utf-8") as f:
    f.write(rapport)

print("Rapport généré dans output/rapport.txt")