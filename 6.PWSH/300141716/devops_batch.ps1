$date = Get-Date

$hostname = hostname
$user = whoami

$cpu = ps -eo comm,%cpu --sort=-%cpu | head -n 6
$mem = ps -eo comm,%mem --sort=-%mem | head -n 6
$disk = df -h
$sshTest = nc -zv 127.0.0.1 22 2>&1

"===== RAPPORT DEVOPS =====" | Out-File rapport.txt
"Date : $date" | Out-File rapport.txt -Append
"Utilisateur : $user" | Out-File rapport.txt -Append
"Machine : $hostname" | Out-File rapport.txt -Append
"`nCPU :" | Out-File rapport.txt -Append
$cpu | Out-File rapport.txt -Append
"`nMémoire :" | Out-File rapport.txt -Append
$mem | Out-File rapport.txt -Append
"`nDisque :" | Out-File rapport.txt -Append
$disk | Out-File rapport.txt -Append
"`nSSH Test :" | Out-File rapport.txt -Append
$sshTest | Out-File rapport.txt -Append

$report = @{
    Date = $date
    User = $user
    Machine = $hostname
}

$report | ConvertTo-Json | Out-File rapport.json