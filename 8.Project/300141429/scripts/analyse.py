import requests
from bs4 import BeautifulSoup
from collections import Counter
import json
import re

url = "https://www.bbc.com/news"
response = requests.get(url)
soup = BeautifulSoup(response.text, "html.parser")

titles = [h.text.strip() for h in soup.find_all("h2")]

# Sauvegarde des titres
with open("data/articles.json", "w") as f:
    json.dump(titles, f, indent=2)

# Nettoyage et comptage des mots
words = []
for title in titles:
    clean = re.findall(r"\b[a-zA-Z]{4,}\b", title.lower())
    words.extend(clean)

counter = Counter(words)
top_words = counter.most_common(10)

# Génération du rapport texte
with open("output/rapport.txt", "w") as f:
    f.write("TOP 10 mots les plus fréquents (BBC News)\n\n")
    for word, count in top_words:
        f.write(f"{word} : {count}\n")

print("Rapport généré avec succès.")
