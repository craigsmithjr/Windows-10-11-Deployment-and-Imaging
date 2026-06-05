# Windows-10-11-Deployment-and-Imaging

Created a standardized Windows 11 enterprise image in VMware and deployed it to a domain-joined environment. Built a local Active Directory domain using Windows Server 2025, configured networking between the DC and client, automated software installation using PowerShell and Chocolatey, and used Sysprep to generalize the image for mass deployment.

## Tools Used
- VMware Workstation
- Windows Server 2025 (Evaluation)
- Windows 11 Enterprise (Evaluation)
- Active Directory Domain Services
- DNS
- Sysprep
- PowerShell
- Chocolatey (Package Manager)

## Step 1: Setting Up the Domain Controller

Created a Windows Server 2025 Domain Controller in VMware 
to provide Active Directory and DNS services for the lab 
environment. The DC setup follows the same process documented 
in my [Azure AD Home Lab](https://github.com/craigsmithjr/azure-ad-homelab) 
project, adapted for a local VMware environment instead of Azure.
<img width="1034" height="792" alt="image" src="https://github.com/user-attachments/assets/12322801-3621-4fcf-bd1a-8a2aeb82e653" />

## Step 2: Creating the Client virtual machine

Created a new VM in VMWare with 4 GB of RAM and a 50 GB virtual hard disk. Mounted the Windows 11 Enterprise evaluation ISO downloaded from Microsoft's Evaluation Center and completed a standard installation.
<img width="930" height="870" alt="image" src="https://github.com/user-attachments/assets/8d9fda2a-5f68-4717-94e7-393b9989d86a" />
<img width="1022" height="758" alt="image" src="https://github.com/user-attachments/assets/e8e8e21f-6af1-443b-b0e4-009c96098cf2" />

## Step 3: Configuring the Standard Company Build

After installation, configured the machine to match what a corporate IT department would deliver to a new employee. To ensure consistency and repeatability across deployments, I automated the software installation and bloatware removal using a PowerShell script with Chocolatey as the package manager.
The script handles:
- Installing Chocolatey (a Windows package manager used for automated software deployment)
- Installing standard business software: Google Chrome, Mozilla Firefox, Zoom, Slack, 7-Zip, Adobe Reader, and LibreOffice( Used LibreOffice as a stand-in for Microsoft 365 Apps in this lab environment. In a production setting, Microsoft 365 would typically be deployed through Microsoft Intune or SCCM after the machine is domain-joined and the user is licensed through the M365 admin center)
- Removing pre-installed Windows bloatware (Xbox, Solitaire, Spotify, Clipchamp, etc.)
- Disabling unnecessary startup programs to improve boot times
<img width="1025" height="745" alt="image" src="https://github.com/user-attachments/assets/e64a375e-aafd-46a5-809f-d41b8d60b7a7" />
Using a script instead of manual installation ensures every machine deployed from this image has the exact same software and configuration, which reduces inconsistencies and saves time when onboarding multiple employees.


The full script can be found in the [scripts/standard-build.ps1](scripts/standard-build.ps1) file in this repository.
After running the script, I manually completed the remaining configuration:
- Set the computer name to a standardized naming convention (e.g., WS-001)
- Set Chrome as the default browser
<img width="1050" height="338" alt="image" src="https://github.com/user-attachments/assets/4d659d15-8632-4961-9798-9320820cbf2c" />

- Pinned frequently used applications to the taskbar
- Configured desktop layout for a clean, professional workspace
<img width="1365" height="927" alt="image" src="https://github.com/user-attachments/assets/8b5b97f2-6fc5-40f6-b76a-f6998b4cc51f" />

## Step 4 Configuring the Network
Configured static IP addresses on both VMs so they could communicate on the same LAN segment.

Domain Controller:
- IP: 10.0.0.1
- Subnet: 255.255.255.0
- Preferred DNS: 127.0.0.1 (itself)

Windows 11 Client:
- IP: 10.0.0.10
- Subnet: 255.255.255.0
- Preferred DNS: 10.0.0.1 (pointing to the DC)

Verified connectivity by pinging the DC from the client.
<img width="949" height="600" alt="image" src="https://github.com/user-attachments/assets/5cabc0cf-1693-48d4-903c-e094d549a674" />
<img width="987" height="620" alt="image" src="https://github.com/user-attachments/assets/46ad3fa2-1287-4116-a6f2-bfcf4eed000e" />

## Step 5: Configuring Security Settings

Applied baseline security configurations that would be standard in a corporate environment:

- Verified Windows Defender is active and up to date
- Confirmed Windows Firewall is enabled for all network profiles
- Disabled Remote Desktop (would be enabled per-user through Group Policy in a real environment)
- Set the account lockout policy to lock after 5 failed login attempts
- Configured the power plan to "Balanced" to prevent machines from sleeping during business hours

## Step 6: Joining the Client to the Domain

Joined the Windows 11 client to the domain by navigating to System > Domain or workgroup > Change, selecting Domain, and entering the domain name. Authenticated with the Domain Admin credentials and received the "Welcome to the domain" confirmation. After restarting, the machine appeared in Active Directory Users and Computers under the Computers container.

This step connects the imaging project to real-world domain management. Once a machine is domain-joined, Group Policy applies automatically and users can log in with their domain credentials.
<img width="791" height="622" alt="image" src="https://github.com/user-attachments/assets/ccac4c15-7229-40ba-b187-956b123fa743" />

## Step 8: Running Sysprep to Generalize the Image

Before running Sysprep, removed the machine from the domain and switched back to a workgroup since Sysprep requires the machine to not be domain-joined.

Ran Sysprep to prepare the machine for deployment. Sysprep removes all hardware-specific and user-specific information so the image can be deployed to any machine without conflicts.

Opened Command Prompt as administrator and ran:
C:\Windows\System32\Sysprep\sysprep.exe

Selected the following options:
- System Cleanup Action: Enter System Out-of-Box Experience (OOBE)
- Generalize: Checked
- Shutdown Options: Shutdown

After Sysprep completed, the machine shut down automatically. At this point, the image is ready to be captured and deployed to other machines.
<img width="1336" height="796" alt="image" src="https://github.com/user-attachments/assets/6e775647-2562-4fc4-b2ba-22a76764214b" />




