#!/usr/bin/env python3
# analyse.py - Scraper de nouvelles BBC

import re
import urllib.request
from collections import Counter
from datetime import datetime

# ========================
# Récupération des nouvelles
# ========================
url = "https://feeds.bbci.co.uk/news/rss.xml"
output_file = "output/rapport.txt"

print("📰 Récupération des nouvelles BBC...")

try:
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    response = urllib.request.urlopen(req, timeout=10)
    content = response.read().decode('utf-8')
except Exception as e:
    print(f"❌ Erreur connexion: {e}")
    content = ""

# ========================
# Extraction des titres
# ========================
titres = re.findall(r'<title><!\[CDATA\[(.*?)\]\]></title>', content)
if not titres:
    titres = re.findall(r'<title>(.*?)</title>', content)

# Supprimer le premier titre (nom du site)
if titres:
    titres = titres[1:21]

print(f"✅ {len(titres)} titres récupérés")

# ========================
# Analyse des mots fréquents
# ========================
tous_mots = []
stop_words = {'the','a','an','in','on','at','to','of','and','or',
              'is','are','was','were','for','with','by','from',
              'as','be','has','have','that','this','it','its',
              'will','been','not','but','he','she','they','we'}

for titre in titres:
    mots = re.findall(r'\b[a-zA-Z]{3,}\b', titre.lower())
    tous_mots.extend([m for m in mots if m not in stop_words])

top10 = Counter(tous_mots).most_common(10)

# ========================
# Génération du rapport
# ========================
now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

with open(output_file, "w") as f:
    f.write("=" * 50 + "\n")
    f.write("  RAPPORT SCRAPER BBC NEWS\n")
    f.write("=" * 50 + "\n")
    f.write(f"Date        : {now}\n")
    f.write(f"Source      : BBC News RSS\n")
    f.write(f"Titres      : {len(titres)}\n")
    f.write("=" * 50 + "\n\n")

    f.write("📰 TITRES RÉCUPÉRÉS :\n")
    f.write("-" * 50 + "\n")
    for i, titre in enumerate(titres, 1):
        f.write(f"{i:2}. {titre}\n")

    f.write("\n" + "=" * 50 + "\n")
    f.write("🔤 TOP 10 MOTS LES PLUS FRÉQUENTS :\n")
    f.write("-" * 50 + "\n")
    for mot, count in top10:
        bar = "█" * count
        f.write(f"{mot:<20} {bar} ({count})\n")

    f.write("\n" + "=" * 50 + "\n")
    f.write(f"✅ Rapport généré : {now}\n")

print(f"✅ Rapport généré : {output_file}")

# Afficher résumé
print("\n📊 TOP 10 MOTS :")
for mot, count in top10:
    print(f"  {mot:<20} ({count})")
