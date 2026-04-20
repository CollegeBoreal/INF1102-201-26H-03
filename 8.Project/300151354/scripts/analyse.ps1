$url = "https://www.google.com"
$outputFile = "../data/result.json"

$start = Get-Date

$response = Invoke-WebRequest -Uri $url

$end = Get-Date
$time = ($end - $start).TotalMilliseconds

$result = @{
    url = $url
    status = $response.StatusCode
    time = $time
}

$result | ConvertTo-Json | Out-File $outputFile

Write-Host "Test terminé. Résultat sauvegardé."
