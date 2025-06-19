# Powershell Script for a Menu with Numbered Options
do {
    Clear-Host
    Write-Host "====================================="
    Write-Host "         Tech Ahoy OSDCloud          "
    Write-Host "====================================="
    Write-Host "1. Windows 11 Pro 24H2 OOBE (NinjaOne)"
    Write-Host 
    Write-Host "2. Windows 11 Pro 24H2 Autopilot"
    Write-Host
    Write-Host "3. Windows 11 Pro 24H2 Autounattend"
    Write-Host
    Write-Host "4. Windows 11 Home 24H2 OOBE (NinjaOne)"
    Write-Host
    Write-Host "5. Windows 11 Pro 23H2 OOBE (NinjaOne)"
    Write-Host
    Write-Host "6. Windows 10 Pro 22H2 OOBE (NinjaOne)"
    Write-Host
    Write-Host "7. Exit"
    Write-Host "====================================="
    Write-Host
    $choice = Read-Host "Please select an option (1-4)"
    
    switch ($choice) {
        1 {
            Write-Host "`nSelected: Windows 11 Pro 24H2 OOBE (NinjaOne)" -ForegroundColor Cyan
            Invoke-RestMethod "https://raw.githubusercontent.com/tech-ahoy/osdcloud/refs/heads/main/osdcloud-config-win11pro-24h2-oobe.ps1" | Invoke-Expression
            
        }
        2 {
            Write-Host "`nSelected: Windows 11 Pro 24H2 Autopilot" -ForegroundColor Cyan
            Invoke-RestMethod "https://raw.githubusercontent.com/tech-ahoy/osdcloud/refs/heads/main/osdcloud-config-win11pro-24h2-autopilot.ps1" | Invoke-Expression
        }
        3 {
            Write-Host "`nSelected: Windows 11 Pro 24H2 Autounattend" -ForegroundColor Cyan
            Invoke-RestMethod "https://raw.githubusercontent.com/tech-ahoy/osdcloud/refs/heads/main/osdcloud-config-win11pro-24h2-autounattend.ps1" | Invoke-Expression
        }
        4 {
            Write-Host "`nSelected: Windows 11 Home 24H2 OOBE (NinjaOne)" -ForegroundColor Cyan
            Invoke-RestMethod "https://raw.githubusercontent.com/tech-ahoy/osdcloud/refs/heads/main/osdcloud-config-win11home-24h2-oobe.ps1" | Invoke-Expression
        }
        5 {
            Write-Host "`nSelected: Windows 11 Pro 23H2 OOBE (NinjaOne)" -ForegroundColor Cyan
            Invoke-RestMethod "https://raw.githubusercontent.com/tech-ahoy/osdcloud/refs/heads/main/osdcloud-config-win11pro-23h2-oobe.ps1" | Invoke-Expression
        }
        6 {
            Write-Host "`nSelected: Windows 10 Pro 22H2 OOBE (NinjaOne)" -ForegroundColor Cyan
            Invoke-RestMethod "https://raw.githubusercontent.com/tech-ahoy/osdcloud/refs/heads/main/osdcloud-config-win10pro-22h2-oobe.ps1" | Invoke-Expression
        }
        7 {
            Write-Host "Exiting the script. Goodbye!" -ForegroundColor Green
            break
        }
        default {
            Write-Host "`nInvalid selection. Please try again." -ForegroundColor Red
            Pause
        }
    }
} while ($choice -ne 4)





