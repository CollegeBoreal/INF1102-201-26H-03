#!/usr/bin/env pwsh
# --------------------------------------
# PowerShell participation script using $STUDENTS array and group selection
# Supports 3 groups
# --------------------------------------

param(
    [ValidateSet(1,2,3)]
    [int]$Group = 1,
    [switch]$Check
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

$ErrorActionPreference = "Stop"

# Importer les fonctions
. .scripts/functions.ps1
. .scripts/EXfunctions.ps1

# Importer la liste des étudiants
. ../.scripts/commons.ps1

Write-ParticipationHeader
if ($Check) {
    Write-PresenceHeader -Check
} else {
    Write-PresenceHeader
}

# -------------------------------
# Initialisation
# -------------------------------
$i = 0
$s = 0

if ($Check) {
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
}

for ($g = 0; $g -lt $ACTIVE_GROUP.Count; $g++) {
    $parts = $ACTIVE_GROUP[$g] -split '\|'
    $StudentID = $parts[0]
    $GitHubID  = $parts[1]
    $AvatarID  = $parts[2]
    $ServerID  = $ACTIVE_SERVERS[$g]

    $paths  = Get-StudentPaths -StudentID $StudentID
    $checks = Get-StudentChecks -Paths $paths
    $url    = Get-GitHubAvatarLink -GitHubID $GitHubID -AvatarID $AvatarID


    $params = @{
        Index       = $i
        StudentID   = $StudentID
        GitHubLink  = $url
        Checks      = $checks
        Result      = $result
        PBPath      = $paths.PB
        INIPath     = $paths.INI
        ReadmePath  = $paths.README
    }


    $result = [PSCustomObject]@{
        Id            = $StudentID
        IO_Exec       = ":grey_question:"
    }
    if ($Check) {
        $result = Get-StudentReport -id $StudentID
        $params.Check = $true
        # Vérification VM
        $params.VM = ":red_circle: ${ServerID}"
        if ($VM_STATUS.ContainsKey($StudentID)) {
            if ($VM_STATUS[$StudentID] -eq "running") {
                $params.VM = ":green_circle: [${ServerID}](http://${ServerID})" 
            }
        }

    }

    Write-StudentRow @params

    if (Test-AllRequiredFilesPresent -Checks $checks) {
        $s++
    }

    $i++
}

Write-Summary -SuccessCount $s -TotalCount $i

