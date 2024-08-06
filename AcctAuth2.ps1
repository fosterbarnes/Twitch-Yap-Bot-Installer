# Check if the script is run as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # Relaunch as an administrator silently
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs -WindowStyle Hidden
    exit
}
# Define paths
$programFilesX86 = [Environment]::GetFolderPath("ProgramFilesX86")
$filePath = Join-Path -Path $programFilesX86 -ChildPath "Yap Bot\TwitchMarkovChain-2.4\tempinfo.txt"

# Read the content of the file
$content = Get-Content $filePath

# Check if line 2 contains the pattern to replace
if ($content[1] -match '"Channel": "') {
    # Replace the pattern with the desired string
    $content[1] = $content[1] -replace '"Channel": "', '"Channel": "#'
}

# Remove all quotes from line 5
$content[4] = $content[4] -replace '"', ''
# Replace 'Cooldown' with '"Cooldown"' in line 5
$content[4] = $content[4] -replace 'Cooldown', '"Cooldown"'

# Write the modified content back to the file
$content | Set-Content $filePath
exit