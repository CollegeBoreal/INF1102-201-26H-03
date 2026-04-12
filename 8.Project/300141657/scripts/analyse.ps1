$Url = "https://www.google.com"

Write-Host "Debut du monitoring"

$OutputDir = ".\output"
$CsvFile = ".\output\monitoring.csv"
$ReportFile = ".\output\rapport.txt"
$PythonScript = ".\scripts\analyse.py"

if (!(Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

if (!(Test-Path $CsvFile)) {
    "timestamp,url,status_code,response_time_ms,error" | Set-Content -Encoding ASCII $CsvFile
}

$TimeStamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$StatusCode = ""
$ResponseTimeMs = 0
$ErrorMessage = ""

$Stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

try {
    $Response = Invoke-WebRequest -Uri $Url -UseBasicParsing -TimeoutSec 15
    $Stopwatch.Stop()
    $ResponseTimeMs = [math]::Round($Stopwatch.Elapsed.TotalMilliseconds, 2)
    $StatusCode = $Response.StatusCode
}
catch {
    $Stopwatch.Stop()
    $ResponseTimeMs = [math]::Round($Stopwatch.Elapsed.TotalMilliseconds, 2)
    $StatusCode = "ERROR"
    $ErrorMessage = $_.Exception.Message
}

Add-Content -Encoding ASCII $CsvFile "`"$TimeStamp`",`"$Url`",`"$StatusCode`",`"$ResponseTimeMs`",`"$ErrorMessage`""

Write-Host "CSV cree ou mis a jour"

python .\scripts\analyse.py .\output\monitoring.csv .\output\rapport.txt

Write-Host "Fin du monitoring"