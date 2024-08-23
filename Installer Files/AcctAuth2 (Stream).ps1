# Define paths
$filePath = Join-Path -Path $env:USERPROFILE -ChildPath "Downloads\tempinfo.txt"

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