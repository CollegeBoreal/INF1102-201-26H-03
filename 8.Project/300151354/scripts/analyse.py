import json
import matplotlib.pyplot as plt

# Lire données
with open("../data/result.json") as f:
    data = json.load(f)

url = data["url"]
status = data["status"]
time = data["time"]

# Affichage
print(f"URL: {url}")
print(f"Status: {status}")
print(f"Temps de réponse: {time} ms")

# Rapport texte
with open("../output/rapport.txt", "w") as f:
    f.write("=== RAPPORT MONITORING ===\n")
    f.write(f"URL: {url}\n")
    f.write(f"Status: {status}\n")
    f.write(f"Temps: {time} ms\n")

# Graphique
labels = ["Temps (ms)"]
values = [time]

plt.bar(labels, values)
plt.title("Temps de réponse du site")
plt.savefig("../output/graph.png")

print("Analyse terminée.")
