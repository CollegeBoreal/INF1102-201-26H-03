import re
from collections import Counter
from datetime import datetime

input_file = "data/sample.log"
output_file = "output/rapport.txt"

titles = []

# Lecture du fichier log
try:
    with open(input_file) as f:
        for line in f:
            titles.append(line.strip())
except:
    print("Erreur lecture fichier log")
    titles = []

# Extraction des mots
words = []
for t in titles:
    found = re.findall(r'\b[a-zA-Z]{3,}\b', t.lower())
    words.extend(found)

top_words = Counter(words).most_common(10)

# Sécurité calcul moyenne
if titles:
    avg_length = sum(len(t) for t in titles) / len(titles)
else:
    avg_length = 0

# Sécurité mot le plus long
if words:
    longest_word = max(words, key=len)
else:
    longest_word = "Aucun mot trouvé"

# Génération du rapport
now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

with open(output_file, "w") as f:
    f.write("=" * 50 + "\n")
    f.write("   GLOBAL NEWS ANALYZER REPORT\n")
    f.write("=" * 50 + "\n")
    f.write(f"Date        : {now}\n")
    f.write(f"Articles    : {len(titles)}\n")
    f.write("=" * 50 + "\n\n")

    f.write("HEADLINES:\n")
    f.write("-" * 50 + "\n")
    for i, t in enumerate(titles[:20], 1):
        f.write(f"{i}. {t}\n")

    f.write("\nTOP WORDS:\n")
    f.write("-" * 50 + "\n")
    if top_words:
        for w, c in top_words:
            f.write(f"{w:<15} ({c})\n")
    else:
        f.write("Aucun mot trouvé\n")

    f.write("\nSTATISTICS:\n")
    f.write("-" * 50 + "\n")
    f.write(f"Average length : {avg_length:.2f}\n")
    f.write(f"Longest word   : {longest_word}\n")

    f.write("\n" + "=" * 50 + "\n")
    f.write("Report generated successfully\n")

print("✔ Rapport généré :", output_file)
