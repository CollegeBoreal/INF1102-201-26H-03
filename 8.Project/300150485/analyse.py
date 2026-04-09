import sys
from collections import Counter

file = sys.argv[1]

ips = []
urls = []

with open(file) as f:
    for line in f:
        parts = line.split()
        
        if len(parts) >= 6:
            ips.append(parts[0])
            
            # Nettoyer l'URL (enlever les guillemets)
            url = parts[5].replace('"', '')
            urls.append(url)

top_ips = Counter(ips).most_common(3)
top_urls = Counter(urls).most_common(3)

with open("output/rapport.txt", "w") as out:
    out.write("=== RAPPORT ===\n\n")
    
    out.write("Top IP:\n")
    for ip, count in top_ips:
        out.write(f"{ip} -> {count} fois\n")
    
    out.write("\nTop URLs:\n")
    for url, count in top_urls:
        out.write(f"{url} -> {count} fois\n")

print("Analyse terminée ✔")