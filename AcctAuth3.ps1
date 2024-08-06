# Check if the script is run as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # Relaunch as an administrator silently
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs -WindowStyle Hidden
    exit
}
# Define paths
$programFilesX86 = [Environment]::GetFolderPath("ProgramFilesX86")
$filePath = Join-Path -Path $programFilesX86 -ChildPath "Yap Bot\TwitchMarkovChain-2.4\tempinfo.txt"
$yapSettings = Join-Path -Path $programFilesX86 -ChildPath "Yap Bot\TwitchMarkovChain-2.4\Settings.py"

# Read contents of tempinfo.txt
$tempinfoContent = Get-Content -Path $filePath

# Extract values from tempinfo.txt
$oauth = $tempinfoContent[0]
$channel = $tempinfoContent[1]
$nickname = $tempinfoContent[2]
$deniedUsers = $tempinfoContent[3]
$cooldown = $tempinfoContent[4]
$generateCommands = $tempinfoContent[5]

# Read contents of Settings.py
$settingsContent = Get-Content -Path $yapSettings

# Modify Settings.py content
$settingsContent = $settingsContent -replace '(?<="Channel": ")[^"]+', $channel
$settingsContent = $settingsContent -replace '(?<="Nickname": ")[^"]+', $nickname
$settingsContent = $settingsContent -replace '(?<=Authentication": "oauth:)[^"]+', $oauth
$settingsContent = $settingsContent -replace '(?<="DeniedUsers": )\[.*?\]', $deniedUsers
$settingsContent = $settingsContent -replace '(?<="Cooldown": )[^,]+', $cooldown
$settingsContent = $settingsContent -replace '(?<="GenerateCommands": )\[.*?\]', $generateCommands

# Write modified content back to Settings.py
$settingsContent | Set-Content -Path $yapSettings

Write-Host "Settings.py has been updated."
exit