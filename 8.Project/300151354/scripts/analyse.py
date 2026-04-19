import json
import matplotlib.pyplot as plt

# Lire le JSON
with open("../data/result.json") as f:
    data = json.load(f)

# Affichage
print("URL :", data["url"])
print("Status :", data["status"])
print("Temps de réponse :", data["time"], "ms")

# Graphique
labels = ["Temps (ms)"]
values = [data["time"]]

plt.bar(labels, values)
plt.title("Temps de réponse du site")

# Sauvegarde
plt.savefig("../output/graph.png")

print("Analyse terminée.")
