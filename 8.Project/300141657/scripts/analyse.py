import csv
import sys
import matplotlib.pyplot as plt

csv_file = sys.argv[1]
report_file = sys.argv[2]

rows = []
times = []
labels = []

with open(csv_file, "r", encoding="utf-8") as f:
    reader = csv.DictReader(f)
    for row in reader:
        rows.append(row)
        labels.append(row["timestamp"])
        try:
            times.append(float(row["response_time_ms"]))
        except:
            times.append(0)

if not rows:
    with open(report_file, "w", encoding="utf-8") as f:
        f.write("Aucune donnee disponible.\n")
    sys.exit(0)

latest = rows[-1]

with open(report_file, "w", encoding="utf-8") as f:
    f.write("=== Rapport de monitoring du site web ===\n\n")
    f.write(f"URL surveillee : {latest['url']}\n")
    f.write(f"Derniere verification : {latest['timestamp']}\n")
    f.write(f"Dernier code HTTP : {latest['status_code']}\n")
    f.write(f"Dernier temps de reponse : {latest['response_time_ms']} ms\n")
    f.write(f"Nombre total de verifications : {len(rows)}\n")

plt.figure(figsize=(10, 5))
plt.plot(labels, times, marker="o")
plt.xticks(rotation=45, ha="right")
plt.xlabel("Date et heure")
plt.ylabel("Temps de reponse (ms)")
plt.title("Evolution du temps de reponse du site")
plt.tight_layout()
plt.savefig(".\\output\\temps_reponse.png")

print("Rapport et graphique generes.")