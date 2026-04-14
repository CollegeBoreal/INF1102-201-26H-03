Write-Host "=== Projet Scraping BBC News ==="
Write-Host "Lancement de l'analyse via PowerShell..."

# Vérification de Python
if (-not (Get-Command python3 -ErrorAction SilentlyContinue)) {
    Write-Error "Python3 n'est pas installé. Arrêt du script."
    exit 1
}

# Exécution du script Python
python3 scripts/analyse.py

# Vérification des fichiers de sortie
if (Test-Path "output/rapport.txt") {
    Write-Host "Rapport texte généré avec succès."
} else {
    Write-Warning "Le fichier rapport.txt n'a pas été généré."
}

if (Test-Path "data/articles.json") {
    Write-Host "Données JSON générées avec succès."
}

Write-Host "Analyse terminée."
