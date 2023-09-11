# Suckless (Post Install)

From Suckless.org "Software with a focus on simplicity, clarity, and frugality".

## Installation

This installation is a start point for build my system when I need to install or re-install one of my computers.

This script must be run only in a fresh minimal install. Based on the distro: 

- Arch Linux

```
curl -LO https://darknesscode.xyz/arch-suckless.sh
sudo chmod +x arch-suckless.sh
./arch-suckless.sh
```

- Debian

```
curl -LO https://darknesscode.xyz/debian-suckless.sh
sudo chmod +x debian-suckless.sh
./debian-suckless.sh
```

- openSUSE

```
curl -LO https://darknesscode.xyz/opensuse-suckless.sh
sudo chmod +x opensue-suckless.sh
./opensuse-suckless.sh
```

- Void Linux

```
curl -LO https://darknesscode.xyz/void-suckless.sh
sudo chmod +x void-suckless.sh
./void-suckless.sh
```

## To Be Install

- DMW
    * dwm is a dynamic window manager for X. It manages windows in tiled, monocle and floating layouts. All of the layouts can be applied dynamically, optimising the environment for the application in use and the task performed.
- SLSTATUS
    * slstatus is a status monitor for window managers that use WM_NAME or stdin to fill the status bar.
- DMENU
    * dmenu is a dynamic menu for X, originally designed for dwm. It manages large numbers of user-defined menu items efficiently.
- ST
    * st is a simple terminal implementation for X.
- More Software
    * Inclued a list of software that I usualy install (libreries, CLIs, TUIs, GUIs)

## Patches

- DWM
    * attachaside - master always in the left
    * autostart - programs when log in
    * center - center windows in toggle mode
    * colorbar - change foreground and background color of every status bar
    * restartsig - restart dwm without exit current session
    * rotatestack - moves a client form the bottom to the top of the stack
    * status2d - allows color in the status bar
    * uselessgas - add gaps between windows
- DMENU
    * center - centers dmenu in the middle of the screen
    * border - adds a border around the dmenu window
    * mouse support - dmenu will have basic mouse support
    * numbers - add text which pisplays the number of matched and total items
    * lines below pront - vertical list starts at the same horizontal line that the prompt is drawn
    * line height - sets the minimum height of dmenu line
- ST (Simple Terminal)
    * [st](https://github.com/LukeSmithxyz/st) From Luke Smith repo.
- SLSTATUS
    * No patches applied

## Keybindings

There is only a few keybindings you need to add yours in config.h

| Keybinding  | Action                      |
| :---------- | :-------------------------- |
| MOD+Enter   | Open terminal (altracritty) |
| ALT+Enter   | Open terminal (st)          |
| MOD+r       | Ranger File Manager         |
| MOD+v       | Vim                         |
| MOD+o       | dmenu_run                   |
| MOD+0       | System account              |
| MOD+q       | Close program               |
| MOD+Shift+q | Close session               |
| MOD+F11     | NetworkManger dmenu         |
| MOD+F12     | Lock screen                 |

# Note

Use this script on your own risk. Don't just run any script that you find over the internet!!!

Check and read the script then do all the changes you like bofore you run it
