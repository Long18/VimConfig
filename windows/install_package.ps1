# Util function for output
function Write-Start {
    param($msg)
    Write-Host (">> " + $msg) -ForegroundColor Green; Write-Host
}

function Write-Done {
    Write-Host ("Done!") -ForegroundColor Blue; Write-Host
}

Write-Start -msg "Installing Scoop..."
if (Get-Command scoop -ErrorAction SilentlyContinue) {
    Write-Warning "Scoop is already installed."
}
else {
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run remote script the first time
    Invoke-RestMethod get.scoop.sh | Invoke-Expression
}
Write-Done


# Install packages
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
scoop install main/fzf
scoop install main/clink
scoop install main/neovim
scoop install main/oh-my-posh

scoop install extras/fork
scoop install extras/sharex
scoop install extras/powertoys
scoop install extras/flow-launcher
scoop install extras/windowsdesktop-runtime

# Font
scoop install nerd-fonts/JetBrainsMono-NF 
scoop install nerd-fonts/JetBrains-Mono 

# All-in-one repackage for lastes Microsoft Visual C++ Redistributable Runtime
scoop install extras/vcredist-aio

# Auto suggestion in Powershell
Install-Module PSReadLine
Install-Module -Name PSReadLine -AllowPrerelease -Force -SkipPublisherCheck

Write-Done
