# Twitch Yap Bot Installer

Beginner friendly windows installer for [TwitchMarkovChain](https://github.com/tomaarsen/TwitchMarkovChain)

I made this installer using InstallForge, and have included several powershell scripts to help automate the setup process. I am by no means an expert programmer, so all of these scripts require admin priveleges. For this reason, the installer and files included may be a false positive for Windows antivirus. All powershell scripts used are included [here](https://github.com/fosterbarnes/Twitch-Yap-Bot-Installer/tree/main/Installer%20Files) in case you want to look through them and see exactly what they do. This was created with Windows 10 in mind, this is not guarenteed to work on Windows 11.

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



8. Download [Yap Bot Installer](https://github.com/fosterbarnes/Twitch-Yap-Bot-Installer/releases/download/v2.0/Yap.Bot.Installer.v2.exe) and run it, follow the on screen instructions that pop up when running through the installer

You'll probably have to click "more info" then "run anyway" when you run the installer.
