import re
from collections import Counter
from datetime import datetime
import matplotlib.pyplot as plt

input_file = "data/sample.log"
output_file = "output/rapport.txt"
image_file = "images/graphique.png"

titles = []

# Lecture fichier
with open(input_file, "r") as f:
    for line in f:
        titles.append(line.strip())

# Nettoyage + extraction mots
words = []

for t in titles:
    t = re.sub(r'<[^>]+>', '', t)          # enlever HTML
    t = re.sub(r'[^a-zA-Z ]', ' ', t)      # garder lettres
    parts = t.lower().split()
    words.extend(parts)

# Stop words
stop_words = {
    "the","and","for","with","from","this","that","have","will",
    "after","about","their","they","been","said","more","than",
    "into","over","when","were","news","bbc"
}

words = [w for w in words if w not in stop_words and len(w) > 3]

# Top mots
top = Counter(words).most_common(10)

# Générer graphique
if top:
    labels = [w for w, c in top]
    values = [c for w, c in top]

    plt.figure(figsize=(10,6))
    bars = plt.bar(labels, values)

    plt.title("Top 10 mots les plus fréquents")
    plt.xlabel("Mots")
    plt.ylabel("Fréquence")
    plt.xticks(rotation=45)

    for bar in bars:
        y = bar.get_height()
        plt.text(bar.get_x()+bar.get_width()/2, y, int(y),
                 ha='center', va='bottom')

    plt.grid(axis='y', linestyle='--', alpha=0.6)

    plt.tight_layout()
    plt.savefig(image_file)
    plt.close()

# Rapport texte
now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

with open(output_file, "w") as f:
    f.write("=== GLOBAL NEWS ANALYZER ===\n")
    f.write(f"Date: {now}\n")
    f.write(f"Articles: {len(titles)}\n\n")

    f.write("TOP WORDS:\n")
    for w, c in top:
        f.write(f"{w}: {c}\n")

print("✔ Rapport + graphique générés")
