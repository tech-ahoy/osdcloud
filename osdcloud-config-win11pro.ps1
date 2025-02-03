Write-Host -ForegroundColor Green "Starting OSDCloud"
Start-Sleep -Seconds 5

Write-Host "Updating Surface Driver Catalog"
Invoke-RestMethod "https://raw.githubusercontent.com/everydayintech/OSDCloud-Public/refs/heads/main/Catalogs/Update-OSDCloudSurfaceDriverCatalogJustInTime.ps1" | Invoke-Expression 
Update-OSDCloudSurfaceDriverCatalogJustInTime -UpdateDriverPacksJson

Start-OSDCloud -OSVersion 'Windows 11' -OSBuild 24H2 -OSEdition Pro -OSLanguage en-gb -OSLicense Retail -Firmware

Write-Host -ForegroundColor Green "Installing Windows 11 Pro 24H2 en-gb"

#Restart from WinPE

Write-Host -ForegroundColor Green "Restarting in 20 seconds!"

Start-Sleep -Seconds 20

wpeutil reboot