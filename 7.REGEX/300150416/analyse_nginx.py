import re
from collections import Counter
from datetime import datetime
from pathlib import Path

logfile = "/var/log/nginx/access.log"
base_dir = Path(__file__).resolve().parent
rapport = base_dir / f"rapport_nginx_py_{datetime.now().date()}.txt"

with open(logfile, "r") as f:
    lines = f.readlines()

data = "".join(lines)

# Total
total = len(lines)

# Codes HTTP
codes = re.findall(r'" (\d{3}) ', data)

# Erreurs
errors = [c for c in codes if c.startswith(("4", "5"))]

# IPs
ips = re.findall(r'(\d{1,3}(?:\.\d{1,3}){3})', data)

# Pages GET
pages = re.findall(r'"GET ([^ ]+)', data)

with open(rapport, "w") as f:
    f.write(f"Rapport Nginx - {datetime.now()}\n")
    f.write("----------------------------------\n")
    f.write(f"Total requetes : {total}\n")
    f.write(f"Erreurs HTTP : {len(errors)}\n")
    f.write(f"Erreurs 404 : {codes.count('404')}\n")
    f.write(f"Erreurs 500 : {codes.count('500')}\n")

    f.write("\nTop 5 IP :\n")
    for ip, count in Counter(ips).most_common(5):
        f.write(f"{count} {ip}\n")

    f.write("\nTop 5 pages :\n")
    for p, count in Counter(pages).most_common(5):
        f.write(f"{count} {p}\n")

print("Rapport genere :", rapport)
