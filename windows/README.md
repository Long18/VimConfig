# Personal Configuration 

## Overview

This script automates the setup process for configuring a Windows environment with various utilities, tools, fonts, and configurations. It installs Scoop, a command-line installer for Windows, and then proceeds to install essential packages, utilities, fonts, and configure applications.

# Table of Contents

- [Personal Configuration](#personal-configuration)
  - [Overview](#overview)
  - [Pros](#pros)
  - [Usage](#usage)
    - [Package Managers](#package-managers)
    - [Personal Settings](#personal-settings)
  - [Commands](#commands)
  - [Note](#note)

## Pros

- Automates the setup process, saving time and effort.
- Installs commonly used utilities and tools for development and productivity.
- Configures applications for a personalized experience.

## Usage

### Package Managers

- [Chocolatey](https://community.chocolatey.org/packages)
- [Scoop](https://scoop.sh/#/apps)
- [npm](https://www.npmjs.com/package/package)
- [pip](https://pypi.org/)

### Personal Settings

#### Define Destination Path

```sh
    $DestinationPath = "$env:USERPROFILE\AppData\Local\.."
```

This path represents where the configuration files or settings will be copied.

#### Check Destination Path Existence

```powershell
    if (-not (Test-Path $DestinationPath)) {
        New-Item -ItemType Directory -Path $DestinationPath
    }
```

#### Copy Configuration Files

```powershell
    Copy-Item -Path .\* -Destination $DestinationPath -Force
```

Copy the configuration files or settings from their source location to the destination path. Use PowerShell's `Copy-Item` cmdlet for this task. If the configuration files include sub-folders, ensure to include the `-Recurse` parameter to copy all files recursively.

#### Additional Configuration Steps

After copying the files, additional configuration steps may be required. For example, if configuring Vim, you might want to install a plugin manager like `vim-plug`. In this case, you can use PowerShell's `Invoke-WebRequest` (`iwr`) to download the plugin manager script and then place it in the appropriate directory.

```powershell
Invoke-WebRequest -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim | `
    New-Item "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force

```

After downloading the plugin manager script, you can execute Vim with specific arguments to install and update plugins:

```powershell
nvim -E -s -u "$($env:USERPROFILE)\AppData\Local\nvim\init.vim" +PlugInstall +PlugUpdate +q
```

## Commands

- **Set-ExecutionPolicy**: Sets the execution policy to allow the script to run.
- **Start-Process**: Starts PowerShell with administrator privileges.
- **Write-Start**: Utility function to display a message indicating the start of a task.
- **Write-Done**: Utility function to display a message indicating the completion of a task.
- **New-Item**: Creates a new item (directory) if it doesn't exist.
- **Copy-Item**: Copies files and directories.
- **Enable-WindowsOptionalFeature**: Enables Windows optional features such as Windows Subsystem for Linux (WSL) and Virtual Machine Platform.
- **...**


## Note

- Ensure that you have PowerShell installed and running with administrator privileges.
- Review the script and make any necessary adjustments before executing.
- Some configurations or installations might require additional permissions or manual intervention.
