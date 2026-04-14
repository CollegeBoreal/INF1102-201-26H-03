import requests
from bs4 import BeautifulSoup
from collections import Counter
import matplotlib.pyplot as plt
import json
import os
import re

# URL BBC
url = "https://www.bbc.com/news"

# récupérer la page
response = requests.get(url)
soup = BeautifulSoup(response.text, "html.parser")

# récupérer les titres
titles = [t.get_text() for t in soup.find_all("h3")]

# nettoyer le texte
def clean_text(text):
    text = text.lower()
    text = re.sub(r"[^a-z\s]", "", text)
    words = text.split()
    return [w for w in words if len(w) > 3]

# combiner tous les titres
all_words = []
for title in titles:
    all_words.extend(clean_text(title))

# compter les mots
word_counts = Counter(all_words)

# top 10
top_words = word_counts.most_common(10)

# créer dossier output si besoin
os.makedirs("../output", exist_ok=True)

# sauvegarder JSON
with open("../data/news_data.json", "w") as f:
    json.dump(dict(top_words), f)

# créer histogramme
words = [w for w, c in top_words]
counts = [c for w, c in top_words]

plt.bar(words, counts)
plt.title("Top mots BBC")
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig("../output/histogram.png")

# rapport texte
with open("../output/rapport.txt", "w") as f:
    f.write("Top mots :\n")
    for w, c in top_words:
        f.write(f"{w}: {c}\n")

print("Analyse terminée ✔️")
