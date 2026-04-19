#!/usr/bin/env pwsh

# =========================
# Batch DevOps PowerShell
# =========================

# Variables
$rapportTxt = "/devops-batch/rapport.txt"
$rapportJson = "/devops-batch/rapport.json"
$hostname = hostname
$user = whoami
$date = Get-Date

# =========================
# Rapport texte
# =========================
Write-Output "===== RAPPORT DEVOPS =====" | Tee-Object $rapportTxt
Write-Output "Date : $date" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Utilisateur : $user" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Machine : $hostname" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "" | Tee-Object -FilePath $rapportTxt -Append

# =========================
# CPU
# =========================
Write-Output "Top 5 processus par CPU :" | Tee-Object -Append $rapportTxt
$topCPU = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5

foreach ($p in $topCPU) {
    Write-Output ("{0} - CPU: {1}" -f $p.ProcessName, $p.CPU) | Tee-Object -Append $rapportTxt
}

# =========================
# Mémoire
# =========================
Write-Output "" | Tee-Object -Append $rapportTxt
Write-Output "Top 5 processus par mémoire :" | Tee-Object -Append $rapportTxt
$topMem = Get-Process | Sort-Object WS -Descending | Select-Object -First 5

foreach ($p in $topMem) {
    Write-Output ("{0} - Mémoire: {1}" -f $p.ProcessName, $p.WorkingSet) | Tee-Object -Append $rapportTxt
}

# =========================
# Disque
# =========================
Write-Output "" | Tee-Object -Append $rapportTxt
Write-Output "Espace disque :" | Tee-Object -Append $rapportTxt
$disk = df -h
Write-Output $disk | Tee-Object -Append $rapportTxt

# =========================
# SSH
# =========================
Write-Output "" | Tee-Object -Append $rapportTxt
$sshHost = "127.0.0.1"
Write-Output "Test SSH vers $sshHost :" | Tee-Object -Append $rapportTxt

try {
    $result = ssh -o BatchMode=yes -o ConnectTimeout=5 $sshHost "echo OK" 2>&1
    Write-Output "Résultat : $result" | Tee-Object -Append $rapportTxt
}
catch {
    Write-Output "SSH échoué vers $sshHost" | Tee-Object -Append $rapportTxt
}

# =========================
# JSON
# =========================
$reportObj = [PSCustomObject]@{
    Date = $date
    Utilisateur = $user
    Machine = $hostname
    TopCPU = $topCPU | ForEach-Object { @{Process = $_.ProcessName; CPU = $_.CPU} }
    TopMemory = $topMem | ForEach-Object { @{Process = $_.ProcessName; Memory = $_.WorkingSet} }
    Disk = $disk
}

$reportObj | ConvertTo-Json -Depth 5 | Set-Content $rapportJson

Write-Output ""
Write-Output "Rapports générés : $rapportTxt et $rapportJson"
