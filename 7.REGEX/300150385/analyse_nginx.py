import re
from collections import Counter
from datetime import datetime

logfile = "/var/log/nginx/access.log"

with open(logfile) as f:
    lines = f.readlines()

data = "".join(lines)

rapport = f"rapport_py_{datetime.now().date()}.txt"

# Codes HTTP
codes = re.findall(r'" (\d{3})', data)

# IP
ips = re.findall(r'(\d{1,3}(?:\.\d{1,3}){3})', data)

# Pages
pages = re.findall(r'"GET ([^ ]+)', data)

with open(rapport, "w") as f:
    f.write("=== RAPPORT NGINX PYTHON ===\n")
    f.write(f"Date : {datetime.now()}\n")
    f.write(f"Total requêtes : {len(lines)}\n")
    f.write(f"Erreurs HTTP : {len([c for c in codes if c.startswith(('4','5'))])}\n")
    f.write(f"Erreurs 404 : {codes.count('404')}\n")
    f.write(f"Erreurs 500 : {codes.count('500')}\n")

    f.write("\nTop 5 IP :\n")
    for ip, count in Counter(ips).most_common(5):
        f.write(f"{count} {ip}\n")

    f.write("\nTop 5 pages :\n")
    for p, count in Counter(pages).most_common(5):
        f.write(f"{count} {p}\n")

print("Rapport généré :", rapport)