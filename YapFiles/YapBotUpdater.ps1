# Set the title of the PowerShell window
$Host.UI.RawUI.WindowTitle = "Yap Bot Updater"

# Download TwitchMarkovChain & YapFiles, unzip and delete zip
#Invoke-WebRequest -Uri "https://github.com/fosterbarnes/YapFiles/archive/refs/heads/main.zip" -OutFile "$env:USERPROFILE\Downloads\YapFiles.zip"
#Add-Type -AssemblyName System.IO.Compression.FileSystem
#[System.IO.Compression.ZipFile]::ExtractToDirectory("$env:USERPROFILE\Downloads\YapFiles.zip", "$env:USERPROFILE\Downloads\YapFiles")
#Remove-Item -Path "$env:USERPROFILE\Downloads\YapFiles.zip"
# Download TwitchMarkovChain, Yap Files, unzip and delete zip
Invoke-WebRequest -Uri "https://github.com/fosterbarnes/Twitch-Yap-Bot-Installer/archive/refs/heads/main.zip" -OutFile "$env:USERPROFILE\Downloads\Twitch-Yap-Bot-Installer.zip"
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory("$env:USERPROFILE\Downloads\Twitch-Yap-Bot-Installer.zip", "$env:USERPROFILE\Downloads\Twitch-Yap-Bot-Installer-1")
Remove-Item -Path "$env:USERPROFILE\Downloads\Twitch-Yap-Bot-Installer.zip"
Copy-Item -Path "$env:USERPROFILE\Downloads\Twitch-Yap-Bot-Installer-1\Twitch-Yap-Bot-Installer-main" -Destination "$env:USERPROFILE\Downloads\Twitch-Yap-Bot-Installer" -Recurse
Remove-Item -Path "$env:USERPROFILE\Downloads\Twitch-Yap-Bot-Installer-1\" -Recurse -Force
Copy-Item -Path "$env:USERPROFILE\Downloads\Twitch-Yap-Bot-Installer\YapFiles" -Destination "$env:USERPROFILE\Downloads\YapFiles" -Recurse
Copy-Item -Path "$env:USERPROFILE\Downloads\Twitch-Yap-Bot-Installer\TwitchMarkovChain" -Destination "$env:USERPROFILE\Downloads\YapFiles\TwitchMarkovChain" -Recurse
Remove-Item -Path "$env:USERPROFILE\Downloads\Twitch-Yap-Bot-Installer" -Recurse -Force

Write-Host "Updating Yap Bot..."

#Copy and replace YapBotInstaller, YapBotUninstaller, YapBotUpdater & YapEditor
Copy-Item -Path "$env:USERPROFILE\Downloads\YapFiles\Twitch Yap Bot.ps1" -Destination "$env:USERPROFILE\Documents\Applications\Yap Bot" -Recurse -Force
Copy-Item -Path "$env:USERPROFILE\Downloads\YapFiles\yap icon.ico" -Destination "$env:USERPROFILE\Documents\Applications\Yap Bot" -Recurse -Force
Copy-Item -Path "$env:USERPROFILE\Downloads\YapFiles\yap icon purple.ico" -Destination "$env:USERPROFILE\Documents\Applications\Yap Bot" -Recurse -Force
Copy-Item -Path "$env:USERPROFILE\Downloads\YapFiles\yap icon blue.ico" -Destination "$env:USERPROFILE\Documents\Applications\Yap Bot" -Recurse -Force
Copy-Item -Path "$env:USERPROFILE\Downloads\YapFiles\YYapBotUninstaller.ps1" -Destination "$env:USERPROFILE\Documents\Applications\Yap Bot" -Recurse -Force
Copy-Item -Path "$env:USERPROFILE\Downloads\YapFiles\YapEditor.ps1" -Destination "$env:USERPROFILE\Documents\Applications\Yap Bot" -Recurse -Force
Copy-Item -Path "$env:USERPROFILE\Downloads\YapFiles\YapBotUpdater.ps1" -Destination "$env:USERPROFILE\Documents\Applications\Yap Bot" -Recurse -Force

Write-Host "`n-----------------------------------------------------------------"
Write-Host "Twitch Yap Bot.ps1 saved to $env:USERPROFILE\Documents\Applications\Yap Bot\Twitch Yap Bot.ps1"
Write-Host "yap icon.ico saved to $env:USERPROFILE\Documents\Applications\Yap Bot\yap icon.ico"
Write-Host "yap icon purple.ico saved to $env:USERPROFILE\Documents\Applications\Yap Bot\yap icon purple.ico"
Write-Host "yap icon blue.ico saved to $env:USERPROFILE\Documents\Applications\Yap Bot\yap icon blue.ico"
Write-Host "YapBotUninstaller.ps1 saved to $env:USERPROFILE\Documents\Applications\Yap Bot\YapBotUninstaller.ps1"
Write-Host "YapEditor.ps1 saved to $env:USERPROFILE\Documents\Applications\Yap Bot\YapEditor.ps1"
Write-Host "YapUpdater.ps1 saved to $env:USERPROFILE\Documents\Applications\Yap Bot\YapBotUpdater.ps1"
Write-Host "-----------------------------------------------------------------"

#Cleanup
Remove-Item -Path "$env:USERPROFILE\Downloads\YapFiles" -Recurse -Force

Write-Host "`nPress any key to close Yap Bot Updater..."
[void][System.Console]::ReadKey($true)
exit