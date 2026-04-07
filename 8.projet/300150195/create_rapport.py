import nbformat as nbf

nb = nbf.v4.new_notebook()

cells = [
    nbf.v4.new_markdown_cell("# 📰 Scraper BBC News — Rapport\n**Amel Zourane** | 300150195 | INF1102-201-26H-03"),
    nbf.v4.new_markdown_cell("## 🎯 Objectif\nCe projet scrape les nouvelles BBC News via RSS, analyse les mots les plus fréquents et génère un rapport automatique."),
    nbf.v4.new_markdown_cell("## 📂 Structure du projet\n```\n8.projet/300150195/\n├── scripts/\n│   ├── analyse.ps1\n│   └── analyse.py\n├── data/\n│   └── sample.log\n├── output/\n│   └── rapport.txt\n├── RAPPORT.ipynb\n└── README.md\n```"),
    nbf.v4.new_markdown_cell("## ⚙️ Exécution"),
    nbf.v4.new_code_cell("import subprocess\nresult = subprocess.run(['python3', 'scripts/analyse.py'], capture_output=True, text=True)\nprint(result.stdout)"),
    nbf.v4.new_markdown_cell("## 📊 Résultats"),
    nbf.v4.new_code_cell("with open('output/rapport.txt') as f:\n    print(f.read())"),
    nbf.v4.new_markdown_cell("## 🔤 Top 10 Mots Fréquents"),
    nbf.v4.new_code_cell("import re\nfrom collections import Counter\n\nwith open('output/rapport.txt') as f:\n    lines = f.readlines()\n\nmots = {}\nfor line in lines:\n    match = re.match(r'(\\w+)\\s+█+\\s+\\((\\d+)\\)', line.strip())\n    if match:\n        mots[match.group(1)] = int(match.group(2))\n\nfor mot, count in sorted(mots.items(), key=lambda x: -x[1]):\n    print(f'{mot:<20} {count}')"),
    nbf.v4.new_markdown_cell("## ✅ Conclusion\nLe scraper BBC News fonctionne. Il récupère 20 titres, analyse les mots fréquents et génère un rapport TXT automatique."),
]

nb.cells = cells

with open('RAPPORT.ipynb', 'w') as f:
    nbf.write(nb, f)

print('✅ RAPPORT.ipynb créé !')
