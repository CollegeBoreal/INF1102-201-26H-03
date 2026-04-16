# analyse.ps1 - Monitoring site web

$sites = @(
    "https://www.google.com",
    "https://www.github.com",
    "https://www.wikipedia.org"
)

$rapport = "output/rapport.txt"

"📊 Rapport Monitoring - $(Get-Date)" | Out-File $rapport
"----------------------------------" | Out-File $rapport -Append

foreach ($site in $sites) {
    try {
        $debut = Get-Date
        $response = Invoke-WebRequest -Uri $site -TimeoutSec 5
        $duree = ((Get-Date) - $debut).TotalSeconds
        $duree = [math]::Round($duree, 2)
        "✅ $site - Status: $($response.StatusCode) - Temps: $($duree)s" | Out-File $rapport -Append
    } catch {
        "❌ $site - ERREUR: $_" | Out-File $rapport -Append
    }
}

Write-Host "✅ Rapport généré : $rapport"
