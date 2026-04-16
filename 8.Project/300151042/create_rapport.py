from collections import Counter
from datetime import datetime
from pathlib import Path

# Chemins
base_dir = Path(__file__).resolve().parent.parent
log_file = base_dir / "data" / "sample.log"
output_dir = base_dir / "output"
rapport_file = output_dir / "rapport.txt"

output_dir.mkdir(exist_ok=True)

ips = []
urls = []
codes = []

# Lecture du fichier log
with open(log_file, "r", encoding="utf-8") as f:
    for line in f:
        parts = line.split()
        if len(parts) > 7:
            ips.append(parts[0])
            urls.append(parts[5])
            codes.append(parts[7])

top_ips = Counter(ips).most_common(5)
top_urls = Counter(urls).most_common(5)
top_codes = Counter(codes).most_common()

now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

# Génération du rapport
with open(rapport_file, "w", encoding="utf-8") as f:
    f.write("=" * 50 + "\n")
    f.write("  RAPPORT ANALYSE LOGS WEB\n")
    f.write("=" * 50 + "\n")
    f.write(f"Date        : {now}\n")
    f.write(f"Fichier     : {log_file.name}\n")
    f.write(f"Requetes    : {len(ips)}\n")
    f.write(f"IP uniques  : {len(set(ips))}\n")
    f.write(f"URLs uniques: {len(set(urls))}\n")
    f.write("=" * 50 + "\n\n")

    f.write("TOP 5 IPs\n")
    f.write("-" * 50 + "\n")
    for ip, count in top_ips:
        f.write(f"{ip:<20} {count}\n")

    f.write("\nTOP 5 URLs\n")
    f.write("-" * 50 + "\n")
    for url, count in top_urls:
        f.write(f"{url:<20} {count}\n")

    f.write("\nCODES HTTP\n")
    f.write("-" * 50 + "\n")
    for code, count in top_codes:
        f.write(f"{code:<20} {count}\n")

    f.write("\n" + "=" * 50 + "\n")
    f.write("Rapport généré avec succès\n")

print(f"Rapport généré : {rapport_file}")
