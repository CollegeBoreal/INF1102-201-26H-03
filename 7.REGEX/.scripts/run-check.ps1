#!/usr/bin/env pwsh
# --------------------------------------
# PowerShell equivalent of:
# bash .scripts/participation.sh > .scripts/Participation.md 2>/dev/null
# --------------------------------------

# Run the participation script and redirect its output
# Standard output -> .scripts/Participation.md
# Errors -> $null (discarded)

pwsh .scripts/check.ps1 -Group 1 > .scripts/Check-group1.md 2>$null
pwsh .scripts/check.ps1 -Group 2 > .scripts/Check-group2.md 2>$null
pwsh .scripts/check.ps1 -Group 3 > .scripts/Check-group3.md 2>$null


