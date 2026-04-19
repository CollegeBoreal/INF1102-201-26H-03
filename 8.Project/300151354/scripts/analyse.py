import matplotlib.pyplot as plt
import sys

if len(sys.argv) < 2:
    print("Usage: python analyse.py <file>")
    exit()

file = sys.argv[1]

# Read rapport.txt
with open(file) as f:
    lines = f.readlines()

url = lines[1].split(": ")[1].strip()
status = int(lines[2].split(": ")[1].strip())
time = float(lines[3].split(": ")[1].replace(" ms", "").strip())

print("URL :", url)
print("Status :", status)
print("Temps :", time, "ms")

labels = ["Temps (ms)"]
values = [time]

plt.bar(labels, values)
plt.title("Temps de réponse du site")

plt.savefig("../output/graph.png")

print("Analyse terminée.")
