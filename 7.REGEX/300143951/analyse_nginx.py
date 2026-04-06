#!/usr/bin/env python3
"""
analyse_nginx.py — Analyse avancée des logs Nginx
Auteur  : Frank | Collège Boréal — TSI 2026
Version : 2.1
"""

import re
import sys
import argparse
from collections import Counter
from datetime import datetime
from pathlib import Path

# ── Couleurs ANSI (terminal) ────────────────────────────────
class C:
    CYAN   = "\033[96m"
    GREEN  = "\033[92m"
    YELLOW = "\033[93m"
    RED    = "\033[91m"
    GRAY   = "\033[90m"
    RESET  = "\033[0m"

def colored(msg, color, no_color=False):
    return msg if no_color else f"{color}{msg}{C.RESET}"

# ── Argument CLI ────────────────────────────────────────────
script_dir = Path(__file__).resolve().parent

parser = argparse.ArgumentParser(description="Analyse logs Nginx avec Regex")
parser.add_argument(
    "--log",
    default="/var/log/nginx/access.log",
    help="Chemin du fichier log"
)
parser.add_argument(
    "--out",
    default=str(script_dir),
    help="Dossier de sortie"
)
parser.add_argument(
    "--top",
    type=int,
    default=10,
    help="Nombre de résultats top N"
)
parser.add_argument(
    "--no-color",
    action="store_true",
    help="Désactiver les couleurs"
)

args = parser.parse_args()
NC = args.no_color

# ── Vérifications préliminaires ─────────────────────────────
log_path = Path(args.log)
out_dir  = Path(args.out)

if not log_path.exists():
    print(colored(f"ERREUR : fichier introuvable → {log_path}", C.RED, NC))
    sys.exit(1)

out_dir.mkdir(parents=True, exist_ok=True)

date_str = datetime.now().strftime("%Y-%m-%d")
rapport  = out_dir / f"rapport_nginx_py_{date_str}.txt"

print(colored(f"\n  Analyse Nginx — {date_str}", C.CYAN, NC))
print(colored(f"  Lecture de : {log_path}", C.GRAY, NC))

# ── Lecture ─────────────────────────────────────────────────
with log_path.open(encoding="utf-8", errors="replace") as f:
    lines = f.readlines()

total = len(lines)
print(colored(f"  Lignes chargées : {total}\n", C.GRAY, NC))

# ── Regex de parsing ────────────────────────────────────────
RE_MAIN = re.compile(
    r'^(?P<ip>[\d.]+)\s+-\s+-\s+\[(?P<dt>[^\]]+)\]\s+'
    r'"(?P<method>[A-Z]+)\s+(?P<path>[^\s]+)\s+HTTP/[\d.]+"\s+'
    r'(?P<code>\d{3})\s+(?P<size>\d+)'
    r'(?:\s+"(?P<ref>[^"]*)"\s+"(?P<ua>[^"]*)")?'
)

# ── Extraction ──────────────────────────────────────────────
records = []

for line in lines:
    m = RE_MAIN.match(line)
    if not m:
        continue

    records.append({
        "ip":     m.group("ip"),
        "dt":     m.group("dt"),
        "method": m.group("method"),
        "path":   m.group("path"),
        "code":   m.group("code"),
        "size":   int(m.group("size")),
        "ua":     m.group("ua") or ""
    })

parsed_count = len(records)

# ── Calculs ─────────────────────────────────────────────────
codes       = Counter(r["code"] for r in records)
methods     = Counter(r["method"] for r in records)
ips         = Counter(r["ip"] for r in records)
paths_get   = Counter(r["path"] for r in records if r["method"] == "GET")
error_paths = Counter(r["path"] for r in records if r["code"].startswith(("4", "5")))

browsers = Counter()
for r in records:
    ua = r["ua"]

    if "Firefox" in ua:
        browsers["Firefox"] += 1
    elif "Chrome" in ua:
        browsers["Chrome"] += 1
    elif "Safari" in ua:
        browsers["Safari"] += 1
    elif "curl" in ua:
        browsers["curl"] += 1
    elif ua:
        browsers["Autre"] += 1

errors_4xx = sum(v for k, v in codes.items() if k.startswith("4"))
errors_5xx = sum(v for k, v in codes.items() if k.startswith("5"))
total_bytes = sum(r["size"] for r in records)
avg_bytes = round(total_bytes / parsed_count) if parsed_count else 0

# ── Affichage console ───────────────────────────────────────
SEP = "─" * 40

print(colored("  RÉSUMÉ", C.YELLOW, NC))
print(colored(f"  {SEP}", C.GRAY, NC))
print(f"  Requêtes analysées   : {parsed_count} / {total}")
print(colored(f"  Erreurs 4xx          : {errors_4xx}", C.RED if errors_4xx else C.GREEN, NC))
print(colored(f"  Erreurs 5xx          : {errors_5xx}", C.RED if errors_5xx else C.GREEN, NC))
print(f"  Bande passante       : {total_bytes / 1_048_576:.2f} MB")
print(f"  Taille moy. réponse  : {avg_bytes} octets\n")

# ── Rapport texte ───────────────────────────────────────────
SEP2 = "=" * 60

def bar_chart(count, total_ref, width=30):
    filled = round(count * width / total_ref) if total_ref else 0
    return "#" * filled

lines_out = []

def w(text=""):
    lines_out.append(text)

w(SEP2)
w("  RAPPORT D'ANALYSE NGINX")
w(f"  Généré le : {datetime.now()}")
w(f"  Fichier   : {log_path}")
w(SEP2)
w()
w("RÉSUMÉ GÉNÉRAL")
w("-" * 40)
w(f"  Lignes totales          : {total}")
w(f"  Requêtes analysées      : {parsed_count}")
w(f"  Requêtes GET            : {methods.get('GET', 0)}")
w(f"  Requêtes POST           : {methods.get('POST', 0)}")
w(f"  Erreurs 4xx             : {errors_4xx}")
w(f"  Erreurs 5xx             : {errors_5xx}")
w(f"  Bande passante totale   : {total_bytes / 1_048_576:.2f} MB")
w(f"  Taille moyenne réponse  : {avg_bytes} octets")
w()
w("DISTRIBUTION DES CODES HTTP")
w("-" * 40)

for code in sorted(codes):
    pct = round(codes[code] * 100 / parsed_count, 1) if parsed_count else 0
    bar = bar_chart(codes[code], parsed_count)
    w(f"  HTTP {code} : {codes[code]:>6} req  ({pct:>5}%)  {bar}")

w()
w(f"TOP {args.top} ADRESSES IP")
w("-" * 40)

for ip, cnt in ips.most_common(args.top):
    w(f"  {cnt:>6} req  —  {ip}")

w()
w(f"TOP {args.top} PAGES DEMANDÉES (GET)")
w("-" * 40)

for path, cnt in paths_get.most_common(args.top):
    w(f"  {cnt:>6} req  —  {path}")

if error_paths:
    w()
    w("TOP 5 URLS EN ERREUR (4xx / 5xx)")
    w("-" * 40)

    for path, cnt in error_paths.most_common(5):
        w(f"  {cnt:>6} erreurs  —  {path}")

if browsers:
    w()
    w("NAVIGATEURS / USER-AGENTS DÉTECTÉS")
    w("-" * 40)

    for browser, cnt in browsers.most_common():
        w(f"  {cnt:>6} req  —  {browser}")

w()
w(SEP2)
w("  Fin du rapport — analyse_nginx.py v2.1")
w(SEP2)

rapport.write_text("\n".join(lines_out), encoding="utf-8")

print(colored(f"  Rapport enregistré : {rapport}\n", C.GREEN, NC))
