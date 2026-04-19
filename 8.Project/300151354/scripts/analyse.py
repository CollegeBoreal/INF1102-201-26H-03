import matplotlib
matplotlib.use('Agg')

import json
import matplotlib.pyplot as plt

with open("data/result.json") as f:
    data = json.load(f)

print("URL :", data["url"])
print("Status :", data["status"])
print("Temps :", data["time"], "ms")

plt.bar(["Temps"], [data["time"]])
plt.savefig("output/graph.png")

print("Analyse terminée.")
