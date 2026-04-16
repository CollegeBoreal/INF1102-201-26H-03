#!/usr/bin/env pwsh
# ============================================================
#  analyse_nginx.ps1 — Analyse avancée des logs Nginx
#  Auteur  : Frank | Collège Boréal — TSI 2026
#  Version : 2.1
# ============================================================

param(
    [string]$LogFile  = "/var/log/nginx/access.log",
    [string]$OutDir   = $PSScriptRoot,
    [int]   $TopN     = 10,
    [switch]$NoColor
)

# ── Couleurs console ────────────────────────────────────────
function cWrite([string]$msg, [string]$color = "White") {
    if ($NoColor) { Write-Host $msg }
    else          { Write-Host $msg -ForegroundColor $color }
}

# ── Vérifications préliminaires ─────────────────────────────
if (-not (Test-Path $LogFile)) {
    cWrite "ERREUR : fichier log introuvable → $LogFile" "Red"
    exit 1
}

if (-not (Test-Path $OutDir)) {
    New-Item -ItemType Directory -Path $OutDir -Force | Out-Null
}

$date    = Get-Date -Format "yyyy-MM-dd"
$rapport = Join-Path $OutDir "rapport_nginx_ps1_$date.txt"

cWrite "`n  Analyse Nginx — $date" "Cyan"
cWrite "  Lecture de : $LogFile" "DarkGray"

# ── Lecture du fichier ──────────────────────────────────────
$lines = Get-Content $LogFile -ErrorAction Stop
$total = $lines.Count
cWrite "  Lignes chargées : $total`n" "DarkGray"

# ── Regex de parsing ────────────────────────────────────────
$reMain = '^(?<ip>[\d.]+)\s+-\s+-\s+\[(?<dt>[^\]]+)\]\s+"(?<method>[A-Z]+)\s+(?<path>[^\s]+)\s+HTTP/[\d.]+"\s+(?<code>\d{3})\s+(?<size>\d+)'

# ── Extraction des champs ───────────────────────────────────
$parsed = foreach ($line in $lines) {
    if ($line -match $reMain) {
        [PSCustomObject]@{
            IP     = $Matches['ip']
            Date   = $Matches['dt']
            Method = $Matches['method']
            Path   = $Matches['path']
            Code   = $Matches['code']
            Size   = [long]$Matches['size']
        }
    }
}

$parsed = @($parsed)
$parsedCount = $parsed.Count

# ── Calculs ─────────────────────────────────────────────────
$codes   = $parsed | Group-Object Code | Sort-Object Name
$errors4 = @($parsed | Where-Object { $_.Code -match '^4' })
$errors5 = @($parsed | Where-Object { $_.Code -match '^5' })
$gets    = @($parsed | Where-Object { $_.Method -eq 'GET' })
$posts   = @($parsed | Where-Object { $_.Method -eq 'POST' })

$totalBytes = ($parsed | Measure-Object -Property Size -Sum).Sum
if (-not $totalBytes) { $totalBytes = 0 }

$avgBytes = if ($parsedCount -gt 0) {
    [math]::Round($totalBytes / $parsedCount)
} else {
    0
}

$topIPs = $parsed |
    Group-Object IP |
    Sort-Object Count -Descending |
    Select-Object -First $TopN

$topPaths = $gets |
    Group-Object Path |
    Sort-Object Count -Descending |
    Select-Object -First $TopN

# Correction : forcer les collections avant concaténation
$topErrors = @($errors4) + @($errors5) |
    Group-Object Path |
    Sort-Object Count -Descending |
    Select-Object -First 5

# ── Affichage console ───────────────────────────────────────
$nb4 = $errors4.Count
$nb5 = $errors5.Count

cWrite "  RÉSUMÉ" "Yellow"
cWrite "  ──────────────────────────────────────" "DarkGray"
cWrite "  Total requêtes analysées : $parsedCount / $total" "White"
cWrite "  Erreurs 4xx              : $nb4" $(if ($nb4 -gt 0) { "Red" } else { "Green" })
cWrite "  Erreurs 5xx              : $nb5" $(if ($nb5 -gt 0) { "DarkRed" } else { "Green" })
cWrite "  Bande passante totale    : $([math]::Round($totalBytes / 1MB, 2)) MB" "White"
cWrite "  Taille moy. réponse      : $avgBytes octets`n" "White"

# ── Rédaction du rapport ────────────────────────────────────
$sep  = "=" * 60
$sep2 = "-" * 40

$report = @"
$sep
  RAPPORT D'ANALYSE NGINX
  Généré le : $(Get-Date)
  Fichier   : $LogFile
$sep

RÉSUMÉ GÉNÉRAL
$sep2
  Lignes totales          : $total
  Requêtes analysées      : $parsedCount
  Requêtes GET            : $($gets.Count)
  Requêtes POST           : $($posts.Count)
  Erreurs 4xx             : $nb4
  Erreurs 5xx             : $nb5
  Bande passante totale   : $([math]::Round($totalBytes / 1MB, 2)) MB
  Taille moyenne réponse  : $avgBytes octets

DISTRIBUTION DES CODES HTTP
$sep2
"@

foreach ($g in $codes) {
    $pct = if ($parsedCount -gt 0) {
        [math]::Round(($g.Count * 100) / $parsedCount, 1)
    } else {
        0
    }

    $barLength = if ($parsedCount -gt 0) {
        [math]::Min([math]::Round(($g.Count * 30) / $parsedCount), 30)
    } else {
        0
    }

    $bar = "#" * $barLength

    $report += "  HTTP $($g.Name) : $($g.Count.ToString().PadLeft(6)) req  ($pct%)  $bar`n"
}

$report += @"

TOP $TopN ADRESSES IP
$sep2
"@

foreach ($ip in $topIPs) {
    $report += "  $($ip.Count.ToString().PadLeft(6)) req  —  $($ip.Name)`n"
}

$report += @"

TOP $TopN PAGES DEMANDÉES (GET)
$sep2
"@

foreach ($p in $topPaths) {
    $report += "  $($p.Count.ToString().PadLeft(6)) req  —  $($p.Name)`n"
}

if ($topErrors.Count -gt 0) {
    $report += @"

TOP 5 URLS EN ERREUR (4xx / 5xx)
$sep2
"@

    foreach ($e in $topErrors) {
        $report += "  $($e.Count.ToString().PadLeft(6)) erreurs  —  $($e.Name)`n"
    }
}

$report += @"

$sep
  Fin du rapport — analyse_nginx.ps1 v2.1
$sep
"@

$report | Out-File -FilePath $rapport -Encoding UTF8

cWrite "  Rapport enregistré : $rapport`n" "Green"
