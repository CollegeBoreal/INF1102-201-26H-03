#!/usr/bin/env pwsh

function Test-ItemExists {
    param(
        [string]$Path
    )

    if (Test-Path $Path) {
        return ":heavy_check_mark:"
    }

    return ":x:"
}

function Get-StudentPaths {
    param(
        [string]$StudentID
    )

    return @{
        README   = "$StudentID/README.md"
        Images   = "$StudentID/images"
        PB       = "$StudentID/playbook.yml"
        INI      = "$StudentID/inventory.ini"
    }
}

function Get-StudentChecks {
    param(
        [hashtable]$Paths
    )

    return @{
        README = Test-CommonItemExists -Path $Paths.README -IsReadme
        Images = Test-CommonItemExists -Path $Paths.Images
        PB     = Test-ItemExists -Path $Paths.PB
        INI    = Test-ItemExists -Path $Paths.INI
    }
}

function Test-AllRequiredFilesPresent {
    param(
        [hashtable]$Checks,
        [PSCustomObject]$Result
    )

    return (
        $Checks.README      -eq ":1st_place_medal:" -or ":2nd_place_medal:" -and
        $Checks.Images      -eq ":heavy_check_mark:" -and
        $Checks.PB          -eq ":heavy_check_mark:" -and
        $Checks.INI         -eq ":heavy_check_mark:"
    )
}

function Write-PresenceHeader {
    param(
        [switch]$Check
    )

    Write-Output ""
    Write-Output "## :a: Présence"
    Write-Output ""

    if ($Check) {
        # Présence table
        Write-Output "|:hash:| Boréal :id:                | README.md | images | :rocket: playbook.yml | :page_facing_up: inventory.ini | VM | <image src='https://avatars0.githubusercontent.com/u/62551735?s=460&v=4' width=20 height=20></image> SSH |"
        Write-Output "|------|----------------------------|-----------|--------|-----------------------|-------------------------------|----|----------------------------------------------------------------------------------------------------------|"
    } else {
        Write-Output "|:hash:| Boréal :id: | README.md | images | :rocket: playbook.yml | :page_facing_up: inventory.ini |"
        Write-Output "|------|-------------|-----------|--------|-----------------------|-------------------------------|"
    }

}


function Write-StudentRow {
    param(
        [switch]$Check,
        [string]$VM, 
        [int]$Index,
        [string]$StudentID,
        [string]$GitHubLink,
        [hashtable]$Checks,
        [PSCustomObject]$Result,
        [string]$PBPath,
        [string]$INIPath,
        [string]$ReadmePath
    )

    if ($Check) {
        Write-Output "| $Index | [$StudentID](../$ReadmePath) :point_right: $GitHubLink | $($Checks.README) | $($Checks.Images) | [$($Checks.PB)](../$PBPath) | [$($Checks.INI)](../$INIPath) | $($VM) | $($Result.IO_Exec) |"
    } else {
        Write-Output "| $Index | [$StudentID](../$ReadmePath) :point_right: $GitHubLink | $($Checks.README) | $($Checks.Images) | [$($Checks.PB)](../$PBPath) | [$($Checks.INI)](../$INIPath) |"
    }

}

