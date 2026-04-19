import json
import matplotlib.pyplot as plt

print("START SCRIPT")

with open("data/result.json") as f:
    data = json.load(f)

print("DATA LOADED")

print("URL :", data["url"])
print("Status :", data["status"])
print("Temps :", data["time"], "ms")

labels = ["Temps (ms)"]
values = [data["time"]]

plt.bar(labels, values)
plt.title("Temps de réponse du site")

plt.savefig("output/graph.png")

print("FILE SAVED")
print("Analyse terminée.")
