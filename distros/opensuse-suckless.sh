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
#        FILE: opensuse-suckless.sh
#       USAGE: ./opensuse-suckless.sh
#
# DESCRIPTION: Post installation script to rise a openSUSE system
#
#      AUTHOR: DarknessCode
#       EMAIL: achim@darknesscode.xyz
#
#     CREATED: 10-01-23 19:50
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
echo "                          _____ _    _  _____ ______  "
echo "                         / ____| |  | |/ ____|  ____| "
echo "   ___  _ __   ___ _ __ | (___ | |  | | (___ | |__    "
echo "  / _ \| '_ \ / _ \ '_ \ \___ \| |  | |\___ \|  __|   "
echo " | (_) | |_) |  __/ | | |____) | |__| |____) | |____  "
echo "  \___/| .__/ \___|_| |_|_____/ \____/|_____/|______| "
echo "       | |                                            "
echo "       |_|                                            "
echo -e "${YELLOW}The installation will start soon!!!${END} $_user"
sleep 5

## Update openSuse
sudo zypper --non-interactive refresh && sudo zypper --non-interactive update

## Software
declare -A software
### Liberies & Utilities
software[alsa-utils]="alsa-utils"
software[arandr]="arandr"
software[curl]="curl"
software[dunst]="dunst"
software[gcc]="gcc"
software[git]="git-core"
software[gtk2-engine-murrine]="gtk2-engine-murrine"
software[i3lock]="i3lock"
software[imagemagick]="ImageMagick"
software[libnotify]="libnotify-devel"
software[libx11]="libX11-6"
software[libxft]="libXft-devel"
software[libxinerama]="libXinerama-devel"
software[lightdm]="lightdm"
software[sensors]="sensors"
software[lxsession]="lxsession"
software[make]="make"
software[noto-fonts]="noto-fonts"
software[papirus-icon-theme]="papirus-icon-theme"
software[picom]="picom"
software[polkit]="polkit"
software[rsync]="rsync"
software[scrot]="scrot"
software[sshfs]="sshfs"
software[tlp]="tlp"
software[dejavu-fonts]="dejavu-fonts"
software[ueberzug]="ueberzugpp"
software[unzip]="unzip"
software[wget]="wget"
software[xautolock]="xautolock"
software[xorg-x11-server]="xorg-x11-server"
software[zip]="zip"
software[harfbuzz]="harfbuzz-devel"
software[ncurses]="ncurses-devel"
software[automake]="automake"
software[pkg-config]="pkgconf-pkg-config"
software[gtk3]="gtk3-devel"
### TUIs & CLIs
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
software[transmission]="transmission"
software[w3m]="w3m"
### GUIs
software[calibre]="calibre"
software[gimp]="gimp"
software[libreoffice-fresh]="libreoffice"
software[lxappearance]="lxappearance"
software[nitrogen]="nitrogen"
software[qutebrowser]="qutebrowser"
software[sxiv]="sxiv"
software[xfce4-power-manager]="xfce4-power-manager"
software[zathura-pdf-poppler]="zathura-plugin-pdf-poppler"
software[zathura-cb]="zathura-plugin-cb"
software[zathura]="zathura"

sudo zypper --non-interactive install "${software[@]}" && echo -e "${GREEN}Success.....${END}" || echo -e "${RED}LinuxSucks..........${END}"

## Removing the annoying python warning for external python packages
[ -f "/usr/lib64/python3.11/EXTERNALLY-MANAGED" ] && sudo mv /usr/lib64/python3.11/EXTERNALLY-MANAGED /usr/lib64/python3.11/EXTERNALLY-MANAGED_backup || echo -e "${GREEN}Externally-Managed no found... ${END}"

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

## Git Repos
getsuckless="https://github.com/codedarkness/suckless.git"
getdracula="https://github.com/dracula/gtk.git"
getarigram="https://github.com/TruncatedDinosour/arigram.git"

[ ! -d "suckless" ] && git clone $getsuckless $HOME/Templates/suckless || echo -e "${RED}Git repo already exist...${END}"

[ ! -d "gtk" ] && git clone $getdracula $HOME/Templates/gtk && sudo mv $HOME/Templates/gtk /usr/share/themes/Dracula || echo -e "${RED}LinuxSucks..........${END}"

[ ! -d "arigram" ] && git clone $getarigram $HOME/Templates/arigram && cd $HOME/Templates/arigram && ./do local && sudo rm -r $HOME/Templates/arigram || echo -e "${RED}Git repo already exist...${END}"

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
su_files[lightdm]="$HOME/Templates/suckless/configs/lightdm.conf /etc/lightdm/"

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
sudo sed -i 's/#greeter-session=example-gtk-gnome/greeter-session=lightdm-gtk-greeter/g' /etc/lightdm/lightdm.conf &&
sudo sed -i 's/#user-session=default/user-session=dwm/g' /etc/lightdm/lightdm.conf &&
sudo sed -i 's/background=\/usr\/share\/wallpapers\/openSUSEdefault\/contents\/images\/1600x1200.jpg/background=#1E1F29/g' /etc/lightdm/lightdm-gtk-greeter.conf &&
sudo sed -i 's/theme-name=Greybird-geeko/theme-name=Dracula/g' /etc/lightdm/lightdm-gtk-greeter.conf &&
sudo chmod +x /usr/bin/blurlock &&
sudo chmod +x /usr/bin/dc-scrot &&
python3 -m pip install --user --upgrade pynvim &&
sudo systemctl set-default graphical.target &&
sudo ln -s $HOME/.local/bin/arigram /usr/bin &&
sudo ln -s $HOME/.local/bin/castero /usr/bin &&
sudo ln -s $HOME/.local/bin/pyradio /usr/bin &&
rm $HOME/opensuse-suckless.sh &&
rm $HOME/suckless-linux.sh &&
rm $HOME/bin &&
sudo zypper --non-interactive remove openbox &&
echo -e "${GREEN}Setup is done!!${END}" || echo -e "${RED}LinuxSucks..........${END}"
echo ""
