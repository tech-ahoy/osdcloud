# Suppress progress bar for Invoke-Webrequest to speed up downloads
$ProgressPreference = 'SilentlyContinue'

$SetupComplete = 'C:\OSDCloud\Scripts\SetupComplete'
$NinjaURL = 'https://techahoy-tools.s3-eu-west-2.amazonaws.com/ninja/ninja-windows-zztemporg.msi'

# Create NinjaOne agent filename from everything after last '/' in download URL
$Installer = ($NinjaURL -split '\/')[-1]

Invoke-WebRequest $NinjaURL -OutFile "$SetupComplete\$Installer"

# Install NinjaOne agent
Start-Process -Wait -FilePath $SetupComplete\$Installer -ArgumentList "/qn"