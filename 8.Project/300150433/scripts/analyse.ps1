#!/usr/bin/env pwsh

Write-Host "=== GLOBAL NEWS ANALYZER ===" -ForegroundColor Cyan

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$projectDir = Split-Path -Parent $scriptDir
$logFile = "$projectDir/data/sample.log"

# Nettoyer ancien log
Clear-Content $logFile

# URL RSS
$url = "https://feeds.bbci.co.uk/news/rss.xml"

Write-Host "Récupération RSS..."

try {
    $response = Invoke-WebRequest -Uri $url
    $content = $response.Content

    # Extraction titres avec regex
    $titles = Select-String -InputObject $content -Pattern "<title>(.*?)</title>" -AllMatches

    $i = 0
    foreach ($match in $titles.Matches) {
        if ($i -gt 0 -and $i -le 20) {  # skip titre principal
            $title = $match.Groups[1].Value
            $date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
            "$date | $title" | Out-File $logFile -Append
        }
        $i++
    }

    Write-Host "✔ Titres récupérés : $i"

} catch {
    Write-Host "Erreur RSS"
    exit
}

# Lancer Python
Set-Location $projectDir
python3 scripts/analyse.py

Write-Host "✔ Rapport généré"
