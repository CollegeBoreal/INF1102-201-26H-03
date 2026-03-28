#!/usr/bin/env pwsh

# =========================
# Batch DevOps PowerShell
# =========================

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

Write-Output "Top Mémoire :" | Tee-Object -FilePath $rapportTxt -Append
$topMem = Get-Process | Sort-Object WS -Descending | Select-Object -First 5

Write-Output "Disque :" | Tee-Object -FilePath $rapportTxt -Append
$disk = df -h
Write-Output $disk | Tee-Object -FilePath $rapportTxt -Append

Write-Output "Test SSH :" | Tee-Object -FilePath $rapportTxt -Append
try {
    $result = ssh -o BatchMode=yes -o ConnectTimeout=5 127.0.0.1 "echo OK"
    Write-Output $result | Tee-Object -FilePath $rapportTxt -Append
} catch {
    Write-Output "SSH échoué" | Tee-Object -FilePath $rapportTxt -Append
}

$reportObj = [PSCustomObject]@{
    Date = $date
    User = $user
    Machine = $hostname
    CPU = $topCPU
    Memory = $topMem
    Disk = $disk
}

$reportObj | ConvertTo-Json -Depth 5 | Set-Content $rapportJson

Write-Output "Rapports générés"
