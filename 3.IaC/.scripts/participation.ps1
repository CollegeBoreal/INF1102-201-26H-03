#!/usr/bin/env pwsh
# --------------------------------------
# PowerShell participation script using $STUDENTS array
# --------------------------------------

param(
    [ValidateSet(1,2,3)]
    [int]$Group = 1
)

# Import variables from another script (students.ps1)
. ../.scripts/students.ps1

switch ($Group) {
    1 { $ACTIVE_GROUP = $GROUP_1 }
    2 { $ACTIVE_GROUP = $GROUP_2 }
    3 { $ACTIVE_GROUP = $GROUP_3 }
    default { throw "Groupe invalide" }
}

switch ($Group) {
    1 { $ACTIVE_SERVERS = $SERVER_GROUP_1 }
    2 { $ACTIVE_SERVERS = $SERVER_GROUP_2 }
    3 { $ACTIVE_SERVERS = $SERVER_GROUP_3 }
    default { throw "Groupe invalide" }
}

switch ($Group) {
    1 { $PROXMOX_SERVER = $PROXMOX_GROUP_1 }
    2 { $PROXMOX_SERVER = $PROXMOX_GROUP_2 }
    3 { $PROXMOX_SERVER = $PROXMOX_GROUP_3 }
    default { throw "Groupe invalide" }
}


# Header
Write-Output "# Participation – Groupe $Group"
Write-Output ""

Write-Output "| Table des matières            | Description                                             |"
Write-Output "|-------------------------------|---------------------------------------------------------|"
Write-Output "| :a: [Présence](#a-présence)   | L'étudiant.e a fait son travail    :heavy_check_mark:   |"
Write-Output "| :b: [Précision](#b-précision) | L'étudiant.e a réussi son travail  :tada:               |"

Write-Output ""
Write-Output "## Légende"
Write-Output ""
Write-Output "| Signe              | Signification                 |"
Write-Output "|--------------------|-------------------------------|"
Write-Output "| :heavy_check_mark: | Prêt à être corrigé           |"
Write-Output "| :x:                | Projet inexistant             |"
Write-Output ""
Write-Output "## Configuration"
Write-Output ""
Write-Output "| Signe              | Proxmox Serveur:              | User/Pwd |"
Write-Output "|--------------------|-------------------------------|----------|"
Write-Output "| :heavy_check_mark: | [${PROXMOX_SERVER}](https://${PROXMOX_SERVER}:8006) | root/Boreal@2️⃣02️⃣6 |"
Write-Output ""
Write-Output ""
Write-Output "## :a: Présence"
Write-Output ""
Write-Output "|:hash:| Boréal :id:                | README.md    | images | :links: IP |"
Write-Output "|------|----------------------------|--------------|--------|------------|"

# Initialize counters
$i = 0
$s = 0

# Loop through the textual $STUDENTS array
for ($g = 0; $g -lt $ACTIVE_GROUP.Count; $g++) {
    $parts = $ACTIVE_GROUP[$g] -split '\|'
    $StudentID = $parts[0]
    $GitHubID  = $parts[1]
    $AvatarID  = $parts[2]
    $ServerID  = $ACTIVE_SERVERS[$g]

    $URL = "[{0}](https://github.com/{0}) <image src='https://avatars0.githubusercontent.com/u/{1}?s=460&v=4' width=20 height=20></image>" -f $GitHubID, $AvatarID
    $FILE = "$StudentID/README.md"
    $FOLDER = "$StudentID/images"

    $OK = "| $i | [$StudentID](../$FILE) :point_right: $URL | :heavy_check_mark: | :x: | ${ServerID} |"
    $FULL_OK = "| $i | [$StudentID](../$FILE) :point_right: $URL | :heavy_check_mark: | :heavy_check_mark: | ${ServerID} |"
    $KO = "| $i | [$StudentID](../$FILE) :point_right: $URL | :x: | :x: | ${ServerID} |"

    if (Test-Path $FILE) {
        $ACTUAL_NAME = Split-Path -Leaf (Resolve-Path $FILE)
        if ($ACTUAL_NAME -eq "README.md") {
            if (Test-Path $FOLDER -PathType Container) {
                Write-Output $FULL_OK
                $s++
            }
            else {
                Write-Output $OK
            }
        }
        else {
            Write-Output $KO
        }
    }
    else {
        Write-Output $KO
    }

    $i++
    $COUNT = "\$\\frac{$s}{$i}\$"
    if ($i -gt 0) {
        $STATS = [math]::Round(($s * 100.0 / $i), 2)
    }
    else {
        $STATS = 0
    }
    $SUM = "\$\displaystyle\sum_{i=1}^{$i} s_i\$"
}

Write-Output "| :abacus: | $COUNT = $STATS% | $SUM = $s |"

