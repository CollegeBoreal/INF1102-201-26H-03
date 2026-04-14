Write-Host "=== Analyse des actualités ===" -ForegroundColor Cyan

cd $PSScriptRoot

# Vérifier Python
python --version

# Lancer le script
python analyse.py

Write-Host "=== Analyse terminée ===" -ForegroundColor Green
