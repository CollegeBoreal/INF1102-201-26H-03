$body = @{
    wstoken            = $env:API_SYNC_TOKEN
    wsfunction         = "local_gradesaver_save_grade"
    moodlewsrestformat = "json"
    assignmentid       = 8
    userid             = 268
    attemptnumber      = 0
    workflowstate      = "graded"

    "rubric[criteria][0][criterionid]" = 22
    "rubric[criteria][0][levelid]"     = 53
    "rubric[criteria][0][remark]"      = "Good README"

    "rubric[criteria][1][criterionid]" = 23
    "rubric[criteria][1][levelid]"     = 55
    "rubric[criteria][1][remark]"      = "Images present"

    "rubric[criteria][2][criterionid]" = 24
    "rubric[criteria][2][levelid]"     = 57
    "rubric[criteria][2][remark]"      = "scruter_nginx.sh"

    "rubric[criteria][3][criterionid]" = 25
    "rubric[criteria][3][levelid]"     = 58
    "rubric[criteria][3][remark]"      = "SSH"

}

$body | ConvertTo-Json -Depth 10

$response = Invoke-RestMethod -Method Post `
    -Uri "https://$($env:LMS_URL)/webservice/rest/server.php" `
    -Body $body

$response | ConvertTo-Json -Depth 10