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
#        FILE: void-suckless.sh
#       USAGE: ./void-suckless.sh
#
# DESCRIPTION: Post installation script to rise a Void Linux system
#
#      AUTHOR: DarknessCode
#       EMAIL: achim@darknesscode.xyz
#
#     CREATED: 09-04-23
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
echo "__      __   _     _ _      _                   "
echo "\ \    / /  (_)   | | |    (_)                  "
echo " \ \  / /__  _  __| | |     _ _ __  _   ___  __ "
echo "  \ \/ / _ \| |/ _' | |    | | '_ \| | | \ \/ / "
echo "   \  / (_) | | (_| | |____| | | | | |_| |>  <  "
echo "    \/ \___/|_|\__,_|______|_|_| |_|\__,_/_/\_\ "
echo -e "${YELLOW}The installation will start soon!!!${END} $_user"
sleep 5

## Update Void Linux
sudo xbps-install -Syu

## Software
declare -A software
## Liberies & Utilities
software[alsa-utils]="alsa-utils"
software[arandr]="arandr"
software[curl]="curl"
software[dunst]="dunst"
software[fuse-sshfs]="fuse-sshfs"
software[gcc]="gcc"
software[git]="git"
software[gtk-engine-murrine]="gtk-engine-murrine"
software[harfbuzz-devel]="harfbuzz-devel"
software[i3lock]="i3lock"
software[ImageMagick]="ImageMagick"
software[intltool]="intltool"
software[libX11-devel]="libX11-devel"
software[libXft-devel]="libXft-devel"
software[libXinerama-devel]="libXinerama-devel"
software[libnotify-devel]="libnotify-devel"
software[libnotify]="libnotify"
software[libxfce4ui-devel]="libxfce4ui-devel"
software[lightdm-mini-greeter]="lightdm-mini-greeter"
software[lightdm]="lightdm"
software[lm_sensors]="lm_sensors"
software[lxsession]="lxsession"
software[make]="make"
software[NetworkManager]="NetworkManager"
software[papirus-icon-theme]="papirus-icon-theme"
software[picom]="picom"
software[pkg-config]="pkg-config"
software[polkit]="polkit"
software[python3-pip]="python3-pip"
software[rsync]="rsync"
software[scrot]="scrot"
software[tlp]="tlp"
software[udevil]="udevil"
software[unzip]="unzip"
software[upower-devel]="upower-devel"
software[wget]="wget"
software[xarchiver]="xarchiver"
software[xautolock]="xautolock"
software[xorg-fonts]="xorg-fonts"
software[xorg]="xorg"
software[zip]="zip"
## TUIs & CLIs
software[alacritty]="alacritty"
software[amfora]="amfora"
software[btop]="btop"
software[castero]="castero"
software[fzf]="fzf"
software[htop]="htop"
software[hugo]="hugo"
software[mpv]="mpv"
software[musikcube]="musikcube"
software[neofetch]="neofetch"
software[neomutt]="neomutt"
software[neovim]="neovim"
software[pyradio]="pyradio"
software[ranger]="ranger"
software[transmission]="transmission"
software[w3m-img]="w3m-img"
software[w3m]="w3m"
## GUIs
software[calibre]="calibre"
software[gimp]="gimp"
software[libreoffice]="libreoffice"
software[lxappearance]="lxappearance"
software[nitrogen]="nitrogen"
software[qutebrowser]="qutebrowser"
software[sxiv]="sxiv"
software[xfce4-power-manager]="xfce4-power-manager"
software[zathura-pdf-poppler]="zathura-pdf-poppler"
software[zathura]="zathura"

sudo xbps-install -Sy "${software[@]}" && echo -e "${GREEN}Success.....${END}" || echo -e "${RED}LinuxSucks..........${END}"

## Directories
declare -A directories
directories[Desktop]="$HOME/Desktop"
directories[Documents]="$HOME/Documents"
directories[Downloads]="$HOME/Downloads"
directories[Music]="$HOME/Music"
directories[Pictures]="$HOME/Pictures/Wallpapers"
directories[Templates]="$HOME/Templates"
directories[Videos]="$HOME/Videos"
directories[dwm]="$HOME/.dwm"
directories[nitrogen]="$HOME/.config/nitrogen"

for directory in ${directories[@]}; do
    [ ! -d "$directory" ] && mkdir -p "$directory" && echo -e "${GREEN}$directory${END} Directoy vas created" || echo "${RED}$directory${END} already exist..."
done

## xsession directory not present in void linux
[ ! -d "/usr/share/xsessions" ] && sudo mkdir -p /usr/share/xsessions && echo -e "${GREEN}xsessions${END} Directoy vas created" || echo "${RED}xsessions${END} already exist..."

## Git Repos
getsuckless="https://github.com/codedarkness/suckless.git"
getdracula="https://github.com/dracula/gtk.git"
getarigram="https://github.com/TruncatedDinosour/arigram.git"

[ ! -d "suckless" ] && git clone $getsuckless $HOME/Templates/suckless || echo -e "${RED}Git repo already exist...${END}"

[ ! -d "gtk" ] && git clone $getdracula $HOME/Templates/gtk && sudo mv $HOME/Templates/gtk /usr/share/themes/Dracula || echo -e "${RED}LinuxSucks..........${END}"

[ ! -d "arigram" ] && git clone $getarigram $HOME/Templates/arigram && cd $HOME/Templates/arigram && ./do local &&  sudo rm -r $HOME/Templates/arigram || echo -e "${RED}Git repo already exist...${END}"

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
conf_directories[ranger]="$HOME/Templates/suckless/configs/ranger $HOME/.config"
conf_directories[zathura]="$HOME/Templates/suckless/configs/zathura $HOME/.config"

for cdirectory in "${conf_directories[@]}"; do
    cp -r $cdirectory && echo -e "${GREEN} $cdirectory ${END}copied" || echo -e "${RED}LinuxSucks..........${END}"
done

declare -A su_files
su_files[blurlock]="$HOME/Templates/suckless/configs/blurlock /usr/bin/"
su_files[dc-scrot]="$HOME/Templates/suckless/configs/dc-scrot /usr/bin/"
su_files[dwm-desktop]="$HOME/Templates/suckless/configs/dwm.desktop /usr/share/xsessions/dwm.desktop"
su_files[lightdm-mini]="$HOME/Templates/suckless/configs/lightdm-mini-greeter.conf /etc/lightdm/"

for sfile in "${su_files[@]}"; do
    sudo cp $sfile && echo -e "${GREEN} $sfile ${END}copied" || echo -e "${RED}LinuxSucks..........${END}"
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
echo -e "${GREEN}Setup is done!!${END}" || echo -e "${RED}LinuxSucks..........${END}"
echo ""

echo "##### NOTE #####"
echo -e "${RED}If lightdm is enable now, you need to login into your account"
echo -e "then you need to reboot the system inside the session"
echo -e "If you don't enabled lightdm now you need to enabled it manualy${END}"
echo -e "[y = yes] - [n = no] - [r = reboot]"

while true; do
	read -p "Enable lightdm or Reboot [y - n - r] : " yn
	case $yn in
		[Yy]* )
			#sudo ln -s /etc/sv/NetworkManager /var/service/NetworkManager
			sudo ln -s /etc/sv/dbus /var/service/dbus
			sudo ln -s /etc/sv/lightdm /var/service/lightdm; exit ;;
		[Nn]* )
			echo -e "${RED}Don't forget to enable lightdm after reboot${END}"; break ;;
		[Rr]* )
			sudo reboot; exit ;;
		*)	echo "Please answer yes or no."
	esac
done
