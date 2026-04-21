$body = @{
    wstoken            = $env:API_SYNC_TOKEN
    wsfunction         = "local_gradesaver_save_grade"
    moodlewsrestformat = "json"
    assignmentid       = 9
    userid             = 268
    attemptnumber      = 0
    workflowstate      = "graded"

    "rubric[criteria][0][criterionid]" = 26
    "rubric[criteria][0][levelid]"     = 62
    "rubric[criteria][0][remark]"      = "Good README"

    "rubric[criteria][1][criterionid]" = 27
    "rubric[criteria][1][levelid]"     = 64
    "rubric[criteria][1][remark]"      = "Images present"

    "rubric[criteria][2][criterionid]" = 28
    "rubric[criteria][2][levelid]"     = 66
    "rubric[criteria][2][remark]"      = "main.tf"

    "rubric[criteria][3][criterionid]" = 29
    "rubric[criteria][3][levelid]"     = 68
    "rubric[criteria][3][remark]"      = "VM"

    "rubric[criteria][4][criterionid]" = 30
    "rubric[criteria][4][levelid]"     = 70
    "rubric[criteria][4][remark]"      = "SSH"

}

$body | ConvertTo-Json -Depth 10

$response = Invoke-RestMethod -Method Post `
    -Uri "https://$($env:LMS_URL)/webservice/rest/server.php" `
    -Body $body

$response | ConvertTo-Json -Depth 10