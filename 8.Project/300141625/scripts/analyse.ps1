# Script PowerShell - Monitoring de site web

$url = "https://www.google.com"
$output = "output/rapport_ps1.txt"
$resultats = @()

Write-Host "🚀 Démarrage du monitoring..."

for ($i = 1; $i -le 5; $i++) {
    $debut = Get-Date
    try {
        $response = Invoke-WebRequest -Uri $url -TimeoutSec 10
        $duree = [math]::Round(((Get-Date) - $debut).TotalSeconds, 2)
        $resultats += [PSCustomObject]@{ Status = $response.StatusCode; Duree = $duree }
    } catch {
        $resultats += [PSCustomObject]@{ Status = 0; Duree = 0 }
    }
    Start-Sleep -Seconds 1
}

$total = $resultats.Count
$succes = ($resultats | Where-Object { $_.Status -eq 200 }).Count
$erreurs = $total - $succes
$tempsMoyen = [math]::Round(($resultats | Measure-Object -Property Duree -Average).Average, 2)

"Rapport de monitoring - $(Get-Date -Format yyyy-MM-dd)" | Out-File $output
"-----------------------------------" | Out-File $output -Append
"Site surveillé : $url" | Out-File $output -Append
"Total requêtes : $total" | Out-File $output -Append
"Succès (200)   : $succes" | Out-File $output -Append
"Erreurs        : $erreurs" | Out-File $output -Append
"Temps moyen    : $($tempsMoyen)s" | Out-File $output -Append

Write-Host "✅ Rapport généré : $output"
