import json
import matplotlib.pyplot as plt
import os

# Get script directory
base_dir = os.path.dirname(os.path.abspath(__file__))

# Correct paths
data_path = os.path.join(base_dir, "../data/result.json")
output_path = os.path.join(base_dir, "../output/graph.png")

with open(data_path) as f:
    data = json.load(f)

print("URL :", data["url"])
print("Status :", data["status"])
print("Temps :", data["time"], "ms")

labels = ["Temps (ms)"]
values = [data["time"]]

plt.bar(labels, values)
plt.title("Temps de réponse du site")

plt.savefig(output_path)

print("Analyse terminée.")
