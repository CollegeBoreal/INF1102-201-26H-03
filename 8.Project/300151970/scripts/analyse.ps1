# =============================================================
# Etudiant  : Babatunde Adissa Fadolle Arouna | 300151970
# Hiver     : 2026
# Programme : Techniques des systemes informatiques
# Cours     : INF 1102-201 Programmation de systemes
# Professeur: Brice Robert
# -------------------------------------------------------------
# FICHIER    : scripts/analyse.ps1
# DESCRIPTION: Appelle l API OpenWeatherMap pour 3 villes
#              et sauvegarde les donnees JSON
# TERMINAL   : PowerShell Windows
# COMMANDE   : .\scripts\analyse.ps1
# =============================================================

# --- Configuration des 3 villes ---
$villes  = @("Toronto,CA", "Montreal,CA", "Vancouver,CA")
$apiKey  = "VOTRE_API_KEY"
$units   = "metric"

# --- Chemins des fichiers ---
$root    = "C:\Users\300151970\Developer\INF1102-201-26H-03\8.Project\300151970"
$output  = "$root\data\meteo_raw.json"

# --- Creation des dossiers si absents ---
if (-not (Test-Path "$root\data"))   { New-Item -ItemType Directory -Path "$root\data"   | Out-Null }
if (-not (Test-Path "$root\output")) { New-Item -ItemType Directory -Path "$root\output" | Out-Null }

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host " Suivi Meteo - Toronto, Montreal, Vancouver" -ForegroundColor Cyan
Write-Host "=============================================" -ForegroundColor Cyan

# --- Tableau pour stocker les resultats des 3 villes ---
$resultats = @()

# --- Boucle sur chaque ville ---
foreach ($ville in $villes) {
    Write-Host "[API] Appel pour : $ville ..." -ForegroundColor Yellow
    $url = "http://api.openweathermap.org/data/2.5/weather?q=$ville&appid=$apiKey&units=$units&lang=fr"

    try {
        $response = Invoke-RestMethod -Uri $url -Method GET -ErrorAction Stop
        Write-Host "      Succes - Temp : $($response.main.temp) C" -ForegroundColor Green
        $resultats += $response
    } catch {
        Write-Host "      ERREUR : $($_.Exception.Message)" -ForegroundColor Red
    }
}

# --- Sauvegarde dans le fichier JSON ---
Write-Host "[JSON] Sauvegarde dans : $output" -ForegroundColor Yellow
@{ villes = $resultats } | ConvertTo-Json -Depth 10 | Out-File -FilePath $output -Encoding UTF8
Write-Host "       Sauvegarde OK." -ForegroundColor Green

Write-Host "=============================================" -ForegroundColor Cyan
Write-Host " Donnees sauvegardees dans data/meteo_raw.json" -ForegroundColor Green
Write-Host " Lancez maintenant : bash scripts/analyse.sh sur la VM" -ForegroundColor Green
Write-Host "=============================================" -ForegroundColor Cyan
