Write-Host "==============================================="
Write-Host " CYBERPULSE INTELLIGENCE - EXECUTION SCRIPT"
Write-Host "==============================================="
Write-Host ""

Write-Host "[1] Running Python analysis..."

Push-Location $PSScriptRoot
Set-Location ..

python .\scripts\analyse.py

Write-Host ""
Write-Host "[2] Analysis completed."
Write-Host "Generated files are available in the output folder."
Write-Host ""
Write-Host "==============================================="

Pop-Location