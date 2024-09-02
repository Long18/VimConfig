# Util function for output
function Write-Start {
    param($msg)
    Write-Host (">> " + $msg) -ForegroundColor Green; Write-Host
}

function Write-Done {
    Write-Host ("Done!") -ForegroundColor Blue; Write-Host
}

# Configure neovim
Write-Start -msg "Installing neovim..."
$DestinationPath = "$env:USERPROFILE\AppData\Local\nvim"
if (-not (Test-Path $DestinationPath)) {
    New-Item -Path $DestinationPath -ItemType Directory -Force
}
Copy-Item -Path "..\neovim\*" -Destination $DestinationPath -Force -Recurse
Invoke-WebRequest -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | `
    New-Item "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
nvim -E -s -u "$($env:USERPROFILE)\AppData\Local\nvim\init.vim" +PlugInstall +PlugUpdate +q
Write-Done

# Configure Oh-my-posh
Write-Start -msg "Configuring oh-my-posh..."
$ClinkPath = "$env:CLINK_DIR"
$PowershellPath = "$env:USERPROFILE\Documents\PowerShell"
if (-not (Test-Path $ClinkPath)) {
    New-Item -Path $ClinkPath -ItemType Directory -Force
}
if (-not (Test-Path $PowershellPath)) {
    New-Item -Path $PowershellPath -ItemType Directory -Force
}
Copy-Item -Path "..\terminals\oh-my-posh.lua" -Destination $ClinkPath -Force
Copy-Item -Path "..\terminals\Microsoft.PowerShell_profile.ps1" -Destination $PowershellPath -Force
Write-Done

# Configure Vscode
## In my case, I have settings synced with GitHub so I don't need to do anything
# code --install-extension vscodevim.vim
# Write-Done