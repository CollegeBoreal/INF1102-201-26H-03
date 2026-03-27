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
Write-Output "|:hash:| Boréal :id:                | README.md | images | analyse_nginx.ps1 | analyse_nginx.py | :link: IP  |"
Write-Output "|------|----------------------------|-----------|--------|---------|----|-----|"

# -------------------------------
# Initialisation
# -------------------------------
$i = 0
$s = 0

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
    $TF_FILE = "$StudentID/analyse_nginx.ps1"
    $PY_FILE = "$StudentID/analyse_nginx.py"

    # Vérification fichiers
    # --- README.md status ---
    if (-not (Test-Path $FILE)) {
        $README_STATUS = ":x:"
    }
    else {
        $Content = Get-Content $FILE -Raw
        $HasText = ($Content -match '\S')
        $HasImageInReadme = ($Content -match '!\[.*\]\(.*\)') -or ($Content -match '<img.*?>') -or ($Content -match '<image.*?>')
        
        if ($HasText -and $HasImageInReadme) {
            $README_STATUS = ":1st_place_medal:"
        }
        else {
            $README_STATUS = ":2nd_place_medal:"
        }
        $s++
    }

    # --- Images folder status ---
    if (Test-Path $FOLDER -PathType Container) {
        $IMAGES_STATUS = ":heavy_check_mark:"
    }
    else {
        $IMAGES_STATUS = ":x:"
    }

    # --- main.tf status ---
    if (Test-Path $TF_FILE -PathType Leaf) {
        $TF_STATUS = ":heavy_check_mark:"
    }
    else {
        $TF_STATUS = ":x:"
    }


    # --- main.tf status ---
    if (Test-Path $PY_FILE -PathType Leaf) {
        $PY_STATUS = ":heavy_check_mark:"
    }
    else {
        $PY_STATUS = ":x:"
    }

    # Affichage de la ligne
    Write-Output "| $i | [$StudentID](../$FILE) :point_right: $URL | $README_STATUS | $IMAGES_STATUS | $TF_STATUS | $PY_STATUS | ${ServerID} |"

    $i++
}

# -------------------------------
# Statistiques finales
# -------------------------------
$COUNT = "\$\\frac{$s}{$i}\$"
$STATS = if ($i -gt 0) { [math]::Round(($SSH_OK_COUNT * 100.0 / $i), 2) } else { 0 }
$SUM = "\$\displaystyle\sum_{i=1}^{$i} s_i\$"

Write-Output "| :abacus: | $COUNT = $STATS% | $SUM = $SSH_OK_COUNT |"

