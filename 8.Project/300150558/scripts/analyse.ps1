# analyse.ps1
Write-Host "Installation des dependances Python..."
pip3 install -r scripts/requirements.txt

Write-Host "Lancement de l'analyse des sites web..."
python3 scripts/analyse.py

Write-Host "Analyse terminee."
Write-Host "Fichier genere : output/rapport.txt"
Write-Host "Graphique genere : output/temps_reponse.png"
