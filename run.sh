#!/bin/bash
if [[ "$OSTYPE" == "msys" ]]; then
    pwsh ./windows/setup_window.ps1
else
    echo 'Processing for Linux'
    # TODO: Add your Linux processing logic here
fi
