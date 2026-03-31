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
Write-Output "" | Tee-Object -FilePath $rapportTxt -Append

# =========================
# CPU
# =========================
Write-Output "Top CPU :" | Tee-Object -FilePath $rapportTxt -Append
$topCPU = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
$topCPU | Tee-Object -FilePath $rapportTxt -Append

# =========================
# Mémoire
# =========================
Write-Output "" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Top Mémoire :" | Tee-Object -FilePath $rapportTxt -Append
$topMem = Get-Process | Sort-Object WS -Descending | Select-Object -First 5
$topMem | Tee-Object -FilePath $rapportTxt -Append

# =========================
# Disque
# =========================
Write-Output "" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Disque :" | Tee-Object -FilePath $rapportTxt -Append
$disk = df -h
$disk | Tee-Object -FilePath $rapportTxt -Append

# =========================
# SSH
# =========================
Write-Output "" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Test SSH :" | Tee-Object -FilePath $rapportTxt -Append

try {
    $sshResult = ssh -o BatchMode=yes -o StrictHostKeyChecking=no -o ConnectTimeout=5 localhost "echo OK" 2>&1
    Write-Output "Résultat SSH : $sshResult" | Tee-Object -FilePath $rapportTxt -Append
} catch {
    Write-Output "SSH échoué" | Tee-Object -FilePath $rapportTxt -Append
}

# =========================
# JSON
# =========================
$reportObj = [PSCustomObject]@{
    Date        = $date
    Utilisateur = $user
    Machine     = $hostname
    TopCPU      = $topCPU
    TopMemory   = $topMem
}

$reportObj | ConvertTo-Json -Depth 3 | Set-Content $rapportJson

Write-Output ""
Write-Output "Rapports générés : $rapportTxt et $rapportJson"
