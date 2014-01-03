#!/bin/bash
#
#  Sarwo Hadi Setyana <sh.setyana@gmail.com>
#  http://sarwo.hadi.setyana.net
#  
# -------------------------------------------------------------------------
# This bash script based on
# Windows Batch File "install.bat" from rootkitXperia(L).zip
# http://forum.xda-developers.com/showthread.php?t=2591290
# 
# Tested on:
#  - openSUSE 12.3 64 bit
#  - Xperia L C1025
#  - 4.2.2
#  - 15.3.A.1.12
# -------------------------------------------------------------------------

echo "  __  __                _           __             _   _    _ _   ";
echo "  \ \/ /_ __   ___ _ __(_) __ _    /__\ ___   ___ | |_| | _(_) |_ ";
echo "   \  /| '_ \ / _ \ '__| |/ _\` |  / \/// _ \ / _ \| __| |/ / | __|";
echo "   /  \| |_) |  __/ |  | | (_| | / _  \ (_) | (_) | |_|   <| | |_ ";
echo "  /_/\_\ .__/ \___|_|  |_|\__,_| \/ \_/\___/ \___/ \__|_|\_\_|\__|";
echo "       |_|                                                        ";

echo "---------------------------- For Linux ----------------------------"
echo

echo "Please make sure:"
echo " - You have adb drivers for your phone."
echo " - Enable USB Debugging."
echo " - Enable Unknown sources."
echo " - Connect your phone to PC/Laptop using USB cable"
echo 
echo "-------------------------------------------------------------------"


chmod u+x adb_linux
echo
echo "Waiting for device..."

./adb_linux wait-for-device
./adb_linux push rootkitXperia\(L\)/files/getroot /data/local/tmp/
./adb_linux push rootkitXperia\(L\)/files/su /data/local/tmp/
./adb_linux push rootkitXperia\(L\)/files/Superuser.apk /data/local/tmp/
./adb_linux push rootkitXperia\(L\)/files/busybox /data/local/tmp/
./adb_linux push rootkitXperia\(L\)/files/00stop_ric /data/local/tmp/
./adb_linux push rootkitXperia\(L\)/files/install_tool.sh /data/local/tmp/
./adb_linux shell "chmod 0755 /data/local/tmp/getroot"
./adb_linux shell "chmod 0755 /data/local/tmp/busybox"
./adb_linux shell "chmod 0755 /data/local/tmp/install_tool.sh"

echo
echo "getroot start..."
./adb_linux shell "/data/local/tmp/getroot /data/local/tmp/install_tool.sh"
echo
echo "Removing temporary files..."
./adb_linux shell "rm /data/local/tmp/getroot"
./adb_linux shell "rm /data/local/tmp/su"
./adb_linux shell "rm /data/local/tmp/Superuser.apk"
./adb_linux shell "rm /data/local/tmp/busybox"
./adb_linux shell "rm /data/local/tmp/00stop_ric"
./adb_linux shell "rm /data/local/tmp/install_tool.sh"

echo
echo "Rebooting..."
./adb_linux reboot
echo "Waiting for device..."
./adb_linux wait-for-device
echo
echo "--- All finished ---"
