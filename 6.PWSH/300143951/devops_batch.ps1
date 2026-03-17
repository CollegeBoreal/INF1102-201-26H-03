#!/usr/bin/env pwsh

# =========================
# Batch DevOps PowerShell (Final Linux)
# =========================

$ErrorActionPreference = "Stop"

# Variables
$basePath = "/devops-batch"
$rapportTxt = "$basePath/rapport.txt"
$rapportJson = "$basePath/rapport.json"
$logMaxSize = 5MB

# Création dossier
if (!(Test-Path $basePath)) {
    New-Item -ItemType Directory -Path $basePath | Out-Null
}

# Rotation logs
if (Test-Path $rapportTxt) {
    if ((Get-Item $rapportTxt).Length -gt $logMaxSize) {
        Rename-Item $rapportTxt "$rapportTxt.old" -Force
    }
}

# Temps début
$start = Get-Date

# Infos système
$hostname = hostname
$user = whoami
$date = Get-Date

# Fonction log
function Log {
    param($message, $level="INFO")
    $line = "[$level] $(Get-Date) - $message"
    $line | Tee-Object -FilePath $rapportTxt -Append
}

Log "===== RAPPORT DEVOPS ====="
Log "Utilisateur : $user"
Log "Machine : $hostname"

# =========================
# CPU & Mémoire
# =========================
try {
    Log "Analyse CPU"
    $topCPU = Get-Process | Select-Object ProcessName, CPU | Sort-Object CPU -Descending | Select-Object -First 5

    foreach ($p in $topCPU) {
        Log "$($p.ProcessName) - CPU: $($p.CPU)"
    }

    Log "Analyse Mémoire"
    $topMem = Get-Process | Select-Object ProcessName, WS | Sort-Object WS -Descending | Select-Object -First 5

    foreach ($p in $topMem) {
        Log "$($p.ProcessName) - Mémoire: $($p.WS)"
    }
}
catch {
    Log "Erreur analyse processus : $_" "ERROR"
}

# =========================
# Disque
# =========================
try {
    Log "Analyse disque"
    $disk = df -h
    $disk | ForEach-Object { Log $_ }
}
catch {
    Log "Erreur disque : $_" "ERROR"
}

# =========================
# Test SSH (compatible Linux)
# =========================
try {
    $sshHost = "127.0.0.1"
    Log "Test SSH vers $sshHost"

    $result = ssh -o BatchMode=yes -o ConnectTimeout=5 $sshHost "echo OK" 2>&1

    if ($LASTEXITCODE -eq 0) {
        Log "SSH OK"
    } else {
        Log "SSH échoué" "WARNING"
    }
}
catch {
    Log "Erreur SSH : $_" "ERROR"
}

# =========================
# JSON structuré
# =========================
try {
    $reportObj = [PSCustomObject]@{
        Date        = $date
        Utilisateur = $user
        Machine     = $hostname
        TopCPU      = $topCPU
        TopMemory   = $topMem
        Disk        = $disk
    }

    $reportObj | ConvertTo-Json -Depth 5 | Set-Content $rapportJson
}
catch {
    Log "Erreur génération JSON : $_" "ERROR"
}

# =========================
# Durée d'exécution
# =========================
$end = Get-Date
$duration = $end - $start
Log "Durée d'exécution : $duration"

Log "Rapports générés : $rapportTxt et $rapportJson"
Log "===== FIN ====="
