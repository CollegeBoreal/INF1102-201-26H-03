#!/usr/bin/env pwsh

# ============================================
# BATCH DEVOPS POWERSHELL
# ============================================

$rapportTxt  = "/devops-batch/rapport.txt"
$rapportJson = "/devops-batch/rapport.json"

$hostname = hostname
$user     = whoami
$date     = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

Write-Output "===== RAPPORT DEVOPS =====" | Tee-Object -FilePath $rapportTxt
Write-Output "Date        : $date"       | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Utilisateur : $user"       | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Machine     : $hostname"   | Tee-Object -FilePath $rapportTxt -Append
Write-Output "" | Tee-Object -FilePath $rapportTxt -Append

Write-Output "Top 5 processus par CPU :" | Tee-Object -FilePath $rapportTxt -Append
$topCPU = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
foreach ($p in $topCPU) {
    Write-Output ("  {0} - CPU: {1:N2} s" -f $p.ProcessName, $p.CPU) | Tee-Object -FilePath $rapportTxt -Append
}

Write-Output "" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Top 5 processus par mémoire (WorkingSet) :" | Tee-Object -FilePath $rapportTxt -Append
$topMem = Get-Process | Sort-Object WorkingSet -Descending | Select-Object -First 5
foreach ($p in $topMem) {
    $memMB = $p.WorkingSet / 1MB
    Write-Output ("  {0} - Mémoire: {1:N2} Mo" -f $p.ProcessName, $memMB) | Tee-Object -FilePath $rapportTxt -Append
}

Write-Output "" | Tee-Object -FilePath $rapportTxt -Append
Write-Output "Espace disque (commande df -h) :" | Tee-Object -FilePath $rapportTxt -Append
$disk = df -h
Write-Output $disk | Tee-Object -FilePath $rapportTxt -Append

Write-Output "" | Tee-Object -FilePath $rapportTxt -Append
$sshHost = "127.0.0.1"
Write-Output "Test SSH vers $sshHost (mode batch) :" | Tee-Object -FilePath $rapportTxt -Append

try {
    $result = ssh -o BatchMode=yes -o ConnectTimeout=5 $sshHost "echo OK" 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Output "  Connexion SSH réussie : $result" | Tee-Object -FilePath $rapportTxt -Append
    } else {
        Write-Output "  Échec SSH (code de sortie : $LASTEXITCODE)" | Tee-Object -FilePath $rapportTxt -Append
    }
} catch {
    Write-Output "  Exception : $_" | Tee-Object -FilePath $rapportTxt -Append
}

$reportObj = [PSCustomObject]@{
    Date        = $date
    Utilisateur = $user
    Machine     = $hostname
    TopCPU      = $topCPU | ForEach-Object { @{ Process = $_.ProcessName; CPU_secondes = $_.CPU } }
    TopMemory   = $topMem | ForEach-Object { @{ Process = $_.ProcessName; Memoire_Mo = [math]::Round($_.WorkingSet / 1MB, 2) } }
    Disk        = $disk
    SSH_Test    = $sshHost
}

$reportObj | ConvertTo-Json -Depth 5 | Set-Content $rapportJson

Write-Output ""
Write-Output "Rapports générés :"
Write-Output "  - Texte : $rapportTxt"
Write-Output "  - JSON  : $rapportJson"
