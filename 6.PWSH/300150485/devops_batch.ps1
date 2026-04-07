#!/usr/bin/env pwsh

$rapportTxt = "/devops-batch/rapport.txt"
$rapportJson = "/devops-batch/rapport.json"
$hostname = hostname
$user = whoami
$date = Get-Date

Write-Output "===== RAPPORT DEVOPS =====" | Tee-Object $rapportTxt
Write-Output "Date : $date" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Utilisateur : $user" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Machine : $hostname" | Tee-Object -FilePath $rapportTxt -Append

Write-Output "Top CPU :" | Tee-Object -FilePath $rapportTxt -Append
$topCPU = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
$topCPU | Tee-Object -FilePath $rapportTxt -Append

Write-Output "Top mémoire :" | Tee-Object -FilePath $rapportTxt -Append
$topMem = Get-Process | Sort-Object WS -Descending | Select-Object -First 5
$topMem | Tee-Object -FilePath $rapportTxt -Append

Write-Output "Disque :" | Tee-Object -FilePath $rapportTxt -Append
$disk = df -h
$disk | Tee-Object -FilePath $rapportTxt -Append

$reportObj = [PSCustomObject]@{
    Date = $date
    Utilisateur = $user
    Machine = $hostname
    TopCPU = $topCPU
    TopMemory = $topMem
    Disk = $disk
}

$reportObj | ConvertTo-Json -Depth 5 | Set-Content $rapportJson

Write-Output "Rapports générés"

