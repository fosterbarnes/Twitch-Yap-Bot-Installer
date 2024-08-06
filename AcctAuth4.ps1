# Check if the script is run as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # Relaunch as an administrator silently
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs -WindowStyle Hidden
    exit
}
$programFilesX86 = [Environment]::GetFolderPath("ProgramFilesX86")
$yapSettings = Join-Path -Path $programFilesX86 -ChildPath "Yap Bot\TwitchMarkovChain-2.4\Settings.py"

# Read the content of the file
$content = Get-Content $yapSettings

# Modify line 36
$content[35] = $content[35] -replace '"Channel": ""Channel": "', '"Channel": "'
# Remove the last 2 characters from line 36
$content[35] = $content[35] -replace '..$'

# Modify line 37
$content[36] = $content[36] -replace '"Nickname": ""Nickname": ', '"Nickname": '
# Remove the last 2 characters from line 37
$content[36] = $content[36] -replace '..$'

# Modify line 38
$content[37] = $content[37] -replace '"Authentication": "oauth:oauth:', '"Authentication": "oauth:'

# Replace line 39
$content[38] = $content[38] -replace '"DeniedUsers": "DeniedUsers": ', '"DeniedUsers": '
# Remove the last character from line 39
$content[38] = $content[38] -replace '.$'

# Replace line 41
$content[40] = $content[40] -replace '"Cooldown": "Cooldown":', '"Cooldown":'
# Remove the last character from line 41
$content[40] = $content[40] -replace '.$'

# Replace line 51
$content[50] = $content[50] -replace '"GenerateCommands": "GenerateCommands":', '"GenerateCommands":'

# Write the modified content back to the file
$content | Set-Content $yapSettings
exit