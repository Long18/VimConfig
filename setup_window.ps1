
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

# Main Script
Start-Process -Wait powershell -Verb runas -ArgumentList @"
    Set-ItemProperty -Path 
    REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System 
    -Name ConsentPromptBehaviorAdmin -Value 0
"@

# Open menu
. "$PSScriptRoot\setup\setup_menu.ps1"