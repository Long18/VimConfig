#!/bin/bash

echo "Welcome to the Linux setup menu!"
echo "Please select an option:"
echo "a. Install Everything"
echo "1. Install Packages"
echo "2. Install Tools"
echo "3. Install Dot Files"
echo "q. Quit"

echo -n "Enter your choice: "
read -n 1 -r choice
echo ""

case "$choice" in
a | A)
    echo "Installing Everything..."
    ./linux/install_packages.sh
    # ./linux/install_tools.sh
    # ./linux/install_dot_files.sh
    ;;
1)
    echo "Installing Packages..."
    ./linux/install_packages.sh
    ;;
2)
    echo "Installing Tools..."
    # ./linux/install_tools.sh
    ;;
3)
    echo "Installing Dot Files..."
    # ./linux/install_dot_files.sh
    ;;
q | Q)
    echo "Exiting..."
    exit 0
    ;;
*)
    echo "Invalid choice. Exiting..."
    exit 1
    ;;
esac
