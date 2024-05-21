
#   _       __ _  __ __ _                 
#  | |     / /(_)/ // /(_)____ _ ____ ___ 
#  | | /| / // // // // // __ `// __ `__ \
#  | |/ |/ // // // // // /_/ // / / / / /
#  |__/|__//_//_//_//_/ \__,_//_/ /_/ /_/ 
#                                         
# https://github.com/Long18

# Run this command if no execution policy error:
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Util function for output
function Write-Start {
    param($msg)
    Write-Host (">> " + $msg) -ForegroundColor Green; Write-Host
}

function Write-Done {
    Write-Host ("Done!") -ForegroundColor Blue; Write-Host
}

# Start
Start-Process -Wait powershell -Verb runas -ArgumentList @"
    Set-ItemPropety -Path 
    REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System 
    -Name ConsentPromptBehaviorAdmin -Value 0
"@

# Install Packages
. "$PSScriptRoot\setup\install_package.ps1"

# Install Tool
. "$PSScriptRoot\setup\install_tools.ps1"

# Install Dot Config
. "$PSScriptRoot\setup\install_dotConfig.ps1"

# Install Virtualization
. "$PSScriptRoot\setup\install_virtualization.ps1"

# Install WSL
. "$PSScriptRoot\setup\install_wsl.ps1"

# Setup Wallpapers
. "$PSScriptRoot\setup\setup_wallpapers.ps1"