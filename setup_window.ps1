
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
Start-Process -Wait powershell -Verb runas -ArgumentList "Set-ItemPropety -Path REGISTRY::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0"

Write-Start -msg "Installing Scoop..."
if (Get-Command scoop -ErrorAction SilentlyContinue) {
    Write-Warning "Scoop is already installed."
}
else {
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run remote script the first time
    irm get.scoop.sh | iex
}
Write-Done

Install packages
Write-Start -msg "Installing Scoop packages..."
scoop install git
scoop bucket add main
scoop bucket add extras
scoop bucket add nerd-fonts
scoop update
Write-Done

# Install utils packages
Write-Start -msg "Installing utils packages..."
# Browser
scoop install extras/googlechrome
scoop install extras/brave
scoop install extras/vscode
scoop install extras/spotify
    
# Tool
scoop install main/vim
scoop install main/clink
scoop install main/neovim
scoop install main/oh-my-posh

scoop install extras/fork
scoop install extras/sharex
scoop install extras/powertoys
scoop install extras/flow-launcher

# Font
scoop install nerrd-fonts/JetBrainsMono-NF 
scoop install nerrd-fonts/JetBrains-Mono 

# All-in-one repackage for lastes Microsoft Visual C++ Redistributable Runtime
scoop install extras/vcredist-aio
Write-Done

# Configure Vim
$DestinationPath = "$env:USERPROFILE\AppData\Local\nvim"
if (-not (Test-Path $DestinationPath)) {
    New-Item -Path $DestinationPath -ItemType Directory -Force
}
Copy-Item -Path ".\neovim\*" -Destination $DestinationPath -Force -Recurse
iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | `
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
nvim -E -s -u "$($env:USERPROFILE)\AppData\Local\nvim\init.vim" +PlugInstall +PlugUpdate +q
Write-Done

# Configure Oh-my-posh
Write-Start -msg "Configuring oh-my-posh..."
$ClinkPath = "$env:ProgramFiles (x86)\clink"
$PowershellPath = "$env:USERPROFILE\Documents\PowerShell"
if (-not (Test-Path $ClinkPath)) {
    New-Item -Path $ClinkPath -ItemType Directory -Force
}
if(-not (Test-Path $PowershellPath)) {
    New-Item -Path $PowershellPath -ItemType Directory -Force
}
Copy-Item -Path ".\terminal\oh-my-posh.lua" -Destination $ClinkPath -Force
Copy-Item -Path ".\terminal\Microsoft.PowerShell_profile.ps1" -Destination $PowershellPath -Force
Write-Done

# Configure Vscode
## In my case, I have settings synced with GitHub so I don't need to do anything
# code --install-extension vscodevim.vim
# Write-Done

# Configure Virtualization
Start-Process -Wait powershell -Verb runas -ArgumentList @"
    echo y | Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux -All -Norestart
    echo y | Enable-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform -All
"@
Write-Done

# Install WSL
Write-Start -msg "Installing WSL..."
If(!(wsl -l -v)){
    wsl --install
    wsl --update
    wsl --install --no-launch --web-download -d Ubuntu
}
else {
    Write-Warning "WSL is already installed."
}
Write-Done