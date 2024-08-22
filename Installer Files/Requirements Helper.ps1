$Message = "The next window will install python dependencies for Yap Bot.

Click 'OK' on this window then press any key to continue when prompted"
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[System.Windows.Forms.MessageBox]::Show($Message, "Install Requirements", "OK", [System.Windows.Forms.MessageBoxIcon]::Information)