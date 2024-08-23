# Load required assemblies for Windows Forms
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create tempinfo.txt in the Downloads folder
$filePath = Join-Path -Path $env:USERPROFILE -ChildPath "Downloads\tempinfo.txt"
New-Item -Path $filePath -ItemType "file" -Force -ErrorAction SilentlyContinue | Out-Null

# Prompt user to click OK then open OAuth link
Write-Host  "1. Login with your bot's Twitch account in your main web browser. Login with a bot account you'd use with something like Mixitup, not your main account.
2. Press any key to continue on this window to generate an OAuth password 
3. Copy the password that is generated.
4. Close the browser window and paste the OAuth password into the next window that pops up.

Press any key to generate OAuth password..."
[void][System.Console]::ReadKey($true)

Start-Process -FilePath "https://id.twitch.tv/oauth2/authorize?response_type=token&client_id=q6batx0epp608isickayubi39itsckt&redirect_uri=https://twitchapps.com/tmi/&scope=chat:read+chat:edit+channel:moderate+whispers:read+whispers:edit+channel_editor"

# Create a form for user input
$form = New-Object System.Windows.Forms.Form
$form.Text = "Enter OAuth Password"
$form.Size = New-Object System.Drawing.Size(400, 150)
$form.StartPosition = "CenterScreen"

# Create a text box for user input
$textbox = New-Object System.Windows.Forms.TextBox
$textbox.Location = New-Object System.Drawing.Point(50, 30)
$textbox.Size = New-Object System.Drawing.Size(300, 20)
$form.Controls.Add($textbox)

# Create an OK button
$button = New-Object System.Windows.Forms.Button
$button.Location = New-Object System.Drawing.Point(150, 70)
$button.Size = New-Object System.Drawing.Size(100, 30)
$button.Text = "OK"
$button.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.Controls.Add($button)

# Show the form as a dialog box and get the result
$result = $form.ShowDialog()

# If the user clicks OK, save the entered password to the file
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $Password = $textbox.Text
    $Password | Out-File -FilePath $filePath -Force
}

# Dispose the form
$form.Dispose()

# Tell the user about the info they will need to provide
$Message = "In the next window, you'll be prompted to enter more info about your Twitch bot account as well as configure some options for the Yap Bot"
[void][System.Windows.Forms.MessageBox]::Show($Message, "User Info", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Information)

# Function to prompt user for input and save to tempinfo.txt
function PromptAndSave($prompt, $infoText, $defaultText = "") {
    # Create a form for user input
    $form = New-Object System.Windows.Forms.Form
    $form.Text = "Yap Bot Configuration"
    $form.Size = New-Object System.Drawing.Size(400, 180)
    $form.StartPosition = "CenterScreen"
    $form.FormBorderStyle = "FixedDialog"

    # Create label and text box
    $label = New-Object System.Windows.Forms.Label
    $label.Text = $prompt
    $label.AutoSize = $true
    $label.Location = New-Object System.Drawing.Point(20, 20)
    $form.Controls.Add($label)

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(20, 50)
    $textBox.Size = New-Object System.Drawing.Size(350, 20)
    $textBox.Text = $defaultText  # Set default text
    $form.Controls.Add($textBox)

    # Create an OK button
    $button = New-Object System.Windows.Forms.Button
    $button.Text = "OK"
    $button.Location = New-Object System.Drawing.Point(150, 90)
    $button.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.AcceptButton = $button
    $form.Controls.Add($button)

    # Show the form as a dialog box and get the result
    $result = $form.ShowDialog()

    # If the user clicks OK, save the entered information to the file
    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        $inputText = $textBox.Text
        if ($infoText -eq "DeniedUsers:") {
            # For DeniedUsers, format the input as an array
            $inputTextArray = $inputText -split ','
            $inputTextArray = $inputTextArray.Trim() | ForEach-Object { "`"$_`"" }
            $inputTextFormatted = $inputTextArray -join ", "
            $infoText = "`"$infoText`": [$inputTextFormatted]"
        } elseif ($infoText -eq "GenerateCommands:") {
            # For GenerateCommands, format the input as an array
            $inputTextArray = $inputText -split ','
            $inputTextArray = $inputTextArray.Trim() | ForEach-Object { "`"$_`"" }
            $inputTextFormatted = $inputTextArray -join ", "
            $infoText = "`"$infoText`": [$inputTextFormatted]"
        } else {
            # For other inputs, format as key-value pair
            $infoText = "`"$infoText`": `"$inputText`""           
        }
        $infoText | Out-File -FilePath $filePath -Append
    }

    # Dispose the form
    $form.Dispose()
}

# Prompt for Main Channel Name
PromptAndSave "Main Channel Name (The account you stream on):" "Channel:"

# Prompt for Bot Channel Name
PromptAndSave "Bot Channel Name (the account for your bot):" "Nickname:"

# Append denied users
$deniedUsers = '"DeniedUsers": ["StreamElements", "Nightbot", "Moobot", "Marbiebot", "LumiaStream"]'
$deniedUsers | Out-File -FilePath $filePath -Append

# Prompt for additional Denied Users
PromptAndSave "Denied Users (comma-separated):" "DeniedUsers:" "StreamElements, Nightbot, Moobot, Marbiebot, LumiaStream"

# Prompt for Cooldown
PromptAndSave "Cooldown (Seconds):" "Cooldown:"

# Append generate commands
$generateCommands = '"GenerateCommands": ["!generate", "!g", "!yap"]'
$generateCommands | Out-File -FilePath $filePath -Append

# Prompt for additional Generate Commands
PromptAndSave "Generate Command (comma-separated):" "GenerateCommands:" "!generate, !g, !yap"

# Remove lines 4 & 7 from tempinfo.txt
$content = Get-Content -Path $filePath
$content[3] = ''
$content[6] = ''
for ($i = 1; $i -lt $content.Count; $i++) {
    if ($i -ne 0) {
        $content[$i] = $content[$i] -replace '^(.*?):', '$1'
    }
}
$content | Out-File -FilePath $filePath -Force

# Remove empty lines and rearrange tempinfo.txt
(Get-Content -Path $filePath | Where-Object { $_ -match '\S' }) | Out-File -FilePath $filePath -Force

# Ensure "DeniedUsers" and "GenerateCommands" are retained
$lines = Get-Content -Path $filePath
$lines[3] = '"DeniedUsers": [' + $lines[3] + ']'
$lines[5] = '"GenerateCommands": [' + $lines[5] + ']'
$lines | Out-File -FilePath $filePath -Force

# Remove duplicated labels
(Get-Content -Path $filePath) | ForEach-Object {
    $_ -replace '"DeniedUsers": \["DeniedUsers": ', '"DeniedUsers": ' `
       -replace '"GenerateCommands": \["GenerateCommands": ', '"GenerateCommands": ' `
       -replace '\]$', ''
} | Out-File -FilePath $filePath -Force

# Add commas to the end of lines 2, 3, 4, and 5
$content = Get-Content -Path $filePath
$content[1] += ','
$content[2] += ','
$content[3] += ','
$content[4] += ','
$content | Out-File -FilePath $filePath -Force

Pause

# Clean up tempinfo.txt
# Define paths
$filePath2 = Join-Path -Path $env:USERPROFILE -ChildPath "Downloads\tempinfo.txt"

# Read the content of the file
$content2 = Get-Content $filePath

# Check if line 2 contains the pattern to replace
if ($content2[1] -match '"Channel": "') {
    # Replace the pattern with the desired string
    $content2[1] = $content2[1] -replace '"Channel": "', '"Channel": "#'
}

# Remove all quotes from line 5
$content2[4] = $content2[4] -replace '"', ''
# Replace 'Cooldown' with '"Cooldown"' in line 5
$content2[4] = $content2[4] -replace 'Cooldown', '"Cooldown"'

# Write the modified content back to the file
$content2 | Set-Content $filePath2
