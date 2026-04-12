import re
from collections import Counter
from datetime import datetime

logfile = "/var/log/nginx/access.log"

with open(logfile) as f:
    lines = f.readlines()

data = "".join(lines)

rapport = f"REGEX/rapport_nginx_py_{datetime.now().date()}.txt"

total = len(lines)
codes = re.findall(r'" (\d{3}) ', data)
errors = [c for c in codes if c.startswith(('4', '5'))]
ips = re.findall(r'(\d{1,3}(?:\.\d{1,3}){3})', data)
pages = re.findall(r'"GET ([^ ]+)', data)

with open(rapport, "w") as f:
    f.write(f"📊 Rapport Nginx - {datetime.now()}\n")
    f.write("----------------------------------\n")
    f.write(f"Total requêtes : {total}\n")
    f.write(f"Erreurs HTTP : {len(errors)}\n")
    f.write(f"Erreurs 404 : {codes.count('404')}\n")
    f.write(f"Erreurs 500 : {codes.count('500')}\n")
    f.write("\nTop 5 IP :\n")
    for ip, count in Counter(ips).most_common(5):
        f.write(f"{count} {ip}\n")
    f.write("\nTop 5 pages :\n")
    for p, count in Counter(pages).most_common(5):
        f.write(f"{count} {p}\n")

print("✅ Rapport généré :", rapport)
