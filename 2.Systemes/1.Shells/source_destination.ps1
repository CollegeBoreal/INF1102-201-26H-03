$Source = "C:\Users\Daniella\Documents"
$Destination = "C:\Backup\backup.zip"

Compress-Archive -Path $Source -DestinationPath $Destination -Force
Write-Host "Sauvegarde terminée"
