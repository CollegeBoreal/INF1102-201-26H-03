# analyse.ps1
# Lance le script Python pour générer le rapport

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$ProjectDir = Split-Path -Parent $ScriptDir
$PythonScript = Join-Path $ScriptDir "create_rapport.py"
$OutputFile = Join-Path $ProjectDir "output\rapport.txt"

Write-Host "Demarrage de l'analyse..." -ForegroundColor Cyan

if (-Not (Test-Path $PythonScript)) {
    Write-Host "Erreur : fichier create_rapport.py introuvable" -ForegroundColor Red
    exit 1
}

python3 $PythonScript

if (Test-Path $OutputFile) {
    Write-Host "Rapport genere avec succes :" -ForegroundColor Green
    Get-Content $OutputFile
} else {
    Write-Host "Erreur : rapport non genere" -ForegroundColor Red
}
