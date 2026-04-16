#!/usr/bin/env python3
"""
analyse.py — Scraping de prix e-commerce + génération du rapport texte
Projet 3 : Suivi de Prix

Usage :
    python3 scripts/analyse.py
    python3 scripts/analyse.py --csv data/prices.csv --output output/rapport.txt
"""

import os
import csv
import json
import logging
import argparse
import requests
from datetime import datetime
from pathlib import Path


# =============================================================================
# Configuration
# =============================================================================

# URL de l'API publique (Fake Store API — scraping autorisé, aucune restriction)
# https://fakestoreapi.com  — API de démonstration e-commerce libre
PRODUCTS_TO_TRACK = [
    {
        "id": 1,
        "nom": "Fjallraven Backpack",
        "url": "https://fakestoreapi.com/products/1",
    },
    {
        "id": 2,
        "nom": "Casual Premium T-Shirt",
        "url": "https://fakestoreapi.com/products/2",
    },
    {
        "id": 3,
        "nom": "Cotton T-Shirt",
        "url": "https://fakestoreapi.com/products/3",
    },
]

DEFAULT_CSV    = "data/prices.csv"
DEFAULT_OUTPUT = "output/rapport.txt"
DEFAULT_LOG    = "data/scraping.log"


# =============================================================================
# Logger
# =============================================================================

def setup_logger(log_file: str) -> logging.Logger:
    """Configure le logger pour écrire dans le terminal ET dans un fichier."""
    Path(log_file).parent.mkdir(parents=True, exist_ok=True)
    logger = logging.getLogger("price_tracker")
    logger.setLevel(logging.DEBUG)

    fmt = logging.Formatter("[%(asctime)s] [%(levelname)s] %(message)s",
                            datefmt="%Y-%m-%d %H:%M:%S")

    # Handler fichier
    fh = logging.FileHandler(log_file, encoding="utf-8")
    fh.setFormatter(fmt)

    # Handler terminal
    ch = logging.StreamHandler()
    ch.setFormatter(fmt)

    logger.addHandler(fh)
    logger.addHandler(ch)
    return logger


# =============================================================================
# Scraping / récupération du prix via l'API publique
# =============================================================================

def fetch_price(product: dict, logger: logging.Logger) -> float | None:
    """
    Récupère le prix d'un produit via l'API Fake Store.
    Retourne le prix (float) ou None en cas d'erreur.
    """
    try:
        logger.info(f"Récupération du prix pour : {product['nom']}")
        response = requests.get(product["url"], timeout=10)
        response.raise_for_status()

        data = response.json()
        price = float(data.get("price", 0))
        logger.info(f"  → Prix récupéré : ${price:.2f}")
        return price

    except requests.exceptions.RequestException as e:
        logger.error(f"Erreur réseau pour {product['nom']} : {e}")
        return None
    except (ValueError, KeyError) as e:
        logger.error(f"Erreur de parsing pour {product['nom']} : {e}")
        return None


# =============================================================================
# Lecture / écriture du CSV
# =============================================================================

def init_csv(csv_path: str, logger: logging.Logger) -> None:
    """Crée le CSV avec l'en-tête si inexistant."""
    path = Path(csv_path)
    path.parent.mkdir(parents=True, exist_ok=True)
    if not path.exists():
        with open(path, "w", newline="", encoding="utf-8") as f:
            writer = csv.writer(f)
            writer.writerow(["date", "heure", "produit", "prix", "url"])
        logger.info(f"CSV initialisé : {csv_path}")


def append_price(csv_path: str, product_name: str, price: float,
                 url: str, logger: logging.Logger) -> None:
    """Ajoute une ligne de prix dans le CSV."""
    now = datetime.now()
    with open(csv_path, "a", newline="", encoding="utf-8") as f:
        writer = csv.writer(f)
        writer.writerow([
            now.strftime("%Y-%m-%d"),
            now.strftime("%H:%M:%S"),
            product_name,
            f"{price:.2f}",
            url,
        ])
    logger.info(f"  → Ligne enregistrée dans {csv_path}")


def read_history(csv_path: str) -> list[dict]:
    """Lit tout l'historique du CSV et retourne une liste de dicts."""
    if not Path(csv_path).exists():
        return []
    with open(csv_path, "r", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        return list(reader)


# =============================================================================
# Calcul de la variation de prix
# =============================================================================

def compute_variation(history: list[dict], product_name: str,
                      current_price: float) -> dict:
    """
    Calcule la variation entre le prix actuel et l'avant-dernier relevé
    pour un produit donné.
    Retourne un dict : {previous_price, variation_abs, variation_pct, trend}
    """
    # Filtrer uniquement les lignes du produit concerné
    product_rows = [r for r in history if r["produit"] == product_name]

    if len(product_rows) < 2:
        # Pas assez d'historique (c'est peut-être le 1er relevé)
        return {
            "previous_price": None,
            "variation_abs": None,
            "variation_pct": None,
            "trend": "➡️  Premier relevé",
        }

    previous_price = float(product_rows[-2]["prix"])
    variation_abs  = current_price - previous_price
    variation_pct  = (variation_abs / previous_price) * 100 if previous_price else 0

    if variation_abs > 0:
        trend = f"📈 Hausse de +${variation_abs:.2f} (+{variation_pct:.1f}%)"
    elif variation_abs < 0:
        trend = f"📉 Baisse de ${variation_abs:.2f} ({variation_pct:.1f}%)"
    else:
        trend = "➡️  Prix stable"

    return {
        "previous_price": previous_price,
        "variation_abs": variation_abs,
        "variation_pct": variation_pct,
        "trend": trend,
    }


# =============================================================================
# Génération du rapport texte
# =============================================================================

def generate_rapport(results: list[dict], output_path: str,
                     logger: logging.Logger) -> None:
    """Génère output/rapport.txt avec prix actuels et variations."""
    Path(output_path).parent.mkdir(parents=True, exist_ok=True)
    now = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    lines = []
    lines.append("=" * 60)
    lines.append("  RAPPORT DE SUIVI DE PRIX E-COMMERCE")
    lines.append(f"  Généré le : {now}")
    lines.append("=" * 60)
    lines.append("")

    for r in results:
        lines.append(f"Produit  : {r['nom']}")
        lines.append(f"Prix     : ${r['current_price']:.2f}")
        lines.append(f"Tendance : {r['variation']['trend']}")
        if r["variation"]["previous_price"] is not None:
            lines.append(f"Précédent: ${r['variation']['previous_price']:.2f}")
        lines.append(f"URL      : {r['url']}")
        lines.append("-" * 60)

    lines.append("")
    lines.append(f"Total produits suivis : {len(results)}")
    lines.append(f"Source : Fake Store API (https://fakestoreapi.com)")
    lines.append("=" * 60)

    rapport_content = "\n".join(lines)
    with open(output_path, "w", encoding="utf-8") as f:
        f.write(rapport_content)

    logger.info(f"Rapport texte généré : {output_path}")
    print(rapport_content)


# =============================================================================
# Point d'entrée
# =============================================================================

def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Suivi de prix e-commerce")
    parser.add_argument("--csv",    default=DEFAULT_CSV,    help="Chemin vers le CSV de données")
    parser.add_argument("--output", default=DEFAULT_OUTPUT, help="Chemin du rapport texte")
    parser.add_argument("--log",    default=DEFAULT_LOG,    help="Chemin du fichier de log")
    return parser.parse_args()


def main() -> None:
    args   = parse_args()
    logger = setup_logger(args.log)

    logger.info("=== Démarrage du scraping ===")

    init_csv(args.csv, logger)
    history = read_history(args.csv)  # Lire AVANT d'ajouter les nouvelles lignes

    results = []

    for product in PRODUCTS_TO_TRACK:
        price = fetch_price(product, logger)

        if price is None:
            logger.warning(f"Produit ignoré (erreur fetch) : {product['nom']}")
            continue

        # Calcul de la variation AVANT d'ajouter la nouvelle ligne
        variation = compute_variation(history, product["nom"], price)

        # Enregistrement dans le CSV
        append_price(args.csv, product["nom"], price, product["url"], logger)

        results.append({
            "nom":           product["nom"],
            "current_price": price,
            "url":           product["url"],
            "variation":     variation,
        })

    if results:
        generate_rapport(results, args.output, logger)
        logger.info("=== Scraping terminé avec succès ===")
    else:
        logger.error("Aucun prix récupéré. Vérifiez la connexion réseau.")
        exit(1)


if __name__ == "__main__":
    main()
