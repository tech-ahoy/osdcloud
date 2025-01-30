Write-Host -ForegroundColor Green "Starting OSDCloud"
Start-Sleep -Seconds 5

Start-OSDCloud -OSVersion 'Windows 11' -OSBuild 24H2 -OSEdition Pro -OSLanguage en-gb -OSLicense Retail -Firmware

Write-Host -ForegroundColor Green "Installing Windows 11 Pro 24H2 en-gb"

#Restart from WinPE

Write-Host -ForegroundColor Green "Restarting in 20 seconds!"

Start-Sleep -Seconds 20

wpeutil reboot