#!/usr/bin/env pwsh

$dirs = @(
    "3.IaC",
    "4.CRON-TASK",
    "5.BATCH",
    "6.PWSH",
    "7.REGEX"
)

foreach ($dir in $dirs) {
    Push-Location $dir
    try {
        .scripts/run-check.ps1
    }
    finally {
        Pop-Location
    }
}
