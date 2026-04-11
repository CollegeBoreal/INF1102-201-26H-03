import sys
import json
import matplotlib.pyplot as plt

# Vérification des arguments
if len(sys.argv) < 3:
    print("Usage: python analyse.py <input.json> <output.png>")
    sys.exit(1)

input_file = sys.argv[1]
output_image = sys.argv[2]

# Charger JSON
with open(input_file, encoding="utf-8") as f:
    data = json.load(f)

# Récupérer artistes
artists = data['artists']['artist'][:5]

names = []
plays = []

for artist in artists:
    names.append(artist['name'])
    plays.append(int(artist['playcount']))

# Écriture rapport texte (fichier séparé)
with open("../output/rapport.txt", "w", encoding="utf-8") as f:
    f.write("Top 5 artistes\n\n")
    for i in range(len(names)):
        f.write(f"{names[i]} : {plays[i]} écoutes\n")

# Graphique
plt.bar(names, plays)
plt.xticks(rotation=30)
plt.title("Top artistes Last.fm")

# Sauvegarde image
plt.savefig(output_image)

print("✔ Analyse terminée")
