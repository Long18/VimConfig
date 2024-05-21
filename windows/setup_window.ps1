
#   _       __ _  __ __ _                 
#  | |     / /(_)/ // /(_)____ _ ____ ___ 
#  | | /| / // // // // // __ `// __ `__ \
#  | |/ |/ // // // // // /_/ // / / / / /
#  |__/|__//_//_//_//_/ \__,_//_/ /_/ /_/ 
#                                         
# https://github.com/Long18

# Run this command if no execution policy error:
# Check and set execution policy if necessary
$executionPolicy = Get-ExecutionPolicy
if ($executionPolicy -ne 'RemoteSigned' -and $executionPolicy -ne 'Unrestricted' -and $executionPolicy -ne 'Bypass') {
    try {
        Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
        $executionPolicy = Get-ExecutionPolicy
        if ($executionPolicy -ne 'RemoteSigned' -and $executionPolicy -ne 'Unrestricted' -and $executionPolicy -ne 'Bypass') {
            Write-Host "Execution policy could not be set. Please manually set it to 'RemoteSigned', 'Unrestricted', or 'Bypass' and run the script again." -ForegroundColor Red
            exit
        }
    }
    catch {
        Write-Host "Failed to set execution policy. Please run PowerShell as an administrator and set the execution policy to 'RemoteSigned', 'Unrestricted', or 'Bypass'." -ForegroundColor Red
        exit
    }
}

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
. "$PSScriptRoot\setup_menu.ps1"