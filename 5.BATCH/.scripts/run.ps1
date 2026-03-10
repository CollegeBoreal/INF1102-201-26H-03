#!/usr/bin/env pwsh
# --------------------------------------
# PowerShell equivalent of:
# bash .scripts/participation.sh > .scripts/Participation.md 2>/dev/null
# --------------------------------------

# Run the participation script and redirect its output
# Standard output -> .scripts/Participation.md
# Errors -> $null (discarded)

pwsh .scripts/participation.ps1 -Group 1 > .scripts/Participation-group1.md 2>$null
pwsh .scripts/participation.ps1 -Group 2 > .scripts/Participation-group2.md 2>$null
pwsh .scripts/participation.ps1 -Group 3 > .scripts/Participation-group3.md 2>$null


