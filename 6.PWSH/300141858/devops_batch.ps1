#!/usr/bin/env pwsh

# Variables
$rapportTxt = "./rapport.txt"
$rapportJson = "./rapport.json"
$hostname = hostname
$user = whoami
$date = Get-Date

# Rapport texte
"===== RAPPORT DEVOPS =====" | Set-Content $rapportTxt
"Date : $date" | Add-Content $rapportTxt
"Utilisateur : $user" | Add-Content $rapportTxt
"Machine : $hostname" | Add-Content $rapportTxt
"" | Add-Content $rapportTxt

# CPU
"Top 5 CPU :" | Add-Content $rapportTxt
$topCPU = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5 ProcessName, CPU
$topCPU | ForEach-Object {
    "$($_.ProcessName) - CPU: $($_.CPU)" | Add-Content $rapportTxt
}

# Mémoire
"" | Add-Content $rapportTxt
"Top 5 mémoire :" | Add-Content $rapportTxt
$topMem = Get-Process | Sort-Object WS -Descending | Select-Object -First 5 ProcessName, WS
$topMem | ForEach-Object {
    "$($_.ProcessName) - RAM: $($_.WS)" | Add-Content $rapportTxt
}

# Disque
"" | Add-Content $rapportTxt
"Disque :" | Add-Content $rapportTxt
$disk = Get-PSDrive -PSProvider FileSystem | Select-Object Name, Used, Free
$disk | Out-String | Add-Content $rapportTxt

# SSH
"" | Add-Content $rapportTxt
"Test SSH :" | Add-Content $rapportTxt
try {
    $result = ssh -o BatchMode=yes -o ConnectTimeout=5 127.0.0.1 "echo OK" 2>&1
    "Résultat : $result" | Add-Content $rapportTxt
} catch {
    "SSH échoué" | Add-Content $rapportTxt
}

# JSON
$report = [PSCustomObject]@{
    Date   = $date
    User   = $user
    Host   = $hostname
    CPU    = $topCPU
    Memory = $topMem
    Disk   = $disk
}

$report | ConvertTo-Json -Depth 3 | Set-Content $rapportJson

Write-Host "Rapports générés"