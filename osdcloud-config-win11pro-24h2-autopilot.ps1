<#

OSDCloud Windows 11 Autopilot Wrapper Script 2025-03-26

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

write-host "OSDCloud Process Complete, rebooting" -ForegroundColor Green

#endregion


#region Post OSDCloud, do more things in WinPE before you reboot.

#endregion


#Restart Computer After OSDCloud is complete in WinPE
Restart-Computer

#endregion
