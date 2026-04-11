# ============================================================
# analyse.ps1 - Suivi de meteo quotidienne (Weatherstack)
# Description : Recupere les donnees meteo via Weatherstack
#               et appelle le script Python pour l'analyse.
# Usage       : .\scripts\analyse.ps1
# ============================================================

# --- Configuration ---
$city      = "Toronto"
$apiKey    = "e50b937e18b578daa825d84adbae744c"
$outputDir = "output"
$dataDir   = "data"
$jsonFile  = "$dataDir\meteo.json"

# --- Creer les dossiers si absents ---
if (-not (Test-Path $outputDir)) { New-Item -ItemType Directory -Path $outputDir | Out-Null }
if (-not (Test-Path $dataDir))   { New-Item -ItemType Directory -Path $dataDir   | Out-Null }

Write-Host "[INFO] Recuperation des donnees meteo pour : $city" -ForegroundColor Cyan

# --- Appel API Weatherstack ---
$url = "http://api.weatherstack.com/current?access_key=$apiKey&query=$city&units=m"

try {
    $response = Invoke-RestMethod -Uri $url -Method Get -ErrorAction Stop

    # Verifier si l'API retourne une erreur
    if ($response.error) {
        Write-Host "[ERREUR] API : $($response.error.info)" -ForegroundColor Red
        exit 1
    }

    $response | ConvertTo-Json -Depth 5 | Out-File -FilePath $jsonFile -Encoding utf8
    Write-Host "[OK] Donnees meteo sauvegardees dans : $jsonFile" -ForegroundColor Green

} catch {
    Write-Host "[ERREUR] Appel API : $_" -ForegroundColor Red
    exit 1
}

# --- Appel du script Python pour analyse ---
Write-Host "[INFO] Lancement de l'analyse Python..." -ForegroundColor Yellow
python scripts\analyse.py $jsonFile

Write-Host "[OK] Rapport genere dans : $outputDir\rapport.txt" -ForegroundColor Green
Write-Host "[OK] Termine." -ForegroundColor Cyan
