import sys
import re
from collections import Counter
import matplotlib.pyplot as plt

log_file = sys.argv[1]

ip_counter = Counter()
url_counter = Counter()
code_counter = Counter()

pattern = r'(\d+\.\d+\.\d+\.\d+).+"[A-Z]+\s(.*?)\sHTTP/[\d.]+"\s(\d{3})'

with open(log_file) as f:
    for line in f:
        match = re.search(pattern, line)
        if match:
            ip = match.group(1)
            url = match.group(2)
            code = match.group(3)

            ip_counter[ip] += 1
            url_counter[url] += 1
            code_counter[code] += 1

with open("../output/rapport.txt", "w") as f:
    f.write("=== RAPPORT D'ANALYSE DES LOGS ===\n\n")

    f.write("Top IP:\n")
    for ip, count in ip_counter.most_common(3):
        f.write(f"{ip} : {count}\n")

    f.write("\nTop URLs:\n")
    for url, count in url_counter.most_common(3):
        f.write(f"{url} : {count}\n")

    f.write("\nCodes HTTP:\n")
    for code, count in code_counter.items():
        f.write(f"{code} : {count}\n")

# Graphique des URLs
urls = list(url_counter.keys())
values = list(url_counter.values())

plt.figure(figsize=(8,5))
plt.bar(urls, values)
plt.title("Fréquence des URLs")
plt.xlabel("URLs")
plt.ylabel("Nombre de visites")
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig("../output/graphique_urls.png")

print("Rapport généré dans output/rapport.txt")
print("Graphique généré dans output/graphique_urls.png")
