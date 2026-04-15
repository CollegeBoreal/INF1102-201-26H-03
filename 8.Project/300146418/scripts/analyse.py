#!/usr/bin/env python3
import re
from collections import Counter
from pathlib import Path
import matplotlib.pyplot as plt

BASE_DIR = Path(__file__).resolve().parent.parent
LOG_FILE = BASE_DIR / "data" / "sample.log"
OUTPUT_FILE = BASE_DIR / "output" / "rapport.txt"
IMAGES_DIR = BASE_DIR / "images"

IMAGES_DIR.mkdir(exist_ok=True)
OUTPUT_FILE.parent.mkdir(exist_ok=True)

pattern = re.compile(
    r'(?P<ip>\d+\.\d+\.\d+\.\d+).+"(?:GET|POST)\s(?P<url>\S+)\sHTTP/[\d.]+"\s(?P<status>\d{3})'
)

ips = []
urls = []
statuses = []

with open(LOG_FILE, "r", encoding="utf-8") as f:
    for line in f:
        match = pattern.search(line)
        if match:
            ips.append(match.group("ip"))
            urls.append(match.group("url"))
            statuses.append(match.group("status"))

ip_counter = Counter(ips)
url_counter = Counter(urls)
status_counter = Counter(statuses)

total_requests = len(urls)
top_ip = ip_counter.most_common(3)
top_url = url_counter.most_common(3)

with open(OUTPUT_FILE, "w", encoding="utf-8") as out:
    out.write("RAPPORT D'ANALYSE DES LOGS\n")
    out.write("=" * 35 + "\n\n")
    out.write(f"Nombre total de requêtes : {total_requests}\n\n")

    out.write("Top 3 des adresses IP :\n")
    for ip, count in top_ip:
        out.write(f"- {ip} : {count} requêtes\n")

    out.write("\nTop 3 des URLs :\n")
    for url, count in top_url:
        out.write(f"- {url} : {count} accès\n")

    out.write("\nCodes de statut HTTP :\n")
    for status, count in status_counter.items():
        out.write(f"- {status} : {count}\n")

plt.figure(figsize=(8, 5))
plt.bar([x[0] for x in top_ip], [x[1] for x in top_ip])
plt.title("Top 3 des adresses IP")
plt.xlabel("Adresse IP")
plt.ylabel("Nombre de requêtes")
plt.xticks(rotation=15)
plt.tight_layout()
plt.savefig(IMAGES_DIR / "top_ip.png")
plt.close()

plt.figure(figsize=(8, 5))
plt.bar([x[0] for x in top_url], [x[1] for x in top_url])
plt.title("Top 3 des URLs")
plt.xlabel("URL")
plt.ylabel("Nombre d'accès")
plt.xticks(rotation=15)
plt.tight_layout()
plt.savefig(IMAGES_DIR / "top_urls.png")
plt.close()

plt.figure(figsize=(8, 5))
plt.bar(list(status_counter.keys()), list(status_counter.values()))
plt.title("Répartition des codes HTTP")
plt.xlabel("Code HTTP")
plt.ylabel("Nombre")
plt.tight_layout()
plt.savefig(IMAGES_DIR / "http_status.png")
plt.close()

print("Analyse terminée.")
print(f"Rapport généré : {OUTPUT_FILE}")
print(f"Images générées dans : {IMAGES_DIR}")
