#!/usr/bin/env pwsh

# ================================================
# certaines erreurs :
# ne déclencheront pas le catch,
# seront seulement affichées,
# et le script pourrait continuer comme si de rien n’était.
# ================================================

function Get-StudentReport {
    param (
        [string]$id
    )

    $py = "$id/IO.py"
    $nb = "$id/RAPPORT.ipynb"

    # --- IO.py execution ---
    $execPyIcon = ":grey_question:"
    if (Test-Path $py) {
        Push-Location $id
        try {
            python3 "IO.py" *> $null
            if ($LASTEXITCODE -eq 0) {
                $execPyIcon = ":rocket:"
            }
            else {
                $execPyIcon = ":bangbang:"
            }
        } catch {
            $execPyIcon = ":boom:"
        }
        finally {
            Pop-Location
        }
    }

    # --- Notebook analysis ---
    $rapportIcon = ":x:"
    $errorIcon = ":x:"
    $signIcon = ":x:"
    $figuresCount = 0

    if (Test-Path $nb) {
        $rapportIcon = ":receipt:"

        $json = Get-Content $nb -Raw | ConvertFrom-Json

        # Count errors
        $errors = @(
            $json.cells |
            ForEach-Object { $_.outputs } |
            Where-Object { $_.output_type -eq "error" }
        )
        $errorCount = $errors.Count

        if ($errorCount -eq 0) {
            $errorIcon = ""

            # Count figures (text/plain containing "Figure")
            $figures = @(
                $json.cells |
                ForEach-Object { $_.outputs } |
                Where-Object {
                    $_.output_type -eq "display_data" -and
                    $_.data."text/plain" -match "Figure"
                }
            )
            $figuresCount = $figures.Count
        }
        else {
            $errorIcon = ":boom:"
        }

        # Check signature (ID in markdown)
        $signatures = @(
            $json.cells |
            Where-Object { $_.cell_type -eq "markdown" } |
            ForEach-Object { $_.source } |
            Where-Object { $_ -match $id }
        )

        if ($signatures.Count -gt 0) {
            $signIcon = ":writing_hand:"
        }
    }

    # --- Return structured result ---
    return [PSCustomObject]@{
        Id            = $id
        IO_Exec       = $execPyIcon
        Rapport       = $rapportIcon
        Errors        = $errorIcon
        FiguresCount  = $figuresCount
        Signature     = $signIcon
    }
}
