# Check if the script is run as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # Relaunch as an administrator silently
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs -WindowStyle Hidden
    exit
}

# Create tempinfo.txt
$programFilesX86 = [Environment]::GetFolderPath("ProgramFilesX86")
$filePath = Join-Path -Path $programFilesX86 -ChildPath "Yap Bot\TwitchMarkovChain-2.4\tempinfo.txt"
New-Item -Path $filePath -ItemType "file" -Force

# Prompt user to click OK then open OAuth link
$Message = "1. Click OK to generate a OAuth Password for your Twitch bot account. Make sure to login with your bot's Twitch account you'd use with something like Mixitup, not your main account. 
2. After logging in, copy the password that is generated.
3. Close the browser window and paste the OAuth password into the next window that pops up."
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[System.Windows.Forms.MessageBox]::Show($Message, "Twitch Bot Authentication", "OK", [System.Windows.Forms.MessageBoxIcon]::Information)
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

#Tell the user about the info they will need to provide
$Message = "In the next window, you'll be prompted to enter more info about your Twitch bot account as well as configure some options for the Yap Bot"
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[System.Windows.Forms.MessageBox]::Show($Message, "User Info", "OK", [System.Windows.Forms.MessageBoxIcon]::Information)

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
exit