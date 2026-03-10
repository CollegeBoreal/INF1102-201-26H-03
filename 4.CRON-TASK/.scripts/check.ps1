#!/usr/bin/env pwsh
# --------------------------------------
# PowerShell participation script using $STUDENTS array and group selection
# Supports 3 groups
# --------------------------------------

param(
    [ValidateSet(1,2,3)]
    [int]$Group = 1
)

# Import variables from another script (students.ps1)
. ../.scripts/students.ps1

# -------------------------------
# Définir le groupe actif
# -------------------------------
switch ($Group) {
    1 { 
        $ACTIVE_GROUP   = $GROUP_1
        $ACTIVE_SERVERS = $SERVER_GROUP_1
        $PROXMOX_SERVER = $PROXMOX_GROUP_1
        $TOFU_SECRET    = $TOFU_SECRET_GROUP_1
    }
    2 { 
        $ACTIVE_GROUP   = $GROUP_2
        $ACTIVE_SERVERS = $SERVER_GROUP_2
        $PROXMOX_SERVER = $PROXMOX_GROUP_2
        $TOFU_SECRET    = $TOFU_SECRET_GROUP_2
    }
    3 { 
        $ACTIVE_GROUP   = $GROUP_3
        $ACTIVE_SERVERS = $SERVER_GROUP_3
        $PROXMOX_SERVER = $PROXMOX_GROUP_3
        $TOFU_SECRET    = $TOFU_SECRET_GROUP_3
    }
    default { throw "Groupe invalide" }
}

# -------------------------------
# Header et table des matières
# -------------------------------
Write-Output "# Participation – Groupe $Group"
Write-Output ""

Write-Output "| Table des matières            | Description                                             |"
Write-Output "|-------------------------------|---------------------------------------------------------|"
Write-Output "| :a: [Présence](#a-présence)   | L'étudiant.e a fait son travail    :heavy_check_mark:   |"
Write-Output "| :b: [Précision](#b-précision) | L'étudiant.e a réussi son travail  :tada:               |"
Write-Output ""

# Légende
Write-Output "## Légende"
Write-Output ""
Write-Output "| Signe              | Signification                 |"
Write-Output "|--------------------|-------------------------------|"
Write-Output "| :heavy_check_mark: | Prêt à être corrigé           |"
Write-Output "| :x:                | Projet inexistant             |"
Write-Output "| :green_circle:     | VM en cours d'exécution       |"
Write-Output "| :orange_circle:    | VM arrêtée                    |"
Write-Output ""

# Configuration Proxmox / TOFU
Write-Output "## :gear: Configuration"
Write-Output ""
Write-Output "| Proxmox Serveur                                     | User/Pwd         |"
Write-Output "|-----------------------------------------------------|------------------|"
Write-Output "| [${PROXMOX_SERVER}](https://${PROXMOX_SERVER}:8006) | root/Boreal@2️⃣02️⃣6 |"
Write-Output ""
Write-Output "| TOFU Credentials                                    | :closed_lock_with_key: Secret |"
Write-Output "|-----------------------------------------------------|------------------|"
Write-Output "| tofu@pve!opentofu                                   | ${TOFU_SECRET}   |"
Write-Output ""

# Présence table
Write-Output "## :a: Présence"
Write-Output ""
Write-Output "|:hash:| Boréal :id:                | README.md | images | scruter_nginx.sh | VM | <image src='https://avatars0.githubusercontent.com/u/62551735?s=460&v=4' width=20 height=20></image> SSH |"
Write-Output "|------|----------------------------|-----------|--------|---------|----|-----|"

# -------------------------------
# Initialisation
# -------------------------------
$i = 0
$s = 0

# Récupérer la liste des VMs via SSH sur le serveur du groupe
$VM_LIST = ssh -i ~/.ssh/${PK_PROF} root@${PROXMOX_SERVER} 'qm list | awk "NR>1 {print \$2 \" \" \$3}"'

# Construire un hashtable pour VM -> état
$VM_STATUS = @{}
foreach ($line in $VM_LIST) {
    $parts = $line -split '\s+'
    $vmName = $parts[0]
    $vmState = $parts[1]

    # Extraire le numéro étudiant
    if ($vmName -match 'vm(\d+)') {
        $StudentID_VM = $matches[1]
        $VM_STATUS[$StudentID_VM] = $vmState
    }
}

# -------------------------------
# Boucle sur les étudiants du groupe actif
# -------------------------------
for ($g = 0; $g -lt $ACTIVE_GROUP.Count; $g++) {
    $parts = $ACTIVE_GROUP[$g] -split '\|'
    $StudentID = $parts[0]
    $GitHubID  = $parts[1]
    $AvatarID  = $parts[2]
    $ServerID  = $ACTIVE_SERVERS[$g]

    $URL = "[<image src='https://avatars0.githubusercontent.com/u/{1}?s=460&v=4' width=20 height=20></image>](https://github.com/{0})" -f $GitHubID, $AvatarID
    $FILE = "$StudentID/README.md"
    $FOLDER = "$StudentID/images"
    $TF_FILE = "$StudentID/scruter_nginx.sh"

    # Vérification VM
    $VM = ":x:"
    $SSH = ":x:"
    if ($VM_STATUS.ContainsKey($StudentID)) {
        if ($VM_STATUS[$StudentID] -eq "running") {
            $VM = ":green_circle: [${ServerID}](http://${ServerID})" 
            
            # ------------- SSH Test -------------
            $SSH_TEST = ssh `
                -o ConnectTimeout=5 `
                -o BatchMode=yes `
                -o StrictHostKeyChecking=no `
                -i ~/.ssh/${PK_PROF} `
                ubuntu@${ServerID} "ls scruter_nginx.sh nginx_ips.log nginx_ips.txt nginx_ips_freq.txt" 2>$null

            if ($LASTEXITCODE -eq 0) {
                $SSH = ":link:"
                $ssh_ok_count++
            }
        }
        else {
            $VM  = ":orange_circle:"
        }

    }

    # Vérification fichiers
    $README_OK = if (Test-Path $FILE) { ":heavy_check_mark:" } else { ":x:" }
    $IMAGES_OK = if (Test-Path $FOLDER -PathType Container) { ":heavy_check_mark:" } else { ":x:" }
    $TF_OK     = if (Test-Path $TF_FILE) { ":heavy_check_mark:" } else { ":x:" }

    # Compter le score global si README + images sont ok
    if ($README_OK -eq ":heavy_check_mark:" -and $IMAGES_OK -eq ":heavy_check_mark:") { $s++ }

    # Affichage de la ligne
    Write-Output "| $i | [$StudentID](../$FILE) :point_right: $URL | $README_OK | $IMAGES_OK | $TF_OK | $VM | $SSH |"

    $i++
}

# -------------------------------
# Statistiques finales
# -------------------------------
$COUNT = "\$\\frac{$s}{$i}\$"
$STATS = if ($i -gt 0) { [math]::Round(($s * 100.0 / $i), 2) } else { 0 }
$SUM = "\$\displaystyle\sum_{i=1}^{$i} s_i\$"

Write-Output "| :abacus: | $COUNT = $STATS% | $SUM = $s |"

