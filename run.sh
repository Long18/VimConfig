#!/bin/bash
if [[ "$OSTYPE" == "msys" ]]; then
    pwsh ./windows/setup_window.ps1
else
    ./linux/setup_menu.sh
fi
