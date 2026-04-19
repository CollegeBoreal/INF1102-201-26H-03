import json
import matplotlib.pyplot as plt
import sys

if len(sys.argv) < 2:
    print("Usage: python analyse.py <fichier_json>")
    exit()

file = sys.argv[1]

with open(file) as f:
    data = json.load(f)

print("URL :", data["url"])
print("Status :", data["status"])
print("Temps :", data["time"], "ms")

labels = ["Temps (ms)"]
values = [data["time"]]

plt.bar(labels, values)
plt.title("Temps de réponse du site")

plt.savefig("../output/graph.png")

print("Analyse terminée.")
