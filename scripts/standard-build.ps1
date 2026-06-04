# Install Chocolatey (package manager for Windows)
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Install standard business software
choco install googlechrome -y
choco install firefox -y
choco install zoom -y
choco install slack -y
choco install 7zip -y
choco install adobereader -y
choco install libreoffice-fresh -y

# Remove Windows bloatware
Get-AppxPackage *xbox* | Remove-AppxPackage
Get-AppxPackage *solitaire* | Remove-AppxPackage
Get-AppxPackage *skype* | Remove-AppxPackage
Get-AppxPackage *bingweather* | Remove-AppxPackage
Get-AppxPackage *bingnews* | Remove-AppxPackage
Get-AppxPackage *spotify* | Remove-AppxPackage
Get-AppxPackage *clipchamp* | Remove-AppxPackage

# Disable unnecessary startup programs
# These vary by machine but common ones include:
Get-CimInstance Win32_StartupCommand | Format-Table Name, Command

# Set default browser (Chrome)
# Note: Windows 11 makes this difficult to automate, would typically be done through Group Policy

Write-Host "====================================" -ForegroundColor Green
Write-Host "Standard build configuration complete." -ForegroundColor Green
Write-Host "====================================" -ForegroundColor Green
Read-Host "Press Enter to close"
