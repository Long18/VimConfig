#!/bin/bash

prompt_install() {
    echo -n "$1 is not installed. Would you like to install it? (y/n) " >&2
    old_stty_cfg=$(stty -g)
    stty raw -echo
    answer=$(while ! head -c 1 | grep -i '[ny]'; do true; done)
    stty $old_stty_cfg && echo
    if echo "$answer" | grep -iq "^y"; then
        if [ -x "$(command -v apt-get)" ]; then
            sudo apt-get install $1 -y
        elif [ -x "$(command -v brew)" ]; then
            brew install $1
        elif [ -x "$(command -v pacman)" ]; then
            sudo pacman -S $1
        else
            echo "Unknown package manager. Please install $1 manually and rerun this script."
        fi
    fi
}

check_for_software() {
    echo "Checking if $1 is installed..."
    if ! command -v $1 &>/dev/null; then
        prompt_install $1
    else
        echo "$1 is already installed."
    fi
}

check_default_shell() {
    if [[ "$SHELL" == *"zsh"* ]]; then
        echo "Default shell is zsh."
    else
        echo -n "Default shell is not zsh. Would you like to change it to zsh? (y/n) "
        old_stty_cfg=$(stty -g)
        stty raw -echo
        answer=$(while ! head -c 1 | grep -i '[ny]'; do true; done)
        stty $old_stty_cfg && echo
        if echo "$answer" | grep -iq "^y"; then
            chsh -s $(which zsh)
        else
            echo "Warning: The configuration might not work properly if zsh is not the default shell."
        fi
    fi
}

echo "This script will:"
echo "1. Check for the presence of zsh, vim, and tmux."
echo "2. Assist in installing them if they are missing."
echo "3. Verify if the default shell is zsh."
echo "4. Offer to change the default shell to zsh if it is not."

echo -n "Shall we proceed? (y/n) "
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$(while ! head -c 1 | grep -i '[ny]'; do true; done)
stty $old_stty_cfg
if ! echo "$answer" | grep -iq "^y"; then
    echo "Exiting. No changes made."
    exit 0
fi

echo
check_for_software zsh
check_for_software vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
check_for_software tmux
check_for_software curl
check_for_software wget
check_for_software git

ZSH_CUSTOM=~/.oh-my-zsh/custom

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install spaceship theme
if [ ! -d "${ZSH_CUSTOM}/themes/spaceship-prompt" ]; then
    echo "Installing spaceship theme..."
    git clone https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM}/themes/spaceship-prompt
    ln -s "${ZSH_CUSTOM}/themes/spaceship-prompt/spaceship.zsh-theme" ${ZSH_CUSTOM}/themes/spaceship.zsh-theme
fi

# Install zsh-autosuggestions
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
fi

# Install zsh-syntax-highlighting
if [ ! -d "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
fi

check_default_shell

echo
echo "Please log out and log back in to apply the default shell change."
