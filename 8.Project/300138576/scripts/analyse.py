import re
import sys
from collections import Counter

logfile = sys.argv[1] if len(sys.argv) > 1 else "data/sample.log"
rapport = "output/rapport.txt"

with open(logfile, "r", encoding="utf-8") as f:
    lines = f.readlines()

ip_pattern = r'^(\d+\.\d+\.\d+\.\d+)'
url_pattern = r'"GET ([^ ]+)'
status_pattern = r'" (\d{3}) '
hour_pattern = r'\[(\d{2})/\w+/\d{4}:(\d{2}):'

ips = []
urls = []
statuses = []
hours = []

for line in lines:
    ip_match = re.search(ip_pattern, line)
    url_match = re.search(url_pattern, line)
    status_match = re.search(status_pattern, line)
    hour_match = re.search(hour_pattern, line)

    if ip_match:
        ips.append(ip_match.group(1))
    if url_match:
        urls.append(url_match.group(1))
    if status_match:
        statuses.append(status_match.group(1))
    if hour_match:
        hours.append(hour_match.group(2))

top_ips = Counter(ips).most_common(5)
top_urls = Counter(urls).most_common(5)
status_counts = Counter(statuses)
hour_counts = Counter(hours)

with open(rapport, "w", encoding="utf-8") as f:
    f.write("RAPPORT - Analyse des accès web de Collège Boréal\n")
    f.write("=================================================\n\n")
    f.write(f"Total de requêtes : {len(lines)}\n\n")

    f.write("Top 5 IP :\n")
    for ip, count in top_ips:
        f.write(f"- {ip} : {count}\n")

    f.write("\nTop 5 pages :\n")
    for url, count in top_urls:
        f.write(f"- {url} : {count}\n")

    f.write("\nCodes HTTP :\n")
    for code, count in sorted(status_counts.items()):
        f.write(f"- {code} : {count}\n")

    f.write("\nRépartition par heure :\n")
    for hour, count in sorted(hour_counts.items()):
        f.write(f"- {hour}h : {count}\n")

print("Rapport généré dans output/rapport.txt")
