# =============================================================
#  NEWS ANALYSER -- analyse.ps1
#  Script PowerShell de lancement
# =============================================================
#  Role :
#    1. Verifier que Python est installe
#    2. Creer les dossiers /data et /output si necessaire
#    3. Installer les dependances Python manquantes
#    4. Lancer le script Python avec les bons parametres
#    5. Gerer et afficher les erreurs clairement
#
#  Usage :
#    .\analyse.ps1                    --> BBC (defaut)
#    .\analyse.ps1 -Site cnn          --> CNN
#    .\analyse.ps1 -Site bbc -TopN 15 --> BBC, top 15 mots
# =============================================================

param (
    [ValidateSet("cnn", "bbc")]
    [string]$Site = "bbc",
    [int]$TopN = 10
)

$ErrorActionPreference = "Stop"

# =============================================================
#  FONCTIONS UTILITAIRES
# =============================================================

function Write-Banner {
    param([string]$Text)
    $line = "=" * 60
    Write-Host ""
    Write-Host $line     -ForegroundColor Cyan
    Write-Host "  $Text" -ForegroundColor White
    Write-Host $line     -ForegroundColor Cyan
    Write-Host ""
}

function Write-Step {
    param([int]$Num, [string]$Message)
    Write-Host "  [$Num] $Message" -ForegroundColor Yellow
}

function Write-OK {
    param([string]$Message)
    Write-Host "  [OK] $Message" -ForegroundColor Green
}

function Write-Fail {
    param([string]$Message)
    Write-Host "  [ERREUR] $Message" -ForegroundColor Red
}

function Write-Info {
    param([string]$Message)
    Write-Host "  [INFO] $Message" -ForegroundColor Gray
}


# =============================================================
#  ETAPE 1 -- VERIFICATION DE PYTHON
# =============================================================

function Test-PythonInstalled {
    Write-Step 1 "Verification de l'installation Python..."

    $pythonCmd = $null

    try {
        $version = & python --version 2>&1
        if ($version -match "Python 3") { $pythonCmd = "python" }
    } catch { }

    if (-not $pythonCmd) {
        try {
            $version = & python3 --version 2>&1
            if ($version -match "Python 3") { $pythonCmd = "python3" }
        } catch { }
    }

    if (-not $pythonCmd) {
        Write-Fail "Python 3 n'est pas installe ou pas dans le PATH."
        Write-Host ""
        Write-Host "  --> Telechargez Python : https://www.python.org/downloads/" -ForegroundColor White
        Write-Host "  --> Cochez 'Add Python to PATH' lors de l'installation."    -ForegroundColor White
        Write-Host ""
        exit 1
    }

    $fullVersion = & $pythonCmd --version 2>&1
    Write-OK "$fullVersion detecte (commande : $pythonCmd)"
    return $pythonCmd
}


# =============================================================
#  ETAPE 2 -- CREATION DES DOSSIERS
# =============================================================

function Initialize-Folders {
    Write-Step 2 "Initialisation des dossiers..."

    $root = Split-Path -Parent $PSScriptRoot

    $folders = @(
        (Join-Path $root "data"),
        (Join-Path $root "output")
    )

    foreach ($folder in $folders) {
        if (-not (Test-Path $folder)) {
            New-Item -ItemType Directory -Path $folder -Force | Out-Null
            Write-OK "Dossier cree : $folder"
        } else {
            Write-Info "Dossier deja existant : $folder"
        }
    }
}


# =============================================================
#  ETAPE 3 -- INSTALLATION DES DEPENDANCES
# =============================================================

function Install-Dependencies {
    param([string]$PythonCmd)

    Write-Step 3 "Verification des dependances Python..."

    $required = @("requests", "bs4", "matplotlib", "pandas")
    $optional = @("wordcloud")
    $toInstall = @()

    foreach ($pkg in $required) {
        & $PythonCmd -c "import $pkg" 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) {
            $toInstall += $pkg
        }
    }

    if ($toInstall.Count -gt 0) {
        Write-Info "Installation des paquets manquants : $($toInstall -join ', ')"
        try {
            & $PythonCmd -m pip install @toInstall --quiet
            Write-OK "Dependances installees avec succes."
        } catch {
            Write-Fail "Echec de l'installation pip : $_"
            exit 1
        }
    } else {
        Write-OK "Toutes les dependances sont presentes."
    }

    foreach ($pkg in $optional) {
        & $PythonCmd -c "import $pkg" 2>&1 | Out-Null
        if ($LASTEXITCODE -ne 0) {
            Write-Info "Paquet optionnel absent : $pkg  (pip install $pkg)"
        }
    }
}


# =============================================================
#  ETAPE 4 -- LANCEMENT DU SCRIPT PYTHON
# =============================================================

function Invoke-Analyser {
    param([string]$PythonCmd, [string]$Site)

    Write-Step 4 "Lancement de l'analyse Python (site : $Site)..."
    Write-Host ""

    $scriptPath = Join-Path $PSScriptRoot "analyse.py"

    if (-not (Test-Path $scriptPath)) {
        Write-Fail "Script Python introuvable : $scriptPath"
        exit 1
    }

    & $PythonCmd $scriptPath --site $Site

    if ($LASTEXITCODE -ne 0) {
        Write-Host ""
        Write-Fail "Le script Python s'est termine avec une erreur (code $LASTEXITCODE)."
        Write-Host "  Consultez les messages ci-dessus pour plus de details." -ForegroundColor Gray
        exit $LASTEXITCODE
    }
}


# =============================================================
#  PROGRAMME PRINCIPAL
# =============================================================

Write-Banner "NEWS ANALYSER -- Demarrage"
Write-Host "  Site cible : $($Site.ToUpper())" -ForegroundColor White
Write-Host "  Date       : $(Get-Date -Format 'dd/MM/yyyy HH:mm')" -ForegroundColor White
Write-Host ""

try {
    $pythonCmd = Test-PythonInstalled
    Initialize-Folders
    Install-Dependencies -PythonCmd $pythonCmd
    Invoke-Analyser -PythonCmd $pythonCmd -Site $Site

    Write-Host ""
    Write-Banner "ANALYSE TERMINEE AVEC SUCCES"

    $root = Split-Path -Parent $PSScriptRoot
    Write-Host "  Fichiers generes :" -ForegroundColor White
    Write-Host "    * $(Join-Path $root 'data\news_data.json')"  -ForegroundColor Cyan
    Write-Host "    * $(Join-Path $root 'output\histogram.png')" -ForegroundColor Cyan
    Write-Host "    * $(Join-Path $root 'output\rapport.txt')"   -ForegroundColor Cyan
    Write-Host ""

} catch {
    Write-Host ""
    Write-Fail "Erreur inattendue : $_"
    Write-Host "  Trace : $($_.ScriptStackTrace)" -ForegroundColor DarkGray
    Write-Host ""
    exit 1
}
