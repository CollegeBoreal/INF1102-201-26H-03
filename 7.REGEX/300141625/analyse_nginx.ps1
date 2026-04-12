$logfile = "/var/log/nginx/access.log"
$rapport = "REGEX/rapport_nginx_ps1_$(Get-Date -Format yyyy-MM-dd).txt"

$lines = Get-Content $logfile

"📊 Rapport Nginx - $(Get-Date)" | Out-File $rapport
"----------------------------------" | Out-File $rapport -Append

$total = $lines.Count
"Total requêtes : $total" | Out-File $rapport -Append

$codes = $lines | ForEach-Object {
    if ($_ -match '" (\d{3}) ') { $matches[1] }
}

$errors = $codes | Where-Object { $_ -match '^[45]' }
"Erreurs HTTP : $($errors.Count)" | Out-File $rapport -Append

$notfound = $codes | Where-Object { $_ -eq "404" }
"Erreurs 404 : $($notfound.Count)" | Out-File $rapport -Append

$servererr = $codes | Where-Object { $_ -eq "500" }
"Erreurs 500 : $($servererr.Count)" | Out-File $rapport -Append

$ips = $lines | ForEach-Object {
    if ($_ -match '^(\d{1,3}(\.\d{1,3}){3})') { $matches[1] }
}

"`nTop 5 IP :" | Out-File $rapport -Append
$ips | Group-Object | Sort-Object Count -Descending | Select-Object -First 5 |
ForEach-Object {
    "$($_.Count) $($_.Name)" | Out-File $rapport -Append
}

$pages = $lines | ForEach-Object {
    if ($_ -match '"GET ([^ ]+)') { $matches[1] }
}

"`nTop 5 pages :" | Out-File $rapport -Append
$pages | Group-Object | Sort-Object Count -Descending | Select-Object -First 5 |
ForEach-Object {
    "$($_.Count) $($_.Name)" | Out-File $rapport -Append
}

Write-Host "✅ Rapport généré : $rapport"
