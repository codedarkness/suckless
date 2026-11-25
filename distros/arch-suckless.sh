#!/usr/bin/env bash
#  ____             _                         ____          _
# |  _ \  __ _ _ __| | ___ __   ___  ___ ___ / ___|___   __| | ___
# | | | |/ _' | '__| |/ / '_ \ / _ \/ __/ __| |   / _ \ / _' |/ _ \
# | |_| | (_| | |  |   <| | | |  __/\__ \__ \ |__| (_) | (_| |  __/
# |____/ \__,_|_|  |_|\_\_| |_|\___||___/___/\____\___/ \__,_|\___|
# -----------------------------------------------------------------
# https://darkncesscode.xyz
# https://github.com/codedarkness
# -----------------------------------------------------------------
#
#        FILE: arch-suckless.sh
#       USAGE: ./arch-suckless.sh
#
# DESCRIPTION: Post installation script to rise a Arch Linux system
#
#      AUTHOR: DarknessCode
#       EMAIL: achim@darknesscode.xyz
#
#     CREATED: 09-09-23
#
# -----------------------------------------------------------------

set -euo pipefail

_user="$USER"

## Colors
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
END="\e[0m"

clear
echo -e "${BLUE}DarknessCode${END}"
echo "                   _     _      _                   "
echo "    /\            | |   | |    (_)                  "
echo "   /  \   _ __ ___| |__ | |     _ _ __  _   ___  __ "
echo "  / /\ \ | '__/ __| '_ \| |    | | '_ \| | | \ \/ / "
echo " / ____ \| | | (__| | | | |____| | | | | |_| |>  <  "
echo "/_/    \_\_|  \___|_| |_|______|_|_| |_|\__,_/_/\_\ "
echo -e "${YELLOW}The installation will start soon!!!${END} $_user"
sleep 5

## Update Arch Linux
sudo pacman -Syu --noconfirm --needed

## Software
declare -A software
## Liberies & Utilities
software[alsa-utils]="alsa-utils"
software[arandr]="arandr"
software[curl]="curl"
software[dunst]="dunst"
software[gcc]="gcc"
software[git]="git"
software[i3lock]="i3lock"
software[imagemagick]="imagemagick"
software[libnotify]="libnotify"
software[libx11]="libx11"
software[libxft]="libxft"
software[libxinerama]="libxinerama"
software[lightdm]="lightdm"
software[lm_sensors]="lm_sensors"
#software[lxsession]="lxsession"
software[make]="make"
software[noto-fonts]="noto-fonts"
software[noto-fonts-emoji]="noto-fonts-emoji"
software[adobe-source-code-pro-fonts]="adobe-source-code-pro-fonts"
software[papirus-icon-theme]="papirus-icon-theme"
software[picom]="picom"
software[polkit]="polkit"
software[python-pip]="python-pip"
software[rsync]="rsync"
software[scrot]="scrot"
software[sshfs]="sshfs"
software[tlp]="tlp"
software[ttf-dejavu]="ttf-dejavu"
software[ueberzug]="ueberzug"
software[unzip]="unzip"
software[wget]="wget"
software[xarchiver]="xarchiver"
software[xorg-apps]="xorg-apps"
software[xorg-fonts-misc]="xorg-fonts-misc"
software[xorg-server]="xorg-server"
software[zip]="zip"
software[xdg-desktop-portal]="xdg-desktop-portal"

## TUIs & CLIs
software[alacritty]="alacritty"
software[amfora]="amfora"
software[btop]="btop"
software[fzf]="fzf"
software[htop]="htop"
software[hugo]="hugo"
software[mpv]="mpv"
software[neomutt]="neomutt"
software[neovim]="neovim"
software[ranger]="ranger"
software[transmission]="transmission-cli"
software[w3m]="w3m"
software[pass]="pass"
software[hsetroot]="hsetroot"
software[newsboat]="newsboat"

## GUIs
software[gimp]="gimp"
software[lxappearance]="lxappearance"
software[qutebrowser]="qutebrowser"
software[sxiv]="sxiv"
software[zathura-pdf-poppler]="zathura-pdf-poppler"
software[zathura]="zathura"

not_installed=()

for pkg in "${software[@]}"; do
    # Check if packages exists in oficial repos and install them
    if pacman -Sp "$pkg" &>/dev/null; then
        echo "${GREEN}Installing${END} $pkg"
        sudo pacman -S --noconfirm --needed "$pkg" &>/dev/null
        if [ $? -eq 0 ]; then
            echo "$pkg installed ${GREEN}successfully${END}"
        else
            echo "$pkg ${RED}faild during installtion${END}"
            not_installed+=("$pkg")
        fi
    else
        echo "$pkg ${RED}in not available in the repos${END}"
        not_installed+=("$pkg")
    fi
done

# Print final report
echo
echo "Final report"
echo "------------------------------"
echo

if [ ${#not_installed[@]} -ne 0 ]; then
    echo "The following packages were NOT installed : "
    for missed in "${not_installed[@]}"; do
        echo "${RED} - $missed${END}"
    done
else
    echo "All packages were installed ${GREEN}successfully!${END}"
fi

## Directories
declare -A directories
directories[Desktop]="$HOME/Desktop"
directories[Documents]="$HOME/Documents"
directories[Downloads]="$HOME/Downloads"
directories[Music]="$HOME/Music"
directories[Pictures]="$HOME/Pictures/Wallpapers"
directories[Videos]="$HOME/Videos"
directories[Templates]="$HOME/Templates"
directories[dwm]="$HOME/.dwm"

for dir in "${directories[@]}"; do
    if [ ! -d "$dir" ]; then
        echo -e "${GREEN}Creating directory${END} : $dir"
        mkdir -p "$dir"
    else
        echo -e "${RED}Directory already exist${END} : $dir"
    fi
done

## Checking xsession directory
echo
[ ! -d "/usr/share/xsessions" ] && sudo mkdir -p /usr/share/xsessions && echo echo -e "${GREEN}xsessions${END} Directoy vas created" || echo -e "${RED}xsessions${END} already exist..."
echo

## Git Repos
getsuckless="https://github.com/codedarkness/suckless.git"
getdracula="https://github.com/dracula/gtk.git"
getminigreeter="https://github.com/prikhi/lightdm-mini-greeter.git"

[ ! -d "suckless" ] && git clone $getsuckless $HOME/Templates/suckless || echo -e "${RED}Git repo already exist...${END}"

[ ! -d "gtk" ] && git clone $getdracula $HOME/Templates/gtk && sudo mv $HOME/Templates/gtk /usr/share/themes/Dracula || echo -e "${RED}LinuxSucks..........${END}"

[ ! -d "minigreeter" ] && git clone $getminigreeter $HOME/Templates/minigreeter && cd $HOME/Templates/minigreeter && ./autogen.sh && ./configure --datadir=/usr/share --bindir=/usr/bin --sysconfdir=/etc && make && sudo make install && sudo rm -r $HOME/Templates/minigreeter || echo -e "${RED}Git repo already exist...${END}"

echo

## Config files & Directories
declare -A files
files[autostart]="$HOME/Templates/suckless/configs/autostart.sh $HOME/.dwm/"
files[autostart_blocking]="$HOME/Templates/suckless/configs/autostart_blocking.sh $HOME/.dwm/"
files[bash_profile]="$HOME/Templates/suckless/configs/bash_profile $HOME/.bash_profile"
files[bashrc]="$HOME/Templates/suckless/configs/bashrc $HOME/.bashrc"
files[gtkrc]="$HOME/Templates/suckless/configs/gtkrc-2.0 $HOME/.gtkrc-2.0"
files[sysact]="$HOME/Templates/suckless/configs/sysact $HOME/.dwm/"
files[wall]="$HOME/Templates/suckless/configs/hsetroot/wall.png $HOME/Pictures/Wallpapers/"
files[wallpapers]="$HOME/Templates/suckless/configs/wallpapers $HOME/.config/"
files[xresources]="$HOME/Templates/suckless/configs/Xresources $HOME/.Xresources"

for file in "${files[@]}"; do
    cp -f $file && echo -e "${GREEN} $file copied" || echo -e "${RED}LinuxSucks..........${END}"
done

echo

declare -A conf_directories
conf_directories[nmcli]="$HOME/Templates/suckless/configs/nmcli $HOME/.dwm/"
conf_directories[alacritty]="$HOME/Templates/suckless/configs/alacritty $HOME/.config"
conf_directories[amfora]="$HOME/Templates/suckless/configs/amfora $HOME/.config"
conf_directories[arigram]="$HOME/Templates/suckless/configs/arigram $HOME/.config"
conf_directories[castero]="$HOME/Templates/suckless/configs/castero $HOME/.config"
conf_directories[dunst]="$HOME/Templates/suckless/configs/dunst $HOME/.config"
conf_directories[gtk2]="$HOME/Templates/suckless/configs/gtk-2.0 $HOME/.config"
conf_directories[gtk3]="$HOME/Templates/suckless/configs/gtk-3.0 $HOME/.config"
conf_directories[mpv]="$HOME/Templates/suckless/configs/mpv $HOME/.config"
conf_directories[musikcube]="$HOME/Templates/suckless/configs/musikcube $HOME/.config"
conf_directories[nvim]="$HOME/Templates/suckless/configs/nvim $HOME/.config"
conf_directories[picom]="$HOME/Templates/suckless/configs/picom $HOME/.config"
conf_directories[pyradio]="$HOME/Templates/suckless/configs/pyradio $HOME/.config"
conf_directories[qutebrowser]="$HOME/Templates/suckless/configs/qutebrowser $HOME/.config"
conf_directories[ranger]="$HOME/Templates/suckless/configs/ranger $HOME/.config"
conf_directories[zathura]="$HOME/Templates/suckless/configs/zathura $HOME/.config"
conf_directories[hsetroot]="$HOME/Templates/suckless/configs/hsetroot $HOME/.config"

for cdirectory in "${conf_directories[@]}"; do
    cp -r $cdirectory && echo -e "${GREEN}$cdirectory${END} copied" || echo -e "${RED}LinuxSucks..........${END}"
done

echo

declare -A su_files
su_files[dwm-desktop]="$HOME/Templates/suckless/configs/dwm.desktop /usr/share/xsessions/dwm.desktop"
su_files[blurlock]="$HOME/Templates/suckless/configs/blurlock /usr/bin/"
su_files[dc-scrot]="$HOME/Templates/suckless/configs/dc-scrot /usr/bin/"
su_files[lightdm-mini]="$HOME/Templates/suckless/configs/lightdm-mini-greeter.conf /etc/lightdm/"

for sfile in "${su_files[@]}"; do
    sudo cp $sfile && echo -e "${GREEN}$sfile${END} copied" || echo -e "${RED}LinuxSucks..........${END}"
done

echo

## Suckless (dwm, dmenu, slstatus, st)
declare -A suckless
suckless[dmenu]="$HOME/Templates/suckless/suckless/dmenu"
suckless[dwm]="$HOME/Templates/suckless/suckless/dwm"
suckless[slstatus]="$HOME/Templates/suckless/suckless/slstatus"
suckless[st]="$HOME/Templates/suckless/suckless/st"

for suck in ${suckless[@]}; do
    cd $suck && sudo make clean install || echo -e "${RED}LinuxSucks..........${END}"
done

echo

## Setup Lighdm and greeter
sudo sed -i 's/user = CHANGE_ME/user = '$_user'/g' /etc/lightdm/lightdm-mini-greeter.conf &&
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-mini-greeter/g' /etc/lightdm/lightdm.conf &&
sudo sed -i 's/#user-session=default/user-session=dwm/g' /etc/lightdm/lightdm.conf &&
sudo chmod +x /usr/bin/blurlock &&
sudo chmod +x /usr/bin/dc-scrot &&
sudo systemctl enable lightdm -f &&
rm $HOME/arch-suckless.sh &&
rm $HOME/suckless-linux.sh &&
echo -e "${GREEN}Setup is done!!${END}" || echo -e "${RED}LinuxSucks..........${END}"
echo ""
