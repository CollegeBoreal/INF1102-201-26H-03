# ============================================================
#  analyse.ps1 - Récupération des données COVID-19 via API
#  API utilisée : disease.sh (Open Disease Data)
#  Remplace covid19api.com (service arrêté en mai 2023)
# ============================================================

param(
    [string[]]$Pays = @("France", "Canada", "Germany", "Italy", "US"),
    [string]$OutputDir = "..\output",
    [string]$DataDir   = "..\data"
)

# ── Couleurs console ──────────────────────────────────────────
function Write-Info  { param($m) Write-Host "[INFO] $m"  -ForegroundColor Cyan   }
function Write-Ok    { param($m) Write-Host "[OK]   $m"  -ForegroundColor Green  }
function Write-Err   { param($m) Write-Host "[ERR]  $m"  -ForegroundColor Red    }
function Write-Title { param($m) Write-Host "`n===== $m =====" -ForegroundColor Yellow }

# ── Dossiers ─────────────────────────────────────────────────
foreach ($dir in @($OutputDir, $DataDir)) {
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir | Out-Null }
}

$BaseUrl     = "https://disease.sh/v3/covid-19"
$Timestamp   = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$AllCountries = @()

Write-Title "RÉCUPÉRATION DES DONNÉES COVID-19"
Write-Info "Source : disease.sh (Open Disease Data)"
Write-Info "Date   : $Timestamp"
Write-Info "Pays   : $($Pays -join ', ')"

# ── 1. Données mondiales ──────────────────────────────────────
Write-Title "Statistiques mondiales"
try {
    $GlobalRaw  = Invoke-RestMethod -Uri "$BaseUrl/all" -Method Get -UseBasicParsing
    $GlobalData = [PSCustomObject]@{
        type       = "global"
        date       = $Timestamp
        cases      = $GlobalRaw.cases
        deaths     = $GlobalRaw.deaths
        recovered  = $GlobalRaw.recovered
        active     = $GlobalRaw.active
        critical   = $GlobalRaw.critical
        tests      = $GlobalRaw.tests
        population = $GlobalRaw.population
        updated    = [DateTimeOffset]::FromUnixTimeMilliseconds($GlobalRaw.updated).ToString("yyyy-MM-dd HH:mm:ss")
    }
    Write-Ok ("Cas confirmés : {0:N0}" -f $GlobalData.cases)
    Write-Ok ("Décès         : {0:N0}" -f $GlobalData.deaths)
    Write-Ok ("Guérisons     : {0:N0}" -f $GlobalData.recovered)
} catch {
    Write-Err "Impossible de récupérer les données mondiales : $_"
    exit 1
}

# ── 2. Données par pays ───────────────────────────────────────
Write-Title "Statistiques par pays"
$CountriesData = @()

foreach ($country in $Pays) {
    Write-Info "Récupération : $country"
    try {
        $raw = Invoke-RestMethod -Uri "$BaseUrl/countries/$country" -Method Get -UseBasicParsing
        $obj = [PSCustomObject]@{
            country         = $raw.country
            countryCode     = $raw.countryInfo.iso2
            continent       = $raw.continent
            cases           = $raw.cases
            todayCases      = $raw.todayCases
            deaths          = $raw.deaths
            todayDeaths     = $raw.todayDeaths
            recovered       = $raw.recovered
            todayRecovered  = $raw.todayRecovered
            active          = $raw.active
            critical        = $raw.critical
            casesPerMillion = $raw.casesPerOneMillion
            deathsPerMillion= $raw.deathsPerOneMillion
            tests           = $raw.tests
            testsPerMillion = $raw.testsPerOneMillion
            population      = $raw.population
            mortalityRate   = if ($raw.cases -gt 0) { [math]::Round(($raw.deaths / $raw.cases) * 100, 2) } else { 0 }
            recoveryRate    = if ($raw.cases -gt 0) { [math]::Round(($raw.recovered / $raw.cases) * 100, 2) } else { 0 }
        }
        $CountriesData += $obj
        Write-Ok ("  Cas: {0:N0} | Décès: {1:N0} | Létalité: {2}%%" -f $obj.cases, $obj.deaths, $obj.mortalityRate)
    } catch {
        Write-Err "  Impossible de récupérer $country : $_"
    }
}

# ── 3. Données historiques (France) ──────────────────────────
Write-Title "Données historiques - France (30 derniers jours)"
$HistoricalData = @()
try {
    $hist = Invoke-RestMethod -Uri "$BaseUrl/historical/France?lastdays=30" -Method Get -UseBasicParsing
    $dates = $hist.timeline.cases.PSObject.Properties.Name

    foreach ($date in $dates) {
        $HistoricalData += [PSCustomObject]@{
            date      = $date
            cases     = $hist.timeline.cases.$date
            deaths    = $hist.timeline.deaths.$date
            recovered = $hist.timeline.recovered.$date
        }
    }
    Write-Ok "$($HistoricalData.Count) entrées récupérées pour la France"
} catch {
    Write-Err "Impossible de récupérer l'historique : $_"
}

# ── 4. Export JSON ────────────────────────────────────────────
Write-Title "Export des fichiers"

$FinalPayload = [PSCustomObject]@{
    metadata    = [PSCustomObject]@{
        source      = "disease.sh - Open Disease Data"
        endpoint    = $BaseUrl
        extracted   = $Timestamp
        pays        = $Pays
    }
    global      = $GlobalData
    countries   = $CountriesData
    historical  = $HistoricalData
}

$JsonPath  = Join-Path $DataDir "covid_data.json"
$CsvPath   = Join-Path $DataDir "covid_countries.csv"

$FinalPayload | ConvertTo-Json -Depth 10 | Out-File -FilePath $JsonPath -Encoding UTF8
Write-Ok "JSON exporté : $JsonPath"

# Export CSV pays
$CountriesData | Export-Csv -Path $CsvPath -NoTypeInformation -Encoding UTF8
Write-Ok "CSV exporté  : $CsvPath"

# ── 5. Résumé console ────────────────────────────────────────
Write-Title "RÉSUMÉ FINAL"
Write-Host "`n  Monde" -ForegroundColor White
Write-Host ("    Cas total   : {0,15:N0}" -f $GlobalData.cases)
Write-Host ("    Décès total : {0,15:N0}" -f $GlobalData.deaths)
Write-Host ("    Guérisons   : {0,15:N0}" -f $GlobalData.recovered)

Write-Host "`n  Par pays (Top 5)" -ForegroundColor White
$CountriesData | Sort-Object cases -Descending | Select-Object -First 5 | ForEach-Object {
    Write-Host ("    {0,-12} | Cas: {1,12:N0} | Décès: {2,8:N0} | Létalité: {3,5}%%" `
        -f $_.country, $_.cases, $_.deaths, $_.mortalityRate)
}

Write-Host "`n[OK] Script terminé avec succès !`n" -ForegroundColor Green
