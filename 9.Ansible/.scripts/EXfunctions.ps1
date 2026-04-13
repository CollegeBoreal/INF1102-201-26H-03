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

    $pb = "$id/playbook.yml"
    $ini = "$id/inventory.ini"

    # --- IO.py execution ---
    $execPyIcon = ":grey_question:"
    if (Test-Path $pb) {
        try {
            ansible-playbook -i $ini $pb -u ubuntu -e ansible_ssh_private_key_file=~/.ssh/b300098957@ramena *> $null
            if ($LASTEXITCODE -eq 0) {
                $execPyIcon = ":link:"
            }
            else {
                $execPyIcon = ":bangbang:"
            }
        } catch {
            $execPyIcon = ":boom:"
        }
    }

    # --- Return structured result ---
    return [PSCustomObject]@{
        Id            = $id
        IO_Exec       = $execPyIcon
    }
}
