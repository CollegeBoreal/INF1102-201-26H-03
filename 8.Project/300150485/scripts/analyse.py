import sys
from collections import Counter
import matplotlib.pyplot as plt

file = sys.argv[1]

ips = []
urls = []

with open(file) as f:
    for line in f:
        parts = line.split()
        
        if len(parts) >= 6:
            ips.append(parts[0])
            url = parts[5].replace('"', '')
            urls.append(url)

top_ips = Counter(ips).most_common(3)
top_urls = Counter(urls).most_common(3)

# ✅ GRAPHIQUE (AU BON ENDROIT)
ips_labels = [ip for ip, count in top_ips]
ips_counts = [count for ip, count in top_ips]

plt.bar(ips_labels, ips_counts)
plt.title("Top IP")
plt.savefig("images/graphique.png")

# rapport texte
with open("output/rapport.txt", "w") as out:
    out.write("=== RAPPORT ===\n\n")
    
    out.write("Top IP:\n")
    for ip, count in top_ips:
        out.write(f"{ip} -> {count} fois\n")
    
    out.write("\nTop URLs:\n")
    for url, count in top_urls:
        out.write(f"{url} -> {count} fois\n")

print("Analyse terminée ✔")
