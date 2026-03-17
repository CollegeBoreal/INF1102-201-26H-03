# Exit on error
$ErrorActionPreference = "Stop"

# Ensure environment variables are set
if (-not $env:LMS_URL -or -not $env:API_SYNC_TOKEN) {
    Write-Error "LMS_URL or API_SYNC_TOKEN is not set!"
    exit 1
}

# Call Moodle API to get site info
$response = curl -Method POST `
    -Uri "https://$($env:LMS_URL)/webservice/rest/server.php" `
    -Body @{
        wstoken = $env:API_SYNC_TOKEN
        wsfunction = "core_webservice_get_site_info"
        moodlewsrestformat = "json"
    }

# Parse JSON if desired
$response.Content | ConvertFrom-Json | Format-List
