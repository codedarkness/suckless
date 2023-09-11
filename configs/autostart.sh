#!/bin/bash
#  ____             _                         ____          _
# |  _ \  __ _ _ __| | ___ __   ___  ___ ___ / ___|___   __| | ___
# | | | |/ _` | '__| |/ / '_ \ / _ \/ __/ __| |   / _ \ / _` |/ _ \
# | |_| | (_| | |  |   <| | | |  __/\__ \__ \ |__| (_) | (_| |  __/
# |____/ \__,_|_|  |_|\_\_| |_|\___||___/___/\____\___/ \__,_|\___|
# -----------------------------------------------------------------
# https://darkncesscode.com
# https://github.com/codedarkness
# -----------------------------------------------------------------
#
#        FILE: autostart.sh
#       USAGE: .dwm/autostart.sh
#
# DESCRIPTION: autostart file for dwm
#
#      AUTHOR: DarknessCode
#       EMAIL: admin@darknesscode.com
#
#     CREATED: 05-05-2020 04:12
#
# -----------------------------------------------------------------

slstatus &
nitrogen --restore &
xfce4-power-manager &
xautolock -time 10 -locker blurlock &
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
