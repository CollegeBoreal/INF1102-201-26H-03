param(
    [string]$Username
)

if (Get-LocalUser -Name $Username -ErrorAction SilentlyContinue) {
    Write-Host "Utilisateur existe déjà"
}
else {
    New-LocalUser $Username -NoPassword
    Write-Host "Utilisateur créé"
}
