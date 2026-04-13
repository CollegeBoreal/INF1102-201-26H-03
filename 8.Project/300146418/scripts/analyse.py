#!/usr/bin/env python3

import re
import sys
from collections import Counter

if len(sys.argv) < 2:
    print("Usage: python3 scripts/analyse.py data/sample.log")
    sys.exit(1)

logfile = sys.argv[1]
output_file = "output/rapport.txt"

with open(logfile, "r", encoding="utf-8") as f:
    lines = f.readlines()

data = "".join(lines)

# Regex
ips = re.findall(r'(\d{1,3}(?:\.\d{1,3}){3})', data)
urls = re.findall(r'"GET ([^ ]+)', data)
codes = re.findall(r'" (\d{3}) ', data)

top_ips = Counter(ips).most_common(5)
top_urls = Counter(urls).most_common(5)
errors = [c for c in codes if c.startswith(("4", "5"))]

with open(output_file, "w", encoding="utf-8") as f:
    f.write("===== RAPPORT D'ANALYSE DES LOGS =====\n")
    f.write(f"Total de lignes : {len(lines)}\n")
    f.write(f"Total d'erreurs HTTP : {len(errors)}\n")
    f.write(f"Erreurs 404 : {codes.count('404')}\n")
    f.write(f"Erreurs 500 : {codes.count('500')}\n\n")

    f.write("Top 5 IP :\n")
    for ip, count in top_ips:
        f.write(f"{count} - {ip}\n")

    f.write("\nTop 5 URLs :\n")
    for url, count in top_urls:
        f.write(f"{count} - {url}\n")

print("Rapport généré dans output/rapport.txt")
