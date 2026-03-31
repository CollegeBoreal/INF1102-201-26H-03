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

# Nettoyage ancien rapport
Remove-Item $rapportTxt -ErrorAction SilentlyContinue
Remove-Item $rapportJson -ErrorAction SilentlyContinue

# Fonction écriture
function Write-Report {
    param ($text)
    $text | Tee-Object -FilePath $rapportTxt -Append
}

# =========================
# En-tête
# =========================
Write-Report "===== RAPPORT DEVOPS ====="
Write-Report "Date : $date"
Write-Report "Utilisateur : $user"
Write-Report "Machine : $hostname"
Write-Report ""

# =========================
# CPU
# =========================
Write-Report "Top 5 processus par CPU :"
$topCPU = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5

foreach ($p in $topCPU) {
    Write-Report ("{0} - CPU: {1}" -f $p.ProcessName, [math]::Round($p.CPU,2))
}

# =========================
# Mémoire
# =========================
Write-Report ""
Write-Report "Top 5 processus par mémoire :"

$topMem = Get-Process | Sort-Object WS -Descending | Select-Object -First 5

foreach ($p in $topMem) {
    $memMB = [math]::Round($p.WorkingSet / 1MB, 2)
    Write-Report ("{0} - Mémoire: {1} MB" -f $p.ProcessName, $memMB)
}

# =========================
# Disque
# =========================
Write-Report ""
Write-Report "Espace disque :"

$disk = df -h
$disk | ForEach-Object { Write-Report $_ }

# =========================
# Test SSH
# =========================
Write-Report ""
$sshHost = "127.0.0.1"
Write-Report "Test SSH vers $sshHost :"

try {
    $result = ssh -o BatchMode=yes -o ConnectTimeout=5 $sshHost "echo OK" 2>&1
    Write-Report "Résultat : $result"
} catch {
    Write-Report "SSH échoué vers $sshHost"
}

# =========================
# JSON
# =========================
$reportObj = [PSCustomObject]@{
    Date        = $date
    Utilisateur = $user
    Machine     = $hostname
    TopCPU      = $topCPU | ForEach-Object { 
        @{ Process = $_.ProcessName; CPU = $_.CPU } 
    }
    TopMemory   = $topMem | ForEach-Object { 
        @{ Process = $_.ProcessName; MemoryMB = [math]::Round($_.WorkingSet / 1MB,2) } 
    }
    Disk        = $disk
}

$reportObj | ConvertTo-Json -Depth 5 | Set-Content $rapportJson

Write-Output ""
Write-Output "✅ Rapports générés :"
Write-Output "$rapportTxt"
Write-Output "$rapportJson"
