$computerManufacturer = (Get-ItemProperty HKLM:\HARDWARE\DESCRIPTION\System\BIOS -Name SystemManufacturer).SystemManufacturer

function installSoftware {
     # Automates installation of software for new hires.
     # ToDo: Add prompt when installation completes. Fully automate installer.

     Set-Location -Path C:\Users\brian.lim\Desktop\'New Hire Software'\AcrobatMSI
     $currentDirectory = Get-Location
     Write-Host "You are in: $currentDirectory."

     $adobeReaderSetup = Start-Process AcroRead.msi /qn -Wait
     Write-Host "Acrobat installed." -ForeGroundColor Green


     Set-Location -Path C:\Users\brian.lim\Desktop\'New Hire Software'
     $currentDirectory = Get-Location
     Write-Host "Moving to $currentDirectory to install the rest of the software."

     $ciscoJabber = Start-Process CiscoJabberSetup.msi /qn -Wait
     Write-Host "Jabber installed." -ForeGroundColor Green
     $googleChrome = Start-Process googlechromestandaloneenterprise64.msi /qn -Wait
     Write-Host "Chrome installed." -ForeGroundColor Green
     $mozillaFirefox = Start-Process FireFoxSetup59.0.1.exe -ArgumentList /S -Wait
     Write-Host "FireFox installed." -ForeGroundColor Green
     $get7zip = Start-Process "7z1801-x64.exe" /S -Wait
     Write-Host "7-Zip installed." -ForeGroundColor Green
     $installVLC = .\vlc-3.0.1-win64.exe /L=1033 /S /NCRC -Wait
     Write-Host "VLC installed." -ForeGroundColor Green



     # Not silent yet..

     $teamViewer = Start-Process -FilePath C:\Users\brian.lim\Desktop\'New Hire Software'\TeamViewer_Host_Setup -Wait
     # Install Office
     $officeSetup = Start-Process -FilePath C:\Users\brian.lim\Desktop\'New Hire Software'\Setup.X64.en-us_O365ProPlusRetail_0f9737fa-0a50-4ecf-b81f-b3b0d8030cb5_TX_PR_b_64_ -Wait
     # Install IP Guard
     $ipGuard = Start-Process -FilePath C:\Users\brian.lim\Desktop\'New Hire Software'\'ip-guard-agen(4.12.0706)' -Wait
     # No wait on Webroot.
     $webroot = Start-Process -FilePath C:\Users\brian.lim\Desktop\'New Hire Software'\303dgsmtce0981424848
     Write-Host "Webroot installed." -ForeGroundColor Green


     Write-Host "Installation of software complete." -ForeGroundColor Green
}

function removeBloatware {
     $bloatwareFileNames = "*zunemusic*", "*officehub*", "*dropbox*", "*linkedin*", "*zunevideo*",
          "*pandora*", "*bingnews*", "*Duolingo*", "*Wallet*", "*advertising*", "*SkypeApp*",
          "*DellCustomerConnect*", "*DellHelpSupport*", "*EclipseManager*", "*Solitaire*",
          "*OneNote*", "*LenovoCompanion*", "*LenovoSettings*"

     for ($i=0; $i -lt $bloatwareFileNames.length; $i++) {

          if (Get-AppxPackage -Name $bloatwareFileNames[$i]) {
               Write-Host "Removing package: " $bloatwareFileNames[$i]'.' -ForeGroundColor green
               Get-AppxPackage $bloatwareFileNames[$i] | Remove-AppxPackage
          }
          else {Write-Host "Package "$bloatwareFileNames[$i] " is not found." -ForeGroundColor red}
     }
}

Write-Host "Performing software installation for $computerManufacturer"
if (($computerManufacturer -eq "Dell Inc.") -or ($computerManufacturer -eq "LENOVO")) {
     removeBloatware
     installSoftware
}

else {
     Write-Host "Error: This script does not support $computerManufacturer" -ForeGroundColor red
}
