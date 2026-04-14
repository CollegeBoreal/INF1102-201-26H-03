# =============================================================
#  Projet IDH Afrique — Script PowerShell (Module PWSH)
#  Étudiant : Frank Laurel | ID : 300143951
#  Cours    : TSI — Collège Boréal — Session Hiver 2025
# =============================================================
#  Usage :
#    .\scripts\analyse.ps1
#    .\scripts\analyse.ps1 -DryRun
#    .\scripts\analyse.ps1 -Country CM -Indicator NY.GDP.PCAP.CD
# =============================================================

param(
    [string]$Country   = "CM",
    [string]$Indicator = "NY.GDP.PCAP.CD",
    [switch]$DryRun    = $false,
    [switch]$FullRun   = $false
)

# ─── Configuration ─────────────────────────────────────────
$ProjectDir  = Split-Path -Parent $PSScriptRoot
$OutputDir   = Join-Path $ProjectDir "output"
$LogFile     = Join-Path $OutputDir "execution_pwsh.log"
$RapportFile = Join-Path $OutputDir "rapport_pwsh.txt"

$Countries = @{
    "CM" = "Cameroun"
    "NG" = "Nigeria"
    "ZA" = "Afrique du Sud"
    "GH" = "Ghana"
    "SN" = "Sénégal"
    "KE" = "Kenya"
}

$Indicators = @{
    "NY.GDP.PCAP.CD" = "PIB par habitant (USD)"
    "SP.DYN.LE00.IN" = "Espérance de vie (ans)"
    "SH.DYN.MORT"    = "Mortalité infantile (‰)"
    "EG.ELC.ACCS.ZS" = "Accès électricité (%)"
    "IT.NET.USER.ZS"  = "Accès internet (%)"
}

$BaseUrl = "https://api.worldbank.org/v2/country/{0}/indicator/{1}?format=json&per_page=10&mrv=10"

# ─── Fonctions ─────────────────────────────────────────────
function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $entry = "[$timestamp] [$Level] $Message"
    
    switch ($Level) {
        "INFO"  { Write-Host $entry -ForegroundColor Cyan }
        "OK"    { Write-Host $entry -ForegroundColor Green }
        "WARN"  { Write-Host $entry -ForegroundColor Yellow }
        "ERROR" { Write-Host $entry -ForegroundColor Red }
        default { Write-Host $entry }
    }
    
    Add-Content -Path $LogFile -Value $entry -Encoding UTF8
}

function Show-Banner {
    Write-Host ""
    Write-Host "╔══════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║    PROJET IDH AFRIQUE — Frank Laurel 300143951      ║" -ForegroundColor Cyan
    Write-Host "║    Collège Boréal — TSI — Session Hiver 2025        ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
}

function Test-APIConnectivity {
    Write-Log "Test de connectivité API World Bank..."
    try {
        $testUrl = "https://api.worldbank.org/v2/country/CM?format=json&per_page=1"
        $response = Invoke-WebRequest -Uri $testUrl -TimeoutSec 10 -UseBasicParsing
        if ($response.StatusCode -eq 200) {
            Write-Log "API World Bank accessible (HTTP 200)" "OK"
            return $true
        }
    } catch {
        Write-Log "API inaccessible : $($_.Exception.Message)" "WARN"
        return $false
    }
    return $false
}

function Get-IndicatorData {
    param(
        [string]$CountryCode,
        [string]$IndicatorCode
    )
    
    $url = $BaseUrl -f $CountryCode, $IndicatorCode
    Write-Log "Requête : $CountryCode / $IndicatorCode"
    
    try {
        $response = Invoke-RestMethod -Uri $url -TimeoutSec 15
        
        # L'API retourne [metadata, data]
        if ($response.Count -lt 2 -or $null -eq $response[1]) {
            Write-Log "Aucune donnée pour $CountryCode / $IndicatorCode" "WARN"
            return @()
        }
        
        $records = @()
        foreach ($entry in $response[1]) {
            if ($null -ne $entry.value -and $entry.value -ne "") {
                $records += [PSCustomObject]@{
                    Annee  = $entry.date
                    Valeur = [math]::Round([double]$entry.value, 2)
                }
            }
        }
        return $records | Sort-Object Annee
        
    } catch {
        Write-Log "Erreur API : $($_.Exception.Message)" "ERROR"
        return @()
    }
}

function Export-RapportPWSH {
    param([hashtable]$AllData)
    
    $lines = @(
        "=" * 65
        "  RAPPORT POWERSHELL — IDH AFRIQUE"
        "  Généré le : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
        "  Étudiant  : Frank Laurel | ID : 300143951"
        "=" * 65
        ""
    )
    
    foreach ($indicatorCode in $AllData.Keys) {
        $indicatorName = $Indicators[$indicatorCode]
        $lines += "─" * 65
        $lines += "  📊 $indicatorName"
        $lines += "─" * 65
        
        $countryData = $AllData[$indicatorCode]
        $latestValues = @{}
        
        foreach ($code in $countryData.Keys) {
            $records = $countryData[$code]
            if ($records.Count -gt 0) {
                $latest = $records | Sort-Object Annee | Select-Object -Last 1
                $latestValues[$code] = $latest.Valeur
            }
        }
        
        $rank = 1
        foreach ($code in ($latestValues.Keys | Sort-Object { $latestValues[$_] } -Descending)) {
            $name   = $Countries[$code]
            $val    = $latestValues[$code]
            $marker = if ($code -eq "CM") { "  ◀ CAMEROUN" } else { "" }
            $lines += "  $rank. $($name.PadRight(20)) $($val.ToString('F2').PadLeft(10))$marker"
            $rank++
        }
        $lines += ""
    }
    
    $lines += @(
        "=" * 65
        "  Ce rapport a été généré par le script PowerShell."
        "  Voir aussi output/rapport.txt (généré par Bash/Python)"
        "=" * 65
    )
    
    $lines | Out-File -FilePath $RapportFile -Encoding UTF8
    Write-Log "Rapport PowerShell généré : $RapportFile" "OK"
}

# ─── PROGRAMME PRINCIPAL ────────────────────────────────────
Show-Banner

# Créer les dossiers si nécessaires
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

Write-Log "Démarrage analyse PowerShell IDH Afrique..."

if ($DryRun) {
    Write-Log "MODE DRY-RUN — Pas d'appels API" "WARN"
    Write-Log "Lancement du script Python en mode test..."
    $pythonScript = Join-Path $PSScriptRoot "analyse.py"
    python3 $pythonScript --dry-run
    exit 0
}

if ($FullRun) {
    # Déléguer l'analyse complète au script Python
    Write-Log "Délégation vers Python pour l'analyse complète..."
    $pythonScript = Join-Path $PSScriptRoot "analyse.py"
    python3 $pythonScript
    exit 0
}

# Mode PowerShell natif — aperçu rapide d'un indicateur/pays
Test-APIConnectivity | Out-Null

$allData = @{}

foreach ($code in $Countries.Keys) {
    foreach ($indCode in $Indicators.Keys) {
        if (-not $allData.ContainsKey($indCode)) {
            $allData[$indCode] = @{}
        }
        $data = Get-IndicatorData -CountryCode $code -IndicatorCode $indCode
        $allData[$indCode][$code] = $data
        Start-Sleep -Milliseconds 300
    }
}

Export-RapportPWSH -AllData $allData

Write-Host ""
Write-Host "✅ Analyse PowerShell terminée !" -ForegroundColor Green
Write-Host "   Rapport : $RapportFile" -ForegroundColor Cyan
Write-Host ""
Write-Host "Pour l'analyse complète avec graphiques, exécuter :" -ForegroundColor Yellow
Write-Host "   .\scripts\analyse.ps1 -FullRun" -ForegroundColor Yellow
