#!/usr/bin/env pwsh

# ========================
# Scraper BBC News
# ========================

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectDir = Split-Path -Parent $scriptDir
$outputFile = "$projectDir/output/rapport.txt"
$logFile = "$projectDir/data/sample.log"

Write-Host "====================================" -ForegroundColor Cyan
Write-Host "  SCRAPER BBC NEWS - PowerShell" -ForegroundColor Cyan
Write-Host "====================================" -ForegroundColor Cyan
Write-Host ""

# ========================
# Récupération RSS BBC
# ========================
Write-Host "📰 Récupération des nouvelles BBC..." -ForegroundColor Yellow

try {
    $url = "https://feeds.bbci.co.uk/news/rss.xml"
    $response = Invoke-RestMethod -Uri $url -TimeoutSec 10
    $items = $response.channel.item | Select-Object -First 20
    Write-Host "✅ $($items.Count) nouvelles récupérées" -ForegroundColor Green
} catch {
    Write-Host "❌ Erreur: $_" -ForegroundColor Red
    exit 1
}

# ========================
# Log des titres
# ========================
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
"[$date] Scraping BBC News" | Out-File $logFile
foreach ($item in $items) {
    "[$date] TITRE: $($item.title)" | Out-File $logFile -Append
}
Write-Host "📝 Log sauvegardé : $logFile" -ForegroundColor Green

# ========================
# Appel script Python
# ========================
Write-Host ""
Write-Host "🐍 Lancement analyse Python..." -ForegroundColor Yellow
Set-Location $projectDir
python3 scripts/analyse.py

Write-Host ""
Write-Host "====================================" -ForegroundColor Cyan
Write-Host "✅ Rapport généré : $outputFile" -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Cyan
