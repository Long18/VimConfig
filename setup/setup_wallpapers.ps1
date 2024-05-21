# Util function for output
function Write-Start {
    param($msg)
    Write-Host (">> " + $msg) -ForegroundColor Green; Write-Host
}

function Write-Done {
    Write-Host ("Done!") -ForegroundColor Blue; Write-Host
}

# Ask user for confirmation
$confirmation = Read-Host "Do you want to setup wallpapers? (1 for Yes, 0 for No)"
if ($confirmation -ne "1") {
    Write-Host "Wallpaper setup aborted." -ForegroundColor Yellow
    exit
}

# Setup wallpaper
Write-Start -msg "Setting wallpaper..."
$WallpaperPath = "$env:USERPROFILE\Pictures\Wallpapers"
if (-not (Test-Path $WallpaperPath)) {
    New-Item -Path $WallpaperPath -ItemType Directory -Force
}
Copy-Item -Path ".\wallpapers\*" -Destination $WallpaperPath -Force -Recurse
Write-Done

