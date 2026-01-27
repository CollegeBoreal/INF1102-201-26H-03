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
    default { throw "active server Groupe invalide" }
}

switch ($Group) {
    1 { $PROXMOX_SERVER = $PROXMOX_GROUP_1 }
    2 { $PROXMOX_SERVER = $PROXMOX_GROUP_2 }
    3 { $PROXMOX_SERVER = $PROXMOX_GROUP_3 }
    default { throw "Proxmox server Groupe invalide" }
}

switch ($Group) {
    1 { $TOFU_SECRET = $TOFU_SECRET_GROUP_1 }
    2 { $TOFU_SECRET = $TOFU_SECRET_GROUP_2 }
    3 { $TOFU_SECRET = $TOFU_SECRET_GROUP_3 }
    default { throw "Tofu Secret Groupe invalide" }
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
Write-Output "## :gear: Configuration"
Write-Output ""
Write-Output "| Proxmox Serveur                                     | User/Pwd         |"
Write-Output "|-----------------------------------------------------|------------------|"
Write-Output "| [${PROXMOX_SERVER}](https://${PROXMOX_SERVER}:8006) | root/Boreal@2️⃣02️⃣6 |"
Write-Output ""
Write-Output ""
Write-Output "| TOFU Credentials                                    | :closed_lock_with_key: Secret |"
Write-Output "|-----------------------------------------------------|------------------|"
Write-Output "| tofu@pve!opentofu                                   | ${TOFU_SECRET}   |"
Write-Output ""
Write-Output "| Cle du prof                     | :closed_lock_with_key: Secret |"
Write-Output "|---------------------------------|------------------|"
Write-Output "| ~/.ssh/cle_publique_du_prof.pub | ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD2pLhMqFGKffSdYvNCMAyM7598oBY+m/3q5AMXmb7IE6vq42+yGzqEUzZu9WrFckFD4Hq52rIU5DeOvi83DCF3uroXjNTEtCKdi+tY7cV18bHmsDsBHMqTnpuvroofgFWA0Pi++b2kGW2I5eyy1Qjv5rOp7y11Xe6XeZFEz7qQO1/xNiBMJEruG9Xldgooe4hkaOF39qnbqD4ui3LxYaTUTEulstw4wN70dSB8Zu9YQP7A7KU2zIEwJ1aw8whfO1CAM/AVvoDyqMtV8VXoaZSHOBgluMtinQfyyt473S2ZZeJlnmhK0F1gdOhO4SVZNRMj96m30ryYkYBFWvvLRP5N b300098957@ramena |"
Write-Output ""
Write-Output ""
Write-Output "## :a: Présence"
Write-Output ""
Write-Output "|:hash:| Boréal :id:                | README.md    | images | :link: IP |"
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

