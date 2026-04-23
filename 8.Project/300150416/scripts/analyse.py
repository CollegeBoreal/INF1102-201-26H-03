#!/usr/bin/env python3

from collections import Counter

ips = []
urls = []
status = []

with open("data/sample.log") as f:
    lines = f.readlines()

for line in lines:
    parts = line.split()
    if len(parts) >= 8:
        ips.append(parts[0])
        urls.append(parts[5])
        status.append(parts[7])

top_ips = Counter(ips).most_common(3)
top_urls = Counter(urls).most_common(3)
top_status = Counter(status).most_common()

with open("output/rapport.txt", "w") as f:
    f.write("=== RAPPORT D'ANALYSE DES LOGS ===\n\n")

    f.write("Top 3 des IP:\n")
    for ip, c in top_ips:
        f.write(f"{ip} : {c}\n")

    f.write("\nTop 3 des URLs:\n")
    for url, c in top_urls:
        f.write(f"{url} : {c}\n")

    f.write("\nCodes HTTP:\n")
    for s, c in top_status:
        f.write(f"{s} : {c}\n")

print("Rapport généré !")
