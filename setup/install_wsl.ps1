# Util function for output
function Write-Start {
    param($msg)
    Write-Host (">> " + $msg) -ForegroundColor Green; Write-Host
}

function Write-Done {
    Write-Host ("Done!") -ForegroundColor Blue; Write-Host
}

Write-Start -msg "Installing WSL..."
If (!(wsl -l -v)) {
    wsl --install
    wsl --update
    wsl --install --no-launch --web-download -d Ubuntu
}
else {
    Write-Warning "WSL is already installed."
}
Write-Done