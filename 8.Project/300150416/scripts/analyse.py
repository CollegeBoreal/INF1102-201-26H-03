#!/usr/bin/env python3

from collections import Counter
import matplotlib.pyplot as plt
import os

os.makedirs("output", exist_ok=True)

ips = []
urls = []
status = []

with open("data/sample.log", "r", encoding="utf-8") as f:
    lines = f.readlines()

for line in lines:
    parts = line.split()
    if len(parts) >= 8:
        ips.append(parts[0])
        urls.append(parts[5])
        status.append(parts[7])

top_ips = Counter(ips).most_common(3)
top_urls = Counter(urls).most_common(3)
top_status = Counter(status).most_common()

with open("output/rapport.txt", "w", encoding="utf-8") as f:
    f.write("=== RAPPORT D'ANALYSE DES LOGS ===\n\n")

    f.write("Top 3 des IP:\n")
    for ip, c in top_ips:
        f.write(f"{ip} : {c}\n")

    f.write("\nTop 3 des URLs:\n")
    for url, c in top_urls:
        f.write(f"{url} : {c}\n")

    f.write("\nCodes HTTP:\n")
    for s, c in top_status:
        f.write(f"{s} : {c}\n")

def save_bar_chart(labels, values, title, output_file):
    plt.figure()
    plt.bar(labels, values)
    plt.title(title)
    plt.xticks(rotation=20)
    plt.tight_layout()
    plt.savefig(output_file)
    plt.close()

if top_ips:
    save_bar_chart(
        [x[0] for x in top_ips],
        [x[1] for x in top_ips],
        "Top 3 IP",
        "output/top_ip.png"
    )

if top_urls:
    save_bar_chart(
        [x[0] for x in top_urls],
        [x[1] for x in top_urls],
        "Top URLs",
        "output/top_urls.png"
    )

if top_status:
    save_bar_chart(
        [x[0] for x in top_status],
        [x[1] for x in top_status],
        "Codes HTTP",
        "output/http_codes.png"
    )

print("Rapport généré avec graphiques !")
# ===== Histogram global =====
all_counts = Counter(ips)
labels = list(all_counts.keys())
values = list(all_counts.values())

plt.figure()
plt.bar(labels, values)
plt.title("Histogramme des IP")
plt.xticks(rotation=45)
plt.tight_layout()
plt.savefig("output/histogram.png")
plt.close()

# ===== WordCloud =====
from wordcloud import WordCloud

text = " ".join(urls)

wordcloud = WordCloud(width=800, height=400, background_color='black').generate(text)

plt.figure()
plt.imshow(wordcloud, interpolation='bilinear')
plt.axis("off")
plt.savefig("output/wordcloud.png")
plt.close()
