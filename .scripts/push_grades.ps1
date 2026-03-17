# Exit on error
$ErrorActionPreference = "Stop"

# Ensure environment variables are set
if (-not $env:LMS_URL -or -not $env:API_SYNC_TOKEN) {
    Write-Error "LMS_URL or API_SYNC_TOKEN is not set!"
    exit 1
}

# Call Moodle API
try {
    $response = Invoke-RestMethod -Method Post `
        -Uri "https://$($env:LMS_URL)/webservice/rest/server.php" `
        -Body @{
            wstoken = $env:API_SYNC_TOKEN
            wsfunction = "core_webservice_get_site_info"
            moodlewsrestformat = "json"
        }

    # Output JSON nicely
    $response | Format-List

} catch {
    Write-Error "Failed to call Moodle API: $_"
    exit 1
}
