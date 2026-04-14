import nbformat as nbf

nb = nbf.v4.new_notebook()

cells = []

cells.append(nbf.v4.new_markdown_cell("# 🌐 Global News Analyzer Report"))

cells.append(nbf.v4.new_markdown_cell(
"## 🎯 Objectif\nAnalyser des titres RSS et extraire les mots fréquents."
))

cells.append(nbf.v4.new_code_cell(
"""import re
from collections import Counter

with open('data/sample.log') as f:
    titles = f.readlines()

print("Nombre de titres:", len(titles))
"""
))

cells.append(nbf.v4.new_code_cell(
"""words = []
for t in titles:
    words += re.findall(r'\\b[a-zA-Z]{3,}\\b', t.lower())

top = Counter(words).most_common(10)
print(top)
"""
))

nb['cells'] = cells

with open('RAPPORT.ipynb', 'w') as f:
    nbf.write(nb, f)

print("Notebook créé ✔")
