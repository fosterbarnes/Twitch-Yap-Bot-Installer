$Message = "Before the install starts:
1. Open powershell as administrator (search windows for powershell, right click > run as administrator) 

2. Type the following command then press enter:
Set-ExecutionPolicy Unrestricted

This is because the setup helper scripts in this installer require admin priveleges to function properly"
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[System.Windows.Forms.MessageBox]::Show($Message, "Setup", "OK", [System.Windows.Forms.MessageBoxIcon]::Information)

$Message = "The next window will be a Python installer.If you don't follow the next three steps Yap Bot will not work.

1. On the 'Install Python 3.12.1' page click 'Use admin priveleges when installing py.exe'
2. Click 'Add python.exe to PATH'
3. Click 'Install Now' and finish installing

Click 'OK' to start installing python"
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[System.Windows.Forms.MessageBox]::Show($Message, "Python Setup", "OK", [System.Windows.Forms.MessageBoxIcon]::Information)