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
software[gtk-engine-murrine]="gtk-engine-murrine"
software[i3lock]="i3lock"
software[imagemagick]="imagemagick"
software[libnotify]="libnotify"
software[libx11]="libx11"
software[libxft]="libxft"
software[libxinerama]="libxinerama"
software[lightdm]="lightdm"
software[lm_sensors]="lm_sensors"
software[lxsession]="lxsession"
software[make]="make"
software[noto-fonts]="noto-fonts"
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
software[xautolock]="xautolock"
software[xorg-apps]="xorg-apps"
software[xorg-fonts-misc]="xorg-fonts-misc"
software[xorg-server]="xorg-server"
software[zip]="zip"
## TUIs & CLIs
software[alacritty]="alacritty"
software[amfora]="amfora"
software[btop]="btop"
software[fzf]="fzf"
software[htop]="htop"
software[hugo]="hugo"
software[mpv]="mpv"
software[neofetch]="neofetch"
software[neomutt]="neomutt"
software[neovim]="neovim"
software[ranger]="ranger"
software[transmission]="transmission-cli"
software[w3m]="w3m"
## GUIs
software[calibre]="calibre"
software[gimp]="gimp"
software[libreoffice-fresh]="libreoffice-fresh"
software[lxappearance]="lxappearance"
software[nitrogen]="nitrogen"
software[qutebrowser]="qutebrowser"
software[sxiv]="sxiv"
software[xfce4-power-manager]="xfce4-power-manager"
software[zathura-pdf-poppler]="zathura-pdf-poppler"
software[zathura]="zathura"

sudo pacman -S --noconfirm --needed "${software[@]}" && echo -e "${GREEN}Success.....${END}" || echo -e "${RED}LinuxSucks..........${END}"

## Removing the annoying python warning for external python packages
[ -f "/usr/lib/python3.11/EXTERNALLY-MANAGED" ] && sudo mv /usr/lib/python3.11/EXTERNALLY-MANAGED /usr/lib/python3.11/EXTERNALLY-MANAGED_backup || echo -e "${GREEN}Externally-Managed no found... ${END}"

declare -A python_software
python_software[castero]="castero"
python_software[pyradio]="pyradio"
python_software[youtube-dl]="youtube_dl"
python_software[yt-dlp]="yt-dlp"

pip install "${python_software[@]}" && echo -e "${GREEN}Success.....${END}" || echo -e "${RED}LinuxSucks..........${END}"

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
directories[nitrogen]="$HOME/.config/nitrogen"

for directory in ${directories[@]}; do
    [ ! -d "$directory" ] && mkdir -p "$directory" && echo -e "${GREEN}$directory${END} Directoy vas created" || echo -e "${RED}$directory${END} already exist..."
done

## Checking xsession directory
[ ! -d "/usr/share/xsessions" ] && sudo mkdir -p /usr/share/xsessions && echo echo -e "${GREEN}xsessions${END} Directoy vas created" || echo -e "${RED}xsessions${END} already exist..."

## Git Repos
getsuckless="https://github.com/codedarkness/suckless.git"
getdracula="https://github.com/dracula/gtk.git"
getarigram="https://github.com/TruncatedDinosour/arigram.git"
getminigreeter="https://github.com/prikhi/lightdm-mini-greeter.git"

[ ! -d "suckless" ] && git clone $getsuckless $HOME/Templates/suckless || echo -e "${RED}Git repo already exist...${END}"

[ ! -d "gtk" ] && git clone $getdracula $HOME/Templates/gtk && sudo mv $HOME/Templates/gtk /usr/share/themes/Dracula || echo -e "${RED}LinuxSucks..........${END}"

[ ! -d "arigram" ] && git clone $getarigram $HOME/Templates/arigram && cd $HOME/Templates/arigram && ./do local && sudo rm -r $HOME/Templates/arigram || echo -e "${RED}Git repo already exist...${END}"

[ ! -d "minigreeter" ] && git clone $getminigreeter $HOME/Templates/minigreeter && cd $HOME/Templates/minigreeter && ./autogen.sh && ./configure --datadir=/usr/share --bindir=/usr/bin --sysconfdir=/etc && make && sudo make install && sudo rm -r $HOME/Templates/minigreeter || echo -e "${RED}Git repo already exist...${END}"

## Config files & Directories
declare -A files
files[autostart]="$HOME/Templates/suckless/configs/autostart.sh $HOME/.dwm/"
files[autostart_blocking]="$HOME/Templates/suckless/configs/autostart_blocking.sh $HOME/.dwm/"
files[bash_profile]="$HOME/Templates/suckless/configs/bash_profile $HOME/.bash_profile"
files[bashrc]="$HOME/Templates/suckless/configs/bashrc $HOME/.bashrc"
files[bs-saved-cfg]="$HOME/Templates/suckless/configs/nitrogen/bg-saved.cfg $HOME/.config/nitrogen/"
files[gtkrc]="$HOME/Templates/suckless/configs/gtkrc-2.0 $HOME/.gtkrc-2.0"
files[nitrogen-cfg]="$HOME/Templates/suckless/configs/nitrogen/nitrogen.cfg $HOME/.config/nitrogen/"
files[sysact]="$HOME/Templates/suckless/configs/sysact $HOME/.dwm/"
files[wall]="$HOME/Templates/suckless/configs/nitrogen/wall.png $HOME/Pictures/Wallpapers/"
files[xresources]="$HOME/Templates/suckless/configs/Xresources $HOME/.Xresources"

for file in "${files[@]}"; do
    cp $file && echo -e "${GREEN} $file copied" || echo -e "${RED}LinuxSucks..........${END}"
done

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

for cdirectory in "${conf_directories[@]}"; do
    cp -r $cdirectory && echo -e "${GREEN}$cdirectory${END} copied" || echo -e "${RED}LinuxSucks..........${END}"
done

declare -A su_files
su_files[dwm-desktop]="$HOME/Templates/suckless/configs/dwm.desktop /usr/share/xsessions/dwm.desktop"
su_files[blurlock]="$HOME/Templates/suckless/configs/blurlock /usr/bin/"
su_files[dc-scrot]="$HOME/Templates/suckless/configs/dc-scrot /usr/bin/"
su_files[lightdm-mini]="$HOME/Templates/suckless/configs/lightdm-mini-greeter.conf /etc/lightdm/"

for sfile in "${su_files[@]}"; do
    sudo cp $sfile && echo -e "${GREEN}$sfile${END} copied" || echo -e "${RED}LinuxSucks..........${END}"
done

## Suckless (dwm, dmenu, slstatus, st)
declare -A suckless
suckless[dmenu]="$HOME/Templates/suckless/suckless/dmenu"
suckless[dwm]="$HOME/Templates/suckless/suckless/dwm"
suckless[slstatus]="$HOME/Templates/suckless/suckless/slstatus"
suckless[st]="$HOME/Templates/suckless/suckless/st"

for suck in ${suckless[@]}; do
    cd $suck && sudo make clean install || echo -e "${RED}LinuxSucks..........${END}"
done

## Setup Lighdm and greeter and wallpaper
sed -i 's/USER/'$_user'/g' $HOME/.config/nitrogen/bg-saved.cfg &&
sed -i 's/USER/'$_user'/g' $HOME/.config/nitrogen/nitrogen.cfg &&
sudo sed -i 's/user = CHANGE_ME/user = '$_user'/g' /etc/lightdm/lightdm-mini-greeter.conf &&
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-mini-greeter/g' /etc/lightdm/lightdm.conf &&
sudo sed -i 's/#user-session=default/user-session=dwm/g' /etc/lightdm/lightdm.conf &&
sudo chmod +x /usr/bin/blurlock &&
sudo chmod +x /usr/bin/dc-scrot &&
python -m pip install --user --upgrade pynvim &&
sudo systemctl enable lightdm -f &&
sudo ln -s $HOME/.local/bin/arigram /usr/bin &&
sudo ln -s $HOME/.local/bin/castero /usr/bin &&
sudo ln -s $HOME/.local/bin/pyradio /usr/bin &&
sudo ln -s $HOME/.local/bin/yt-dlp /usr/bin &&
sudo ln -s $HOME/.local/bin/youtube_dl /usr/bin &&
rm $HOME/arch-suckless.sh &&
rm $HOME/suckless-linux.sh &&
echo -e "${GREEN}Setup is done!!${END}" || echo -e "${RED}LinuxSucks..........${END}"
echo ""
