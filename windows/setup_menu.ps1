
# Function to display menu
function Show-Menu {
    Write-Host "Welcome to the Setup Script!" -ForegroundColor Green
    Write-Host "Please choose an option to install:" -ForegroundColor Green
    Write-Host "a. Install Everything"
    Write-Host "1. Install Packages"
    Write-Host "2. Install Tools"
    Write-Host "3. Install Dot Config"
    Write-Host "4. Install Virtualization"
    Write-Host "5. Install WSL"
    Write-Host "6. Setup Wallpapers"
    Write-Host "q. Quit"
}

# Function to handle menu selection
function Update-Menu {
    param ($choice)

    switch ($choice) {
        '1' {
            Write-Start "Installing Packages..."
            . "$PSScriptRoot\install_package.ps1"
            Write-Done
        }
        '2' {
            Write-Start "Installing Tools..."
            . "$PSScriptRoot\install_tools.ps1"
            Write-Done
        }
        '3' {
            Write-Start "Installing Dot Config..."
            . "$PSScriptRoot\install_dotConfig.ps1"
            Write-Done
        }
        '4' {
            Write-Start "Installing Virtualization..."
            . "$PSScriptRoot\install_virtualization.ps1"
            Write-Done
        }
        '5' {
            Write-Start "Installing WSL..."
            . "$PSScriptRoot\install_wsl.ps1"
            Write-Done
        }
        '6' {
            Write-Start "Setting Up Wallpapers..."
            . "$PSScriptRoot\setup_wallpapers.ps1"
            Write-Done
        }
        'a' {
            Write-Start "Installing Everything..."
            . "$PSScriptRoot\install_package.ps1"
            . "$PSScriptRoot\install_tools.ps1"
            . "$PSScriptRoot\install_dotConfig.ps1"
            . "$PSScriptRoot\install_virtualization.ps1"
            . "$PSScriptRoot\install_wsl.ps1"
            . "$PSScriptRoot\setup_wallpapers.ps1"
            Write-Done
        }
        'q' {
            Write-Host "Quitting..." -ForegroundColor Red
            Write-Host "Thank you for using the setup script. Goodbye!" -ForegroundColor Red
            exit
        }
        default {
            Write-Host "Invalid option, please try again." -ForegroundColor Red
        }
    }
}

do {
    Show-Menu
    $choice = Read-Host "Enter your choice"
    Update-Menu $choice
} while ($choice -ne 'q')