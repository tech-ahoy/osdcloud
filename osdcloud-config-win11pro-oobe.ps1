<#

OSDCloud Windows 11 OOBE Wrapper Script 2025-02-17

This will set the variables used by OSDCloud, update the MS Surface Drivers Catalog, then start OSDCloud, along with do a few things after

you can edit your OSDCloud Boot Media to automatically start this by hosting this on GitHub, and modifying your boot image like:


3 Regions in script

Pre OSDCloud
Start OSDCloud
Post OSDCloud

Pre OSDCloud is for setting variables, updating BIOS Settings, etc

Start OSDCloud, you can change your command line, but really nothing to do here

Post OSDCloud, this is where you can do a lot of extra customization to your Offline Windows, call scripts to remove AppX packages, slip in a CU, inject files,
 - Add Additional PowerShell Modules
 - Add a custom SetupComplete file (do not overwrite the one OSDCloud creates, use the custom path that OSDCloud would trigger)
 - Add OEM Specific stuff
 - Remove built in Items
 - Apply CU / SSU / etc offline before rebooting
 - Add Custom wallpapers
 - Edit the Offline Registry
 - SO MANY THINGS
 - Finally reboot


#>

write-host "-------------------------------------------------" -ForegroundColor Cyan
write-host "Starting Custom OSDCloud Wrapper" -ForegroundColor Cyan
write-host "-------------------------------------------------" -ForegroundColor Cyan
Write-Host ""


#region Tasks to run in WinPE before triggering OSD Cloud

#Variables to define the Windows OS / Edition etc to be applied during OSDCloud
$Product = (Get-MyComputerProduct)
$Model = (Get-MyComputerModel)
$Manufacturer = (Get-CimInstance -ClassName Win32_ComputerSystem).Manufacturer
$OSVersion = 'Windows 11' #Used to Determine Driver Pack
$OSReleaseID = '24H2' #Used to Determine Driver Pack
$OSName = 'Windows 11 24H2 x64'
$OSEdition = 'Pro'
$OSActivation = 'Retail'
$OSLanguage = 'en-gb'


#Set OSDCloud Vars
$Global:MyOSDCloud = [ordered]@{
    Restart = [bool]$false
    RecoveryPartition = [bool]$true
    OEMActivation = [bool]$true
    WindowsUpdate = [bool]$false
    WindowsUpdateDrivers = [bool]$false
    WindowsDefenderUpdate = [bool]$true
    MSCatalogFirmware = [bool]$true
    SetTimeZone = [bool]$true
    ClearDiskConfirm = [bool]$true
    ShutdownSetupComplete = [bool]$false
    #SyncMSUpCatDriverUSB = [bool]$true
    CheckSHA1 = [bool]$false
}

#endregion


#region OSDCloud

#Launch OSDCloud
Write-Host "Starting OSDCloud on $Manufacturer $Model $Product" -ForegroundColor Green
write-host "Start-OSDCloud -OSName $OSName -OSEdition $OSEdition -OSActivation $OSActivation -OSLanguage $OSLanguage" -ForegroundColor Green

Start-OSDCloud -OSName $OSName -OSEdition $OSEdition -OSActivation $OSActivation -OSLanguage $OSLanguage

write-host "OSDCloud Process Complete, Running Custom Actions From Script Before Reboot" -ForegroundColor Green

#endregion


#region Post OSDCloud, do more things in WinPE before you reboot.

function New-SetupCompleteOSDCloudFiles{
        
        $SetupCompletePath = "C:\OSDCloud\Scripts\SetupComplete"
        $ScriptsPath = $SetupCompletePath

        if (!(Test-Path -Path $ScriptsPath)){New-Item -Path $ScriptsPath -ItemType Directory -Force | Out-Null}

        $RunScript = @(@{ Script = "SetupComplete"; BatFile = 'SetupComplete.cmd'; ps1file = 'SetupComplete.ps1';Type = 'Setup'; Path = "$ScriptsPath"})

        Write-Output "Creating $($RunScript.Script) Files in $SetupCompletePath"

        $BatFilePath = "$($RunScript.Path)\$($RunScript.batFile)"
        $PSFilePath = "$($RunScript.Path)\$($RunScript.ps1File)"
                
        #Create Batch File to Call PowerShell File
        if (Test-Path -Path $PSFilePath){
            copy-item $PSFilePath -Destination "$ScriptsPath\SetupComplete.ps1.bak"
        }        
        New-Item -Path $BatFilePath -ItemType File -Force
        $CustomActionContent = New-Object system.text.stringbuilder
        [void]$CustomActionContent.Append('%windir%\System32\WindowsPowerShell\v1.0\powershell.exe -ExecutionPolicy ByPass -File C:\OSDCloud\Scripts\SetupComplete\SetupComplete.ps1')
        Add-Content -Path $BatFilePath -Value $CustomActionContent.ToString()

        #Create PowerShell File to do actions

        New-Item -Path $PSFilePath -ItemType File -Force
        Add-Content -path $PSFilePath "Write-Output 'Starting SetupComplete TyDoneRight Script Process'"
        Add-Content -path $PSFilePath "Write-Output 'Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/tech-ahoy/osdcloud/refs/heads/main/SetupComplete.ps1)'"
        Add-Content -path $PSFilePath 'if ((Test-WebConnection) -ne $true){Write-error "No Internet, Sleeping 2 Minutes" ; start-sleep -seconds 120}'
        Add-Content -path $PSFilePath 'Invoke-Expression (Invoke-RestMethod https://raw.githubusercontent.com/tech-ahoy/osdcloud/refs/heads/main/SetupComplete.ps1)'
    }
    #endregion

Write-Host "OSDCloud process complete, running custom actions from script before reboot"

Write-Host "Creating custom SetupComplete files"

New-SetupCompleteOSDCloudFiles


#Restart Computer After OSDCloud is complete in WinPE
Restart-Computer

#endregion
