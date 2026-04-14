$Process = "notepad"

if (Get-Process -Name $Process -ErrorAction SilentlyContinue) {
    Write-Host "Processus actif"
}
else {
    Write-Host "Processus non actif"
}
