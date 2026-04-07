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
Write-PresenceHeader

$i = 0
$s = 0

for ($g = 0; $g -lt $ACTIVE_GROUP.Count; $g++) {
    $parts = $ACTIVE_GROUP[$g] -split '\|'
    $StudentID = $parts[0]
    $GitHubID  = $parts[1]
    $AvatarID  = $parts[2]

    $paths  = Get-StudentPaths -StudentID $StudentID
    $checks = Get-StudentChecks -Paths $paths
    $url    = Get-GitHubAvatarLink -GitHubID $GitHubID -AvatarID $AvatarID

    if ($Check) {
        $result = Get-StudentReport -id $StudentID
    }

    Write-StudentRow `
        -Index $i `
        -StudentID $StudentID `
        -GitHubLink $url `
        -Checks $checks `
        -Result $result `
        -INPath $paths.IN `
        -OUTPath $paths.OUT `
        -ReadmePath $paths.README

    if (Test-AllRequiredFilesPresent -Checks $checks) {
        $s++
    }

    $i++
}

Write-Summary -SuccessCount $s -TotalCount $i

