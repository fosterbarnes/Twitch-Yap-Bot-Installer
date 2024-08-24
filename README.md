# Twitch Yap Bot Installer

Beginner friendly windows installer for [TwitchMarkovChain](https://github.com/tomaarsen/TwitchMarkovChain)

All powershell scripts used are included [here](https://github.com/fosterbarnes/Twitch-Yap-Bot-Installer/tree/main/Installer%20Files) and [here](https://github.com/fosterbarnes/YapFiles) in case you want to look through them and see exactly what they do. This was created and tested on Windows 10, Windows 11 should work too but it has not been tested.

Part of the guide shows you how to temporarily disable UAC. PLEASE turn this back on after you're done.

---

## Instructions

1. Search Windows for UAC and press "Enter". Then set it to "Never Notify" in the window that pops up

![uac2](https://github.com/user-attachments/assets/18a7e563-5832-41de-bc1a-2ba6e52e358c)![2](https://github.com/user-attachments/assets/55d641f1-86bb-4c31-882c-3b04c398c4cb)




3. Search windows for powershell, right click "windows powershell" (NOT powershell ISE) and open as administrator

![pwsh2](https://github.com/user-attachments/assets/7a44234a-ffc3-460c-a199-657d3b183a02)



4. Copy and paste the following into powershell, then press enter: `Set-ExecutionPolicy Unrestricted`  . After pressing enter, press 'A' and press enter again

![cmd](https://github.com/user-attachments/assets/d6349e05-a37c-422a-b715-66ffb79a3f54)


5. In the same powershell window, copy and paste the following then press enter to start installing Yap Bot:
   
`iex (irm https://is.gd/YapInstaller)`

Follow the on screen instructions to install.

When running Yap Bot in the future, open it from the desktop/start menu shortcut before streaming with OBS/Streamlabs. When either OBS or Streamlabs closes, Yap Bot will quit automatically.

After installing, if you need to edit any of your info (account, denied users, cooldown etc.), copy and paste the following into an admin powershell window, then press enter

`iex (irm https://is.gd/YapEditor)`

If you want to uninstall, copy and paste the following into an admin powershell window, then press enter
   
`iex (irm https://is.gd/YapUninstaller)`

---

## On Screen Instructions

-----------------------------STEP 1------------------------------

Yap Bot is a Python script. If you don't follow the next three steps 
and install Python, Yap Bot will not work.
If you are updating or re-installing, you can skip the Python installation
by clicking cancel.

1. After starting the Python installer, click 'Use admin priveleges when
installing py.exe'
2. Click 'Add python.exe to PATH'
3. Click 'Install Now' and finish installing

Press any key to start installing python...

-----------------------------STEP 2------------------------------

Installing python dependencies...

Press any key to continue...

-----------------------------STEP 3------------------------------

1. Login with your bot's Twitch account in your main web browser.
Login with a bot account you'd use with something like Mixitup, not your main account.
2. Press any key to continue on this window to generate an OAuth password
3. Copy the password that is generated.
4. Close the browser window and paste the OAuth password into the
next window that pops up.

Press any key to generate OAuth password...

-----------------------------STEP 4------------------------------

If you don't do these next steps, Twitch Yap Bot may not start correctly.
1. Right click the new 'Twitch Yap Bot' shortcut on your desktop
2. Click Properties
3. Select 'Shortcut' from the menu on top
4. Click 'Advanced'
5. Click 'Run as administrator'
6. Click 'OK'

Press any key to continue...

-----------------------------STEP 5------------------------------

We need to run Yap Bot to set some things up. Press any key in this
window to run Yap Bot, then press any key to continue in the new command prompt
window that pops up if prompted.

Close the new windows that open when it's done (DON'T ClOSE THIS WINDOW).

Press any key to continue...

-----------------------------STEP 6------------------------------

All done! Launch Yap Bot from the Desktop ot Start Menu, then use
'!yap' (or any other command you defined earlier) in your chat to test it out.
Have fun homie. Continuing with the installer will launch Yap
This is what Yap Bot looks like when it's running properly:

![7](https://github.com/user-attachments/assets/81ec5c82-1ef5-47e9-9ea9-c5ce73771e98)
