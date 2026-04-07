import csv
import json
import os
import re
from collections import Counter

import matplotlib.pyplot as plt

try:
    from wordcloud import WordCloud
    WORDCLOUD_AVAILABLE = True
except ImportError:
    WORDCLOUD_AVAILABLE = False


DATA_FILE = os.path.join("data", "news_data.json")
OUTPUT_DIR = "output"

REPORT_FILE = os.path.join(OUTPUT_DIR, "rapport.txt")
SUMMARY_CSV = os.path.join(OUTPUT_DIR, "summary.csv")

HISTOGRAM_FILE = os.path.join(OUTPUT_DIR, "histogram.png")
WORDCLOUD_FILE = os.path.join(OUTPUT_DIR, "wordcloud.png")
THEMES_BAR_FILE = os.path.join(OUTPUT_DIR, "themes_bar.png")
SEVERITY_PIE_FILE = os.path.join(OUTPUT_DIR, "severity_pie.png")
ARTICLE_SCORES_FILE = os.path.join(OUTPUT_DIR, "article_scores.png")


STOPWORDS = {
    "the", "and", "of", "to", "in", "a", "for", "on", "are", "is", "with", "as",
    "by", "an", "be", "this", "that", "new", "more", "into", "from", "one", "at",
    "it", "or", "their", "used", "using", "than", "help", "helps", "across",
    "against", "becomes", "becoming", "major", "focus", "focuses", "teams",
    "team", "analysts", "researchers", "companies", "company", "organizations",
    "organization", "services", "service", "systems", "system", "platforms",
    "platform", "projects", "project", "customer", "customers", "users", "user",
    "after", "before", "over", "under", "within", "during", "among", "remain",
    "remains", "continue", "continues", "using", "use", "used", "through",
    "about", "because", "while", "where", "which", "these", "those",
    "such", "very", "also", "around", "support", "supports",
    "supporting", "improve", "improves", "improving", "modernize", "modernizing",
    "digital", "technology", "technologies", "security", "cyber", "cybersecurity"
}


THEME_KEYWORDS = {
    "Data Breach": [
        "breach", "breaches", "exposed", "exposure", "database", "records", "data",
        "customer", "information", "sensitive"
    ],
    "Ransomware": [
        "ransomware", "recovery", "backup", "backups", "containment", "disrupted",
        "incident", "operations"
    ],
    "Phishing": [
        "phishing", "emails", "email", "credential", "credentials", "social",
        "engineering", "links", "compromise"
    ],
    "Cloud Security": [
        "cloud", "tokens", "hybrid", "applications", "encryption", "compliance",
        "monitoring", "platforms"
    ],
    "Identity & Access": [
        "identity", "access", "authentication", "privileged", "verification",
        "unauthorized", "control", "controls"
    ],
    "Network Threats": [
        "network", "traffic", "malicious", "anomaly", "indicators", "compromise",
        "alerts", "events"
    ],
    "IoT Vulnerabilities": [
        "iot", "devices", "sensors", "cameras", "building", "automation",
        "vulnerabilities", "patch"
    ],
    "AI Security": [
        "artificial", "intelligence", "machine", "learning", "automation",
        "classifying", "detection"
    ],
    "Privacy & Compliance": [
        "privacy", "regulatory", "governance", "audit", "compliance",
        "documentation", "frameworks"
    ],
    "Resilience & Recovery": [
        "resilience", "continuity", "recovery", "backup", "simulation",
        "planning", "workflows"
    ]
}


SEVERITY_KEYWORDS = {
    "high": [
        "critical", "breach", "ransomware", "malicious", "exposed", "attack",
        "compromise", "steal", "stealing", "stolen", "vulnerability",
        "vulnerabilities", "bypass", "incident", "disrupted"
    ],
    "medium": [
        "risk", "warning", "suspicious", "review", "pressure", "alerts",
        "misconfigured", "detected", "monitoring", "patch", "exposure"
    ],
    "low": [
        "improve", "adoption", "strategy", "planning", "awareness",
        "programs", "capabilities", "transformation", "resilience"
    ]
}


def load_articles(path: str):
    with open(path, "r", encoding="utf-8-sig") as f:
        return json.load(f)


def normalize_text(text: str) -> str:
    text = text.lower()
    text = re.sub(r"[^a-z0-9\s-]", " ", text)
    text = text.replace("-", " ")
    text = re.sub(r"\s+", " ", text).strip()
    return text


def tokenize(text: str):
    words = normalize_text(text).split()
    return [word for word in words if len(word) > 2 and word not in STOPWORDS]


def count_theme_hits(tokens):
    counts = Counter(tokens)
    theme_scores = {}
    for theme, keywords in THEME_KEYWORDS.items():
        theme_scores[theme] = sum(counts.get(keyword, 0) for keyword in keywords)
    return theme_scores


def calculate_severity_score(tokens):
    counts = Counter(tokens)
    high = sum(counts.get(word, 0) for word in SEVERITY_KEYWORDS["high"])
    medium = sum(counts.get(word, 0) for word in SEVERITY_KEYWORDS["medium"])
    low = sum(counts.get(word, 0) for word in SEVERITY_KEYWORDS["low"])
    score = high * 3 + medium * 2 + low * 1
    return score, high, medium, low


def severity_label(score):
    if score >= 16:
        return "High"
    if score >= 8:
        return "Medium"
    return "Low"


def detect_primary_theme(theme_scores):
    best_theme = max(theme_scores, key=theme_scores.get)
    if theme_scores[best_theme] == 0:
        return "General Cybersecurity"
    return best_theme


def plot_top_words(top_words):
    labels = [word for word, _ in top_words]
    values = [count for _, count in top_words]

    plt.figure(figsize=(12, 7))
    plt.bar(labels, values)
    plt.title("Top 10 Cyber Keywords")
    plt.xlabel("Keywords")
    plt.ylabel("Frequency")
    plt.xticks(rotation=30, ha="right")
    plt.tight_layout()
    plt.savefig(HISTOGRAM_FILE, dpi=220)
    plt.close()


def plot_wordcloud(tokens):
    text = " ".join(tokens)

    if WORDCLOUD_AVAILABLE:
        cloud = WordCloud(width=1400, height=800, background_color="white").generate(text)
        plt.figure(figsize=(14, 8))
        plt.imshow(cloud, interpolation="bilinear")
        plt.axis("off")
        plt.tight_layout()
        plt.savefig(WORDCLOUD_FILE, dpi=220)
        plt.close()
    else:
        plt.figure(figsize=(12, 7))
        plt.text(
            0.5, 0.5,
            "wordcloud module not installed\nInstall with: pip install wordcloud",
            ha="center", va="center", fontsize=16
        )
        plt.axis("off")
        plt.tight_layout()
        plt.savefig(WORDCLOUD_FILE, dpi=220)
        plt.close()


def plot_themes(theme_scores):
    sorted_items = sorted(theme_scores.items(), key=lambda x: x[1], reverse=True)
    labels = [item[0] for item in sorted_items]
    values = [item[1] for item in sorted_items]

    plt.figure(figsize=(12, 7))
    plt.bar(labels, values)
    plt.title("Cyber Theme Distribution")
    plt.xlabel("Themes")
    plt.ylabel("Score")
    plt.xticks(rotation=35, ha="right")
    plt.tight_layout()
    plt.savefig(THEMES_BAR_FILE, dpi=220)
    plt.close()


def plot_severity(severity_counts):
    labels = list(severity_counts.keys())
    values = list(severity_counts.values())

    plt.figure(figsize=(8, 8))
    plt.pie(values, labels=labels, autopct="%1.1f%%", startangle=90)
    plt.title("Severity Distribution")
    plt.tight_layout()
    plt.savefig(SEVERITY_PIE_FILE, dpi=220)
    plt.close()


def plot_article_scores(article_records):
    labels = [f"A{record['id']}" for record in article_records]
    values = [record["cti_score"] for record in article_records]

    plt.figure(figsize=(12, 7))
    plt.bar(labels, values)
    plt.title("Cyber Threat Index by Article")
    plt.xlabel("Article ID")
    plt.ylabel("CTI Score")
    plt.tight_layout()
    plt.savefig(ARTICLE_SCORES_FILE, dpi=220)
    plt.close()


def write_summary_csv(article_records):
    fieldnames = [
        "id", "source", "date", "title", "primary_theme",
        "cti_score", "severity", "high_terms", "medium_terms", "low_terms"
    ]

    with open(SUMMARY_CSV, "w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fieldnames)
        writer.writeheader()
        for record in article_records:
            writer.writerow({
                "id": record["id"],
                "source": record["source"],
                "date": record["date"],
                "title": record["title"],
                "primary_theme": record["primary_theme"],
                "cti_score": record["cti_score"],
                "severity": record["severity"],
                "high_terms": record["high_terms"],
                "medium_terms": record["medium_terms"],
                "low_terms": record["low_terms"]
            })


def write_report(articles, top_words, global_themes, severity_counts, article_records, avg_title_len, avg_summary_len):
    sorted_articles = sorted(article_records, key=lambda x: x["cti_score"], reverse=True)
    top_critical = sorted_articles[:3]
    avg_cti = sum(record["cti_score"] for record in article_records) / len(article_records)
    most_common_theme = max(global_themes, key=global_themes.get)

    with open(REPORT_FILE, "w", encoding="utf-8") as f:
        f.write("==============================================================\n")
        f.write(" CYBERPULSE INTELLIGENCE - THREAT TREND ANALYSIS REPORT\n")
        f.write("==============================================================\n\n")

        f.write("1. EXECUTIVE SUMMARY\n")
        f.write("--------------------\n")
        f.write(f"Total articles analyzed: {len(articles)}\n")
        f.write(f"Average cleaned title length: {avg_title_len:.2f} words\n")
        f.write(f"Average cleaned summary length: {avg_summary_len:.2f} words\n")
        f.write(f"Average Cyber Threat Index (CTI): {avg_cti:.2f}\n")
        f.write(f"Dominant cyber theme: {most_common_theme}\n\n")

        f.write("2. TOP 10 KEYWORDS\n")
        f.write("------------------\n")
        for i, (word, count) in enumerate(top_words, start=1):
            f.write(f"{i:>2}. {word:<18} {count}\n")
        f.write("\n")

        f.write("3. THEME DISTRIBUTION\n")
        f.write("---------------------\n")
        for theme, score in sorted(global_themes.items(), key=lambda x: x[1], reverse=True):
            f.write(f"- {theme:<24} -> {score}\n")
        f.write("\n")

        f.write("4. SEVERITY DISTRIBUTION\n")
        f.write("------------------------\n")
        for level, count in severity_counts.items():
            f.write(f"- {level:<8} -> {count}\n")
        f.write("\n")

        f.write("5. TOP 3 MOST CRITICAL ARTICLES\n")
        f.write("-------------------------------\n")
        for record in top_critical:
            f.write(f"Article {record['id']} | CTI={record['cti_score']} | {record['severity']}\n")
            f.write(f"Source : {record['source']}\n")
            f.write(f"Theme  : {record['primary_theme']}\n")
            f.write(f"Title  : {record['title']}\n\n")

        f.write("6. ANALYTICAL INTERPRETATION\n")
        f.write("----------------------------\n")
        f.write(
            "The analyzed corpus shows a strong concentration of cyber risk narratives around "
            "data exposure, ransomware disruption, cloud security, phishing, and identity control. "
            "These patterns suggest that modern organizations remain highly exposed to both external "
            "attacks and internal control weaknesses.\n\n"
        )
        f.write(
            "The severity assessment reveals that the sample is not dominated by low-level awareness "
            "topics only. Several articles contain high-risk language such as critical vulnerability, "
            "breach, compromise, exposed data, ransomware, and malicious activity, indicating that the "
            "dataset captures operationally relevant cyber events.\n\n"
        )
        f.write(
            "Cloud environments, identity systems, and sensitive data repositories appear repeatedly, "
            "which reflects current enterprise priorities in cybersecurity strategy. In parallel, AI "
            "and machine learning emerge as enabling technologies for faster detection, alert triage, "
            "and anomaly identification.\n\n"
        )

        f.write("7. CONCLUSION\n")
        f.write("-------------\n")
        f.write(
            "CyberPulse Intelligence demonstrates how a scripting-based workflow can transform a simple "
            "collection of news articles into a structured cyber threat analysis product. By combining "
            "text preprocessing, thematic scoring, severity assessment, CTI ranking, automated graphics, "
            "and reporting, the project delivers a strong prototype for cyber intelligence monitoring.\n\n"
        )

        f.write("8. FUTURE IMPROVEMENTS\n")
        f.write("----------------------\n")
        f.write("- Connect to a real API or RSS feed for live ingestion\n")
        f.write("- Add sentiment analysis and named entity extraction\n")
        f.write("- Track daily or weekly trends over time\n")
        f.write("- Compare multiple publishers and source reliability\n")
        f.write("- Export a dashboard-ready dataset for BI tools\n")


def main():
    os.makedirs(OUTPUT_DIR, exist_ok=True)

    if not os.path.exists(DATA_FILE):
        print(f"[ERROR] Missing input file: {DATA_FILE}")
        return

    articles = load_articles(DATA_FILE)
    if not articles:
        print("[ERROR] No articles found.")
        return

    all_tokens = []
    global_theme_counter = Counter()
    severity_counts = Counter()
    article_records = []

    title_lengths = []
    summary_lengths = []

    for article in articles:
        title = article.get("title", "")
        summary = article.get("summary", "")
        source = article.get("source", "Unknown")
        date = article.get("date", "N/A")
        article_id = article.get("id", 0)

        title_tokens = tokenize(title)
        summary_tokens = tokenize(summary)
        article_tokens = title_tokens + summary_tokens

        title_lengths.append(len(title_tokens))
        summary_lengths.append(len(summary_tokens))

        all_tokens.extend(article_tokens)

        theme_scores = count_theme_hits(article_tokens)
        for theme, score in theme_scores.items():
            global_theme_counter[theme] += score

        cti_score, high_terms, medium_terms, low_terms = calculate_severity_score(article_tokens)
        sev = severity_label(cti_score)
        severity_counts[sev] += 1

        article_records.append({
            "id": article_id,
            "source": source,
            "date": date,
            "title": title,
            "primary_theme": detect_primary_theme(theme_scores),
            "cti_score": cti_score,
            "severity": sev,
            "high_terms": high_terms,
            "medium_terms": medium_terms,
            "low_terms": low_terms
        })

    word_counts = Counter(all_tokens)
    top_words = word_counts.most_common(10)

    avg_title_len = sum(title_lengths) / len(title_lengths)
    avg_summary_len = sum(summary_lengths) / len(summary_lengths)

    plot_top_words(top_words)
    plot_wordcloud(all_tokens)
    plot_themes(global_theme_counter)
    plot_severity(severity_counts)
    plot_article_scores(article_records)

    write_summary_csv(article_records)
    write_report(
        articles,
        top_words,
        global_theme_counter,
        severity_counts,
        article_records,
        avg_title_len,
        avg_summary_len
    )

    print("[OK] CyberPulse Intelligence analysis completed.")
    print(f"[OK] Report: {REPORT_FILE}")
    print(f"[OK] CSV summary: {SUMMARY_CSV}")
    print(f"[OK] Graphics generated in: {OUTPUT_DIR}")


if __name__ == "__main__":
    main()
