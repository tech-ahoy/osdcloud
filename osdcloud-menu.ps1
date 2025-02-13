# Powershell Script for a Menu with Numbered Options
do {
    Clear-Host
    Write-Host "====================================="
    Write-Host "            OSDCloud Menu            "
    Write-Host "====================================="
    Write-Host "1. Windows 11 Pro 24H2 OOBE"
    Write-Host "2. Windows 11 Pro 24H2 Autounattend"
    Write-Host "3. Windows 10 Pro 22H2 OOBE"
    Write-Host "4. Exit"
    Write-Host "====================================="
    $choice = Read-Host "Please select an option (1-4)"
    
    switch ($choice) {
        1 {
            Write-Host "`nSelected: Windows 11 Pro 24H2 OOBE" -ForegroundColor Cyan
            Invoke-RestMethod "https://raw.githubusercontent.com/tech-ahoy/osdcloud/refs/heads/main/osdcloud-config-win11pro-v1.ps1" | Invoke-Expression
            
        }
        2 {
            Write-Host "`nSelected: Windows 11 Pro 24H2 Autounattend" -ForegroundColor Cyan
            Invoke-RestMethod "https://raw.githubusercontent.com/tech-ahoy/osdcloud/refs/heads/main/osdcloud-config-win11pro-autounattend-test.ps1" | Invoke-Expression
            Write-Host "Nothing to see here"
            Pause
        }
        3 {
            Write-Host "`nSelected: Windows 10 Pro 22H2 OOBE" -ForegroundColor Cyan
            Write-Host "Nothing to see here"
            Pause
        }
        4 {
            Write-Host "Exiting the script. Goodbye!" -ForegroundColor Green
            break
        }
        default {
            Write-Host "`nInvalid selection. Please try again." -ForegroundColor Red
            Pause
        }
    }
} while ($choice -ne 4)
