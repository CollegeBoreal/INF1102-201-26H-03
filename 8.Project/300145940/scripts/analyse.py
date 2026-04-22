import re
from collections import Counter
from pathlib import Path

logfile = Path("data/sample.log")
output_file = Path("output/rapport.txt")

with logfile.open("r", encoding="utf-8") as f:
    lines = f.readlines()

ips = []
urls = []
codes = []

for line in lines:
    ip_match = re.search(r'^(\d{1,3}(?:\.\d{1,3}){3})', line)
    url_match = re.search(r'"GET ([^ ]+)', line)
    code_match = re.search(r'" (\d{3}) ', line)

    if ip_match:
        ips.append(ip_match.group(1))
    if url_match:
        urls.append(url_match.group(1))
    if code_match:
        codes.append(code_match.group(1))

top_ips = Counter(ips).most_common(5)
top_urls = Counter(urls).most_common(5)
top_codes = Counter(codes).most_common()
errors = [c for c in codes if c.startswith(("4", "5"))]

output_file.parent.mkdir(parents=True, exist_ok=True)

with output_file.open("w", encoding="utf-8") as f:
    f.write("===== RAPPORT DE SURVEILLANCE NGINX =====\n")
    f.write(f"Total requêtes : {len(lines)}\n")
    f.write(f"Total erreurs HTTP : {len(errors)}\n")
    f.write(f"Total erreurs 404 : {codes.count('404')}\n")
    f.write(f"Total erreurs 500 : {codes.count('500')}\n\n")

    f.write("Top 5 IP :\n")
    for ip, count in top_ips:
        f.write(f"{count} - {ip}\n")

    f.write("\nTop 5 URLs :\n")
    for url, count in top_urls:
        f.write(f"{count} - {url}\n")

    f.write("\nRépartition des codes HTTP :\n")
    for code, count in top_codes:
        f.write(f"{count} - {code}\n")

print(f"Rapport généré : {output_file}")
