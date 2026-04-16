import sys
from collections import Counter

if len(sys.argv) < 2:
    print("Usage: python3 analyse.py <logfile>")
    sys.exit(1)

file = sys.argv[1]

ips = []
urls = []
codes = []

with open(file, "r") as f:
    for line in f:
        parts = line.split()
        if len(parts) > 7:
            ips.append(parts[0])
            urls.append(parts[5])
            codes.append(parts[7])

top_ips = Counter(ips).most_common(5)
top_urls = Counter(urls).most_common(5)
top_codes = Counter(codes).most_common()

print("=== Rapport d'analyse des logs ===\n")

print("Top 5 IPs")
for ip, count in top_ips:
    print(f"{ip} : {count} requetes")

print("\nTop 5 URLs")
for url, count in top_urls:
    print(f"{url} : {count} visites")

print("\nCodes HTTP")
for code, count in top_codes:
    print(f"{code} : {count}")

print(f"\nTotal requetes : {len(ips)}")
