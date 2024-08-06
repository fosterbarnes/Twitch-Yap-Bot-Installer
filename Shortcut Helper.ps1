# Check if the script is run as administrator
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    # Relaunch as an administrator silently
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs -WindowStyle Hidden
    exit
}
$Message = "If you don't do these next steps, Twitch Yap Bot won't work.
1. Right click the new 'Twitch Yap Bot' shortcut on your desktop
2. Click Properties
3. Select 'Shortcut' from the menu on top
4. Click 'Advanced'
5. Click 'Run as administrator'
6. Click 'OK'"
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[System.Windows.Forms.MessageBox]::Show($Message, "Almost Done!", "OK", [System.Windows.Forms.MessageBoxIcon]::Information)

$Message = "Last step I PROMISE

1. Run 'Twitch Yap Bot' from your desktop shortcut then 'Press any key to continue . . .' when prompted. This sets up a few files in the backend.
2. Run 'Twitch Yap Bot' one more time, this time it should be up and running!

All done! Use '!yap' (or any other command you defined earlier) in your chat to test it out

Clicking OK on this window will show an image of what yap bot should look like if it's running properly."
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[System.Windows.Forms.MessageBox]::Show($Message, "Almost Done!", "OK", [System.Windows.Forms.MessageBoxIcon]::Information)
Start-Process -FilePath "https://i.imgur.com/Acb9J8m.png"