##[Ps1 To Exe]
##
##Kd3HDZOFADWE8uO1
##Nc3NCtDXTlGDjofG5iZk2W3hUXwufPmrsLWz0ZO57Nb1ujWZQJkbRxRngzvsCE7zUPEdNQ==
##Kd3HFJGZHWLWoLaVvnQnhQ==
##LM/RF4eFHHGZ7/K1
##K8rLFtDXTiW5
##OsHQCZGeTiiZ4NI=
##OcrLFtDXTiW5
##LM/BD5WYTiiZ4tI=
##McvWDJ+OTiiZ4tI=
##OMvOC56PFnzN8u+Vs1Q=
##M9jHFoeYB2Hc8u+Vs1Q=
##PdrWFpmIG2HcofKIo2QX
##OMfRFJyLFzWE8uK1
##KsfMAp/KUzWJ0g==
##OsfOAYaPHGbQvbyVvnQX
##LNzNAIWJGmPcoKHc7Do3uAuO
##LNzNAIWJGnvYv7eVvnQX
##M9zLA5mED3nfu77Q7TV64AuzAgg=
##NcDWAYKED3nfu77Q7TV64AuzAgg=
##OMvRB4KDHmHQvbyVvnQX
##P8HPFJGEFzWE8tI=
##KNzDAJWHD2fS8u+Vgw==
##P8HSHYKDCX3N8u+Vgw==
##LNzLEpGeC3fMu77Ro2k3hQ==
##L97HB5mLAnfMu77Ro2k3hQ==
##P8HPCZWEGmaZ7/K1
##L8/UAdDXTlaDjofG5iZk2W3hUXwufPm/trWyyYSy6/nQmSTNSpJUb117kzrAIU+0TbIrVOVbsckUNQ==
##Kc/BRM3KXxU=
##
##
##fd6a9f26a06ea3bc99616d4851b372ba
# Import necessary module for handling JSON
Import-Module -Name Microsoft.PowerShell.Utility

# Set paths for the original settings file and a temporary copy
$settingsPath = "C:\Program Files (x86)\Yap Bot\TwitchMarkovChain-2.4\settings.json"
$tempSettingsPath = [System.IO.Path]::GetTempFileName()

# Copy the settings file to a temporary location
Copy-Item -Path $settingsPath -Destination $tempSettingsPath -Force

# Load the contents of the JSON file
$jsonContent = Get-Content -Path $tempSettingsPath -Raw | ConvertFrom-Json

# Display the specific settings to the user
Write-Host "----------------------------------------------------------"
Write-Host "Current Settings:"
Write-Host "Channel: $($jsonContent.Channel)"
Write-Host "Nickname: $($jsonContent.Nickname)"
Write-Host "Authentication: $($jsonContent.Authentication)"
Write-Host "DeniedUsers: $($jsonContent.DeniedUsers -join ', ')"
Write-Host "Cooldown: $($jsonContent.Cooldown)"
Write-Host "MaxSentenceWordAmount: $($jsonContent.MaxSentenceWordAmount)"

# Ask if the user wants to edit any of the info
Write-Host "----------------------------------------------------------"
$editResponse = Read-Host "Do you want to edit any of your info?(yes/no)"
Write-Host "Pressing enter without typing anything will use default"
Write-Host "----------------------------------------------------------"
$editResponse = if ([string]::IsNullOrWhiteSpace($editResponse)) { "yes" } else { $editResponse.ToLower() }

if ($editResponse -eq "yes") {
    # Helper function to handle empty input and use default values
    function Get-UserInput {
        param (
            [string]$Prompt,
            [string]$DefaultValue
        )
        # Use the default value as a placeholder
        $input = Read-Host "$Prompt (default: $DefaultValue)"
        if ([string]::IsNullOrWhiteSpace($input)) {
            return $DefaultValue
        }
        return $input
    }

    # Edit each setting interactively with default values
    $jsonContent.Channel = Get-UserInput -Prompt "Channel" -Default $jsonContent.Channel
    $jsonContent.Nickname = Get-UserInput -Prompt "Nickname" -Default $jsonContent.Nickname
    $jsonContent.Authentication = Get-UserInput -Prompt "Authentication" -Default $jsonContent.Authentication
    
    # Edit DeniedUsers as a comma-separated list
    $deniedUsers = Get-UserInput -Prompt "DeniedUsers (comma-separated)" -Default ($jsonContent.DeniedUsers -join ', ')
    $jsonContent.DeniedUsers = $deniedUsers -split ',\s*' | Where-Object { $_ -ne '' }
    
    $jsonContent.Cooldown = [int](Get-UserInput -Prompt "Cooldown" -Default $jsonContent.Cooldown)
    $jsonContent.MaxSentenceWordAmount = [int](Get-UserInput -Prompt "MaxSentenceWordAmount" -Default $jsonContent.MaxSentenceWordAmount)

    # Display the updated settings
    Write-Host "----------------------------------------------------------"
    Write-Host "`nUpdated Settings:"
    Write-Host "Channel: $($jsonContent.Channel)"
    Write-Host "Nickname: $($jsonContent.Nickname)"
    Write-Host "Authentication: $($jsonContent.Authentication)"
    Write-Host "DeniedUsers: $($jsonContent.DeniedUsers -join ', ')"
    Write-Host "Cooldown: $($jsonContent.Cooldown)"
    Write-Host "MaxSentenceWordAmount: $($jsonContent.MaxSentenceWordAmount)"
    Write-Host "----------------------------------------------------------"

    # Ask if the user wants to save the changes to the original file
    $saveResponse = Read-Host "Would you like to save these changes? (yes/no)"
    $saveResponse = if ([string]::IsNullOrWhiteSpace($saveResponse)) { "yes" } else { $saveResponse.ToLower() }

    if ($saveResponse -eq "yes") {
        # Save the edited settings back to the original file
        $jsonContent | ConvertTo-Json -Depth 10 | Set-Content -Path $settingsPath -Force
        Write-Host "Settings have been updated and saved to the original file: $settingsPath"
        Start-Sleep -Seconds 5
    } else {
        Write-Host "No changes were saved. The temporary file is located at: $tempSettingsPath"
        Start-Sleep -Seconds 5
    }
} else {
    Write-Host "No changes were made. The temporary file is located at: $tempSettingsPath"
    Start-Sleep -Seconds 5
}
