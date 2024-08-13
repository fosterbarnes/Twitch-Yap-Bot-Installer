# Twitch Yap Bot Installer

Beginner friendly windows installer for [TwitchMarkovChain](https://github.com/tomaarsen/TwitchMarkovChain)

I made this installer using InstallForge, and have included several powershell scripts to help automate the setup process. I am by no means an expert programmer, so all of these scripts require admin priveleges. For this reason, the installer and files included may be a false positive for Windows antivirus. All powershell scripts used are included [here](https://github.com/fosterbarnes/Twitch-Yap-Bot-Installer/tree/main/Installer%20Files) in case you want to look through them and see exactly what they do. This was created and tested on Windows 10, Windows 11 should work too but it has not been tested.

Part of the guide shows you how to temporarily disable Windows antivirus and UAC. PLEASE turn these back on after you're done and don't run any of these files if you feel uncomfortable doing this.

---

## Instructions

1. Search Windows for UAC and press "Enter". Then set it to "Never Notify" in the window that pops up

![1](https://github.com/user-attachments/assets/abc024a2-56e2-453d-98c1-4132a3834d91)
![11](https://github.com/user-attachments/assets/06067543-e2e2-4af4-b8b2-b478aa6cf26d)



3. Search windows for powershell, right click "windows powershell" and open as administrator

![2](https://github.com/user-attachments/assets/3aa83167-ccaa-46ff-aa67-d9be9bc9142a)



4. Copy and paste the following into powershell, then press enter: `Set-ExecutionPolicy Unrestricted`  . After pressing enter, press 'A' and press enter again

![3](https://github.com/user-attachments/assets/822e1cae-71ac-4950-b93b-fa145003d918)



5. Search windows for virus & threat protection, press enter or click "virus & threat detection"

![4](https://github.com/user-attachments/assets/3d35c2b2-f2ad-45b7-8f8c-c87b3bb8e2f8)



6. Click "manage settings" under virus & threat detection settings

![5](https://github.com/user-attachments/assets/e69fd0f1-6cf0-450c-824f-76c8587e9b9f)



7. Turn everything off

![6](https://github.com/user-attachments/assets/490f4390-7c3b-4736-b66a-1652412d198b)



8. Download [Yap Bot Installer](https://github.com/fosterbarnes/Twitch-Yap-Bot-Installer/releases/download/v2.1/Yap.Bot.Installer.v2.1.exe) and run it, follow the on screen instructions that pop up when running through the installer. These instructions are also included below.

   You'll probably have to click "more info" then "run anyway" when you run the installer.
   
   Once it's installed, launch Yap Bot from the desktop shortcut or start menu before streaming. It will quit automatically when OBS or Streamlabs OBS is closed.

   To uninstall, download and run [this](https://github.com/fosterbarnes/Twitch-Yap-Bot-Installer/releases/download/v2.1/Uninstall.Yap.Bot.exe)

---

## On Screen Instructions

Before the install starts:
1. Open powershell as administrator (search windows for
powershell, right click > run as administrator)
2. Type the following command then press enter:
```
Set-ExecutionPolicy Unrestricted
```
This is because the setup helper scripts in this installer
require admin priveleges to function properly

---

The next window will be a Python installer.If you don't follow
the next three steps Yap Bot will not work.
1. On the 'Install Python 3.12.1' page click 'Use admin
priveleges when installing py.exe'
2. Click 'Add python.exe to PATH'
3. Click 'Install Now' and finish installing

---

1. Click OK to generate a OAuth Password for your Twitch bot
account. Make sure to login with your bot's Twitch account
you'd use with something like Mixitup, not your main
account.
2. After logging in, copy the password that is generated.
3. Close the browser window and paste the OAuth password
into the next window that pops up.

---

In the next window, you'll be prompted to enter more info
about your Twitch bot account as well as configure some
options for the Yap Bot. Denied users are users that Yap Bot will not read or store chat messages from.

---

If you don't do these next steps, Twitch Yap Bot won't work.
1. Right click the new 'Twitch Yap Bot' shortcut on your
desktop
2. Click Properties
3. Select 'Shortcut' from the menu on top
4. Click 'Advanced'
5. Click 'Run as administrator'
6. Click 'OK'

---

Last step I PROMISE
1. Run 'Twitch Yap Bot' from your desktop shortcut then 'Press any key to continue... when prompted. This sets up a few files in the backend.
2. Run 'Twitch Yap Bot' one more time, this time it should be up and running!
All done! Use '!yap' (or any other command you defined earlier) in your chat to test it out
Clicking OK on this window will show an image of what yap bot should look like if it's running properly.

![7](https://github.com/user-attachments/assets/81ec5c82-1ef5-47e9-9ea9-c5ce73771e98)
