#!/usr/bin/env pwsh

$rapportTxt = "rapport.txt"
$rapportJson = "rapport.json"

$date = Get-Date
$user = whoami
$machine = hostname

Write-Output "===== RAPPORT DEVOPS =====" | Tee-Object $rapportTxt
Write-Output "Date : $date" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Utilisateur : $user" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Machine : $machine" | Tee-Object -FilePath $rapportTxt -Append

Write-Output "" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Top 5 processus CPU :" | Tee-Object -FilePath $rapportTxt -Append

$topCPU = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5

foreach ($p in $topCPU) {
    Write-Output "$($p.ProcessName) - CPU $($p.CPU)" | Tee-Object -FilePath $rapportTxt -Append
}

Write-Output "" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Espace disque :" | Tee-Object -FilePath $rapportTxt -Append

$disk = df -h
$disk | Tee-Object -FilePath $rapportTxt -Append

$report = [PSCustomObject]@{
Date=$date
Utilisateur=$user
Machine=$machine
TopCPU=$topCPU
Disk=$disk
}

$report | ConvertTo-Json -Depth 5 | Set-Content $rapportJson

Write-Output "Rapports générés : $rapportTxt et $rapportJson"#!/usr/bin/env pwsh

$rapportTxt = "rapport.txt"
$rapportJson = "rapport.json"

$date = Get-Date
$user = whoami
$machine = hostname

Write-Output "===== RAPPORT DEVOPS =====" | Tee-Object $rapportTxt
Write-Output "Date : $date" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Utilisateur : $user" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Machine : $machine" | Tee-Object -FilePath $rapportTxt -Append

Write-Output "" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Top 5 processus CPU :" | Tee-Object -FilePath $rapportTxt -Append

$topCPU = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5

foreach ($p in $topCPU) {
    Write-Output "$($p.ProcessName) - CPU $($p.CPU)" | Tee-Object -FilePath $rapportTxt -Append
}

Write-Output "" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Espace disque :" | Tee-Object -FilePath $rapportTxt -Append

$disk = df -h
$disk | Tee-Object -FilePath $rapportTxt -Append

$report = [PSCustomObject]@{
Date=$date
Utilisateur=$user
Machine=$machine
TopCPU=$topCPU
Disk=$disk
}

$report | ConvertTo-Json -Depth 5 | Set-Content $rapportJson#!/usr/bin/env pwsh

$rapportTxt = "rapport.txt"
$rapportJson = "rapport.json"

$date = Get-Date
$user = whoami
$machine = hostname

Write-Output "===== RAPPORT DEVOPS =====" | Tee-Object $rapportTxt
Write-Output "Date : $date" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Utilisateur : $user" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Machine : $machine" | Tee-Object -FilePath $rapportTxt -Append

Write-Output "" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Top 5 processus CPU :" | Tee-Object -FilePath $rapportTxt -Append

$topCPU = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5

foreach ($p in $topCPU) {
    Write-Output "$($p.ProcessName) - CPU $($p.CPU)" | Tee-Object -FilePath $rapportTxt -Append
}

Write-Output "" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Espace disque :" | Tee-Object -FilePath $rapportTxt -Append

$disk = df -h
$disk | Tee-Object -FilePath $rapportTxt -Append

$report = [PSCustomObject]@{
Date=$date
Utilisateur=$user
Machine=$machine
TopCPU=$topCPU
Disk=$disk
}

$report | ConvertTo-Json -Depth 5 | Set-Content $rapportJson

Write-Output "Rapports générés : $rapportTxt et $rapportJson"
