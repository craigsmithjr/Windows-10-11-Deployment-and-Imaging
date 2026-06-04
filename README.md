# Windows-10-11-Deployment-and-Imaging
Created a standardized Windows 11 enterprise image in VirtualBox to simulate a corporate desktop deployment workflow. Configured business software, security settings, and user profiles, then used Sysprep to generalize the image for deployment. Documented the full process including a new hire onboarding checklist for IT teams.

## Tools Used
- Oracle VirtualBox
- Windows 11 Enterprise (Evaluation)
- Sysprep
- Windows Defender
- Windows Firewall

## Step 1: Creating the Virtual Machine in VirtualBox

Created a new VM in VirtualBox with 4 GB of RAM and a 50 GB virtual hard disk. Mounted the Windows 11 Enterprise evaluation ISO downloaded from Microsoft's Evaluation Center and completed a standard installation.
<img width="930" height="870" alt="image" src="https://github.com/user-attachments/assets/8d9fda2a-5f68-4717-94e7-393b9989d86a" />
<img width="1022" height="758" alt="image" src="https://github.com/user-attachments/assets/e8e8e21f-6af1-443b-b0e4-009c96098cf2" />

## Step 2: Configuring the Standard Company Build

After installation, configured the machine to match what a corporate IT department would deliver to a new employee. This included:

- Setting the computer name to a standardized naming convention (e.g., WS-001)
- Installing standard business software: Google Chrome, Mozilla Firefox, Zoom, Slack, 7-Zip, Adobe Reader, and LibreOffice
- Setting Chrome as the default browser
- Pinning frequently used applications to the taskbar
- Removing unnecessary pre-installed apps and disabling bloatware
- Disabling unnecessary startup programs to improve boot times
