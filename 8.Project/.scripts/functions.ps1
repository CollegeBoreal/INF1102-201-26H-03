#!/usr/bin/env pwsh

function Num-ToEmoji {
    param (
        [int]$n
    )

    switch ($n) {
        0 { ":zero:" }
        1 { ":one:" }
        2 { ":two:" }
        3 { ":three:" }
        4 { ":four:" }
        5 { ":five:" }
        6 { ":six:" }
        7 { ":seven:" }
        8 { ":eight:" }
        9 { ":nine:" }
        default { ":keycap_ten:" }
    }
}

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
        PY       = "$StudentID/scripts/analyse.py"
        NB       = "$StudentID/RAPPORT.ipynb"
        IN       = "$StudentID/scripts/analyse.ps1"
        OUT      = "$StudentID/output/rapport.txt"
    }
}

function Get-StudentChecks {
    param(
        [hashtable]$Paths
    )

    return @{
        README = Test-CommonItemExists -Path $Paths.README -IsReadme
        Images = Test-CommonItemExists -Path $Paths.Images
        PY     = Test-ItemExists -Path $Paths.PY
        NB     = Test-ItemExists -Path $Paths.NB
        IN     = Test-ItemExists -Path $Paths.IN
        OUT    = Test-ItemExists -Path $Paths.OUT
    }
}

function Test-AllRequiredFilesPresent {
    param(
        [hashtable]$Checks
    )

    return (
        $Checks.README -eq ":1st_place_medal:" -or ":2nd_place_medal:" -and
        $Checks.Images -eq ":heavy_check_mark:" -and
        $Checks.PY     -eq ":heavy_check_mark:" -and
        $Checks.NB     -eq ":heavy_check_mark:" -and
        $Checks.IN     -eq ":heavy_check_mark:" -and
        $Checks.OUT    -eq ":heavy_check_mark:"
    )
}

function Write-PresenceHeader {
    Write-Output ""
    Write-Output "## :a: Présence"
    Write-Output ""

    Write-Output "|:hash:| Boréal :id: | README.md | images | :rocket: analyse.py | :receipt: RAPPORT | :writing_hand: Sgn | :framed_picture: Figures | analyse.ps1 | rapport.txt | :boom: Erreurs |"
    Write-Output "|------|-------------|-----------|--------|---------------------|-------------------|--------------------|--------------------------|-------------|-------------|----------------|"
}


function Write-StudentRow {
    param(
        [int]$Index,
        [string]$StudentID,
        [string]$GitHubLink,
        [hashtable]$Checks,
        [PSCustomObject]$Result,
        [string]$INPath,
        [string]$OUTPath,
        [string]$ReadmePath
    )

    Write-Output "| $Index | [$StudentID](../$ReadmePath) :point_right: $GitHubLink | $($Checks.README) | $($Checks.Images) | $($Result.IO_Exec) | [$($Result.Rapport)](../$StudentID/RAPPORT.ipynb) | $($Result.Signature) | $(Num-ToEmoji $($Result.FiguresCount)) | [$($Checks.IN)](../$INPath) | [$($Checks.OUT)](../$OUTPath) | $($Result.Errors) |"
}

