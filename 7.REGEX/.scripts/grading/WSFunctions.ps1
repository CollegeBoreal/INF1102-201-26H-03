# =====================================================================
# CONFIGURATION
# =====================================================================
# Static IDs and flags used throughout participation grading
# =====================================================================

# LMS assignment ID where participation grades will be submitted
$LMSAssignmentID = 22

# Enables verbose/debug output when set to $true
$DEBUG = $false

# Explicit emoji → rubric level mapping for DB execution criterion
# (Used when the emoji represents more than pass/fail)
$EmojiToScore = @{
    ":boom:" = 247
    ":link:" = 248
}

# =====================================================================
# PARTICIPATION EXTRACTION FROM README.md
# =====================================================================

function Get-ParticipationGrades {
    <#
        Parses a Markdown table from a README.md file and converts
        emoji-based participation indicators into LMS rubric level IDs.

        Each valid row produces one grading entry keyed by Boréal ID.
    #>
    param (
        [Parameter(Mandatory)]
        [string]$Path
    )

    # Read README.md line-by-line
    $lines = Get-Content $Path
    $results = @()

    foreach ($line in $lines) {

        # Only process Markdown table rows starting with:
        # | <number> |
        if ($line -match '^\|\s*\d+\s*\|') {

            # Split on column separators
            $cols = $line -split '\|'

            # Column index reference (0 is empty due to leading pipe):
            # 1 = Row index
            # 2 = Boréal ID link
            # 5 = abacus emoji

            if ($DEBUG) { Write-Output $cols. }

            # Extract Boréal ID (expected format: [300000000])
            if ($cols[2] -match '\[(\d{9})\]') {
                $borealId = $matches[1]
            } else {
                # Skip malformed rows
                continue
            }

            # ---------------------------------
            # README.md quantity (fail/silver/gold)
            # ---------------------------------
            $readEmoji = ($cols[3]).Trim()
            $levels = @(240, 241, 242)  # fail, silver, gold
            $readScore = Get-RubricLevelIdFromReadmeEmoji `
                -Emoji $readEmoji `
                -Levels $levels

            # ---------------------------------
            # Images folder presence (pass/fail)
            # ---------------------------------
            $imgEmoji = ($cols[4]).Trim()
            $imgScore = Get-RubricLevelIdFromEmoji `
                -Emoji $imgEmoji `
                -FailLevelId 245 `
                -PassLevelId 246

            # If README.md exceeds expectations,
            # images folder is implicitly considered present
            if ($readScore -gt 242) {
                $imgScore = 246
            }

            # ---------------------------------
            # analyse_nginx.ps1 presence
            # ---------------------------------
            $mainEmoji = ($cols[5]).Trim()
            $mainScore = Get-RubricLevelIdFromEmoji `
                -Emoji $mainEmoji `
                -FailLevelId 245 `
                -PassLevelId 246

            # ---------------------------------
            # analyse_nginx.py presence
            # ---------------------------------
            $secondEmoji = ($cols[6]).Trim()
            $secondScore = Get-RubricLevelIdFromEmoji `
                -Emoji $secondEmoji `
                -FailLevelId 249 `
                -PassLevelId 250

            # ---------------------------------
            # Execute SSH Link
            # matches :link:
            # if :x: or :boom: revert to null‑coalescing operator (??) default value
            # ---------------------------------
            $linkEmoji = ($cols[8]).Trim()
            $linkScore = $EmojiToScore[$linkEmoji] ?? $EmojiToScore[':boom:']

            # Debug trace for validation / troubleshooting
            if ($DEBUG) {
                Write-Output $borealId
                    , $readEmoji, $readScore
                    , $imgEmoji, $imgScore
                    , $mainEmoji, $mainScore
                    , $secondEmoji, $secondScore
                    , $linkScore, $linkEmoji
            }

            # Accumulate normalized grading entry
            $results += [PSCustomObject]@{
                borealId  = $borealId
                readme    = $readScore
                image     = $imgScore
                main      = $mainScore
                second    = $secondScore
                link      = $linkScore
            }
        }
    }

    return $results
}

# =====================================================================
# RUBRIC OBJECT BUILDER
# =====================================================================

function New-LMSRubricFromEntry {
    <#
        Converts a normalized participation entry into
        an LMS-compatible rubric payload.

        Designed to prevent invalid submissions that
        could crash Moodle grading APIs.
    #>
    param (
        [Parameter(Mandatory)]
        [object]$Entry
    )

    # Required grading components
    $requiredFields = @(
         "readme"
        , "image"
        , "main"
        , "second"
        , "link"
    )

    # Validate entry completeness
    foreach ($field in $requiredFields) {
        if (-not $Entry.PSObject.Properties.Name -contains $field) {
            throw "Missing field '$field' in entry"
        }
    }

    # Construct rubric payload in LMS criterion order
    $rubric = @(
        @{ criterionid = 104;  levelid = $Entry.readme;    remark = "Quantité README.md " }
        @{ criterionid = 105;  levelid = $Entry.image;     remark = "Présence répertoire images " }
        @{ criterionid = 106;  levelid = $Entry.main;      remark = "Présence code source" }
        @{ criterionid = 108;  levelid = $Entry.second;    remark = "Présence code source" }
        @{ criterionid = 107;  levelid = $Entry.link;      remark = "Présence du devoir sur la VM" }
    )

    # Safety check: ensure all level IDs exist
    # (Null level IDs can cause Moodle submission failures)
    foreach ($r in $rubric) {
        if (-not $r.levelid) {
            throw "Invalid levelid for criterion $($r.criterionid)"
        }
    }

    return $rubric
}
