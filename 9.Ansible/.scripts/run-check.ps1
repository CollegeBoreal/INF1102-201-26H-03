#!/usr/bin/env pwsh
# --------------------------------------
# PowerShell equivalent of:
# bash .scripts/participation.sh > .scripts/Participation.md 2>/dev/null
# --------------------------------------

# Run the participation script and redirect its output
# Standard output -> .scripts/Participation.md
# Errors -> $null (discarded)

pwsh .scripts/participation.ps1 -Group 1 -Check > .scripts/Check-group1.md 2>$null
pwsh .scripts/participation.ps1 -Group 2 -Check > .scripts/Check-group2.md 2>$null
pwsh .scripts/participation.ps1 -Group 3 -Check > .scripts/Check-group3.md 2>$null


