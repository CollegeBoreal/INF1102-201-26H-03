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

# CPU
Write-Output "Top CPU :" | Tee-Object -FilePath $rapportTxt -Append
$topCPU = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
$topCPU | Tee-Object -FilePath $rapportTxt -Append

# Mémoire
Write-Output "Top mémoire :" | Tee-Object -FilePath $rapportTxt -Append
$topMem = Get-Process | Sort-Object WS -Descending | Select-Object -First 5
$topMem | Tee-Object -FilePath $rapportTxt -Append

# Disque
$disk = df -h
$disk | Tee-Object -FilePath $rapportTxt -Append

# SSH test
$sshHost = "127.0.0.1"
try {
    $result = ssh -o BatchMode=yes -o ConnectTimeout=5 $sshHost "echo OK" 2>&1
    Write-Output "SSH OK : $result" | Tee-Object -FilePath $rapportTxt -Append
} catch {
    Write-Output "SSH FAIL" | Tee-Object -FilePath $rapportTxt -Append
}

# JSON
$report = [PSCustomObject]@{
    Date = $date
    User = $user
    Machine = $hostname
    CPU = $topCPU
    Memory = $topMem
    Disk = $disk
}

$report | ConvertTo-Json -Depth 5 | Set-Content $rapportJson

Write-Output "Rapports générés"
