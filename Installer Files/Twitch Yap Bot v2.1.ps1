##[Ps1 To Exe]
##
##Kd3HDZOFADWE8uO1
##Nc3NCtDXTlGDjofG5iZk2W3hUXwufPmrsLWz0ZO57Nb1ujWZQJkbRxp+lSac
##Kd3HFJGZHWLWoLaVvnQnhQ==
##LM/RF4eFHHGZ7/K1
##K8rLFtDXTiW5
##OsHQCZGeTiiZ4dI=
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
##L8/UAdDXTlaDjofG5iZk2W3hUXwufPm/trWyyYSy6/nQmSTNSpJUb117kzrAMFy0TfEaFcwUpJEzWglqOaBFs/zVA+LJ
##Kc/BRM3KXxU=
##
##
##fd6a9f26a06ea3bc99616d4851b372ba
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) { 
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs -WindowStyle Hidden 
    exit 
    } 
# Define the batch script content
$batchContent = @"
@echo off
title Twitch Yap Bot
cd "C:\Program Files (x86)\Yap Bot\TwitchMarkovChain-2.4"
"C:\Program Files (x86)\Yap Bot\TwitchMarkovChain-2.4\MarkovChainBot.py"
exit
"@

# Get the path to the temporary directory
$tempDir = [System.IO.Path]::GetTempPath()

# Define the temporary batch file path
$tempBatchFilePath = Join-Path -Path $tempDir -ChildPath "YapBotTemp.bat"

# Write the batch content to the temporary file
Set-Content -Path $tempBatchFilePath -Value $batchContent

# Run the temporary batch file
Start-Process cmd.exe -ArgumentList "/c `"$tempBatchFilePath`""

# Function to check if a process is running
function Wait-ForProcesses {
    param (
        [string[]]$processNames
    )

    do {
        $processFound = $false
        foreach ($processName in $processNames) {
            if (Get-Process -Name $processName -ErrorAction SilentlyContinue) {
                $processFound = $true
                break
            }
        }
        if (-not $processFound) {
            Write-Host "Waiting for OBS or Streamlabs OBS to start..."
            Start-Sleep -Seconds 2
        }
    } until ($processFound)
}

# Wait for either obs64.exe or Streamlabs OBS.exe to start
Wait-ForProcesses -processNames @("obs64", "Streamlabs OBS")

# Wait for the OBS process to exit
Wait-Process -Name obs64
Wait-Process -Name 'Streamlabs OBS'

# Stop the processes
Stop-Process -Name 'Twitch Yap Bot' -Force
Stop-Process -Name python -Force

# Remove the temporary batch file
Remove-Item -Path $tempBatchFilePath -Force