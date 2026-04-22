# =========================
# CONFIG
# =========================
$LMSAssignmentID = 8
$DEBUG = $false

$EmojiToScore = @{
    ":x:" = 51
    ":2nd_place_medal:" = 52
    ":1st_place_medal:" = 53
    ":boom:" = 58
    ":link:" = 59
}

function Get-ParticipationGrades {
    param (
        [Parameter(Mandatory)]
        [string]$Path
    )

    $lines = Get-Content $Path
    $results = @()

    foreach ($line in $lines) {

        # Only data rows start with "| <number> |"
        if ($line -match '^\|\s*\d+\s*\|') {

            $cols = $line -split '\|'

            # Columns (0 is empty):
            # 1 = index
            # 2 = Boréal ID link column
            # 3-4 = others

            if ($DEBUG) { Write-Output $cols. }

            # if ($cols.Count -lt 6) { continue }

            if ($cols[2] -match '(\d{9})') {
                $borealId = $matches[1]
            } else {
                continue
            }

            # "levels": { "id": 51, "score": 0 },
            #           { "id": 52, "score": 1 },
            #           { "id": 53, "score": 2 } 
            $readEmoji = ($cols[3]).Trim()
            $readScore = $EmojiToScore[$readEmoji]

            # "levels": { "id": 54, "score": 0 },
            #           { "id": 55, "score": 1 },
            $imgEmoji = ($cols[4]).Trim()
            if ($imgEmoji -match ':x:') {
                $imgScore = 54
            } else {
                $imgScore = 55
            }

            # "levels": { "id": 56, "score": 0 },
            #           { "id": 57, "score": 1 },
            $mainEmoji = ($cols[5]).Trim()
            if ($mainEmoji -match ':x:') {
                $mainScore = 56
            } else {
                $mainScore = 57
            }

            # "levels": { "id": 58, "score": 0 },
            #           { "id": 59, "score": 1 },
            $linkEmoji = ($cols[7]).Trim()
            $linkScore = $EmojiToScore[$linkEmoji]

            if ($DEBUG) {
                Write-Output $borealId
                    , $readEmoji, $readScore
                    , $imgEmoji, $imgScore
                    , $mainEmoji, $mainScore
                    , $linkScore, $linkEmoji
            }

            $results += [PSCustomObject]@{
                borealId  = $borealId
                readme    = $readScore
                image     = $imgScore
                main      = $mainScore
                link      = $linkScore
            }
        }
    }

    return $results
}

function New-LMSRubricFromEntry {
    param (
        [Parameter(Mandatory)]
        [object]$Entry
    )

    # Validate required fields exist
    $requiredFields = @(
         "readme"
        , "image"
        , "main"
        , "link"
    )

    foreach ($field in $requiredFields) {
        if (-not $Entry.PSObject.Properties.Name -contains $field) {
            throw "Missing field '$field' in entry"
        }
    }

    # Build rubric
    $rubric = @(
        @{ criterionid = 22;  levelid = $Entry.readme;    remark = "Quantité README.md " }
        @{ criterionid = 23;  levelid = $Entry.image;     remark = "Présence répertoire images " }
        @{ criterionid = 24;  levelid = $Entry.main;      remark = "Présence code source" }
        @{ criterionid = 25;  levelid = $Entry.link;      remark = "Présence du la clé SSH Prof" }
    )

    # Validate level IDs (avoid Moodle crash)
    foreach ($r in $rubric) {
        if (-not $r.levelid) {
            throw "Invalid levelid for criterion $($r.criterionid)"
        }
    }

    return $rubric
}

function Send-LMSRubricGrade {
    param (
        [Parameter(Mandatory)]
        [string]$LMS_URL,

        [Parameter(Mandatory)]
        [string]$TOKEN,

        [Parameter(Mandatory)]
        [int]$AssignmentId,

        [Parameter(Mandatory)]
        [int]$UserId,

        [Parameter(Mandatory)]
        [array]$Rubric,

        [int]$AttemptNumber = 0,

        [string]$WorkflowState = "graded"
    )

    # -------------------------
    # BUILD BASE PAYLOAD
    # -------------------------
    $body = @{
        wstoken            = $TOKEN
        wsfunction         = "local_gradesaver_save_grade"
        moodlewsrestformat = "json"
        assignmentid       = $AssignmentId
        userid             = $UserId
        attemptnumber      = $AttemptNumber
        workflowstate      = $WorkflowState
    }

    # -------------------------
    # ADD RUBRIC DYNAMICALLY
    # -------------------------
    for ($i = 0; $i -lt $Rubric.Count; $i++) {
        $entry = $Rubric[$i]

        if (-not $entry.criterionid -or -not $entry.levelid) {
            throw "Invalid rubric entry at index $i"
        }

        $body["rubric[criteria][$i][criterionid]"] = $entry.criterionid
        $body["rubric[criteria][$i][levelid]"]     = $entry.levelid
        $body["rubric[criteria][$i][remark]"]      = $entry.remark
    }

    if ($DEBUG) { $body | ConvertTo-Json -Depth 10 }

    # -------------------------
    # CALL MOODLE API
    # -------------------------
    try {
        $response = Invoke-RestMethod -Method Post `
            -Uri "https://$LMS_URL/webservice/rest/server.php" `
            -Body $body

        return $response
    }
    catch {
        throw "Moodle API call failed: $($_.Exception.Message)"
    }
}