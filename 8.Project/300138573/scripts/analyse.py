import re
from collections import Counter

log_file = "data/sample.log"
output_file = "output/rapport.txt"

ip_counter = Counter()
url_counter = Counter()
status_counter = Counter()

pattern = r'(\d+\.\d+\.\d+\.\d+).+"(?:GET|POST)\s+([^ ]+)\s+HTTP/[\d.]+"\s+(\d{3})'

with open(log_file, "r", encoding="utf-8") as f:
    for line in f:
        match = re.search(pattern, line)
        if match:
            ip = match.group(1)
            url = match.group(2)
            status = match.group(3)

            ip_counter[ip] += 1
            url_counter[url] += 1
            status_counter[status] += 1

with open(output_file, "w", encoding="utf-8") as f:
    f.write("=== Rapport d'analyse des logs ===\n\n")

    f.write("Top 3 adresses IP :\n")
    for ip, count in ip_counter.most_common(3):
        f.write(f"- {ip} : {count} requêtes\n")

    f.write("\nTop 3 URLs :\n")
    for url, count in url_counter.most_common(3):
        f.write(f"- {url} : {count} accès\n")

    f.write("\nCodes de statut HTTP :\n")
    for status, count in status_counter.most_common():
        f.write(f"- {status} : {count} fois\n")

print("Rapport généré dans output/rapport.txt")
