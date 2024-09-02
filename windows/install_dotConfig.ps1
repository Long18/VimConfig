# Util function for output
function Write-Start {
    param($msg)
    Write-Host (">> " + $msg) -ForegroundColor Green; Write-Host
}

function Write-Done {
    Write-Host ("Done!") -ForegroundColor Blue; Write-Host
}

# Configure dotfiles
Write-Start -msg "Installing winfetch..."
$ConfigPath = "$env:USERPROFILE\.config"
if (-not (Test-Path $ConfigPath)) {
    New-Item -Path $ConfigPath -ItemType Directory -Force
}
Copy-Item -Path "..\.config\*" -Destination $ConfigPath -Force -Recurse
Write-Done

# Configure vim for vscode
Write-Start -msg "Installing vim for vscode..."
$DestinationPath = "$env:USERPROFILE\.vimrc"
if (-not (Test-Path $DestinationPath)) {
    New-Item -Path $DestinationPath -ItemType Directory -Force
}
Copy-Item -Path "..\.config\vim\" -Destination $DestinationPath -Force
Write-Done