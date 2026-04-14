Write-Host "=== Rapport système ==="
Get-PSDrive
Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
