#!/bin/bash
cd hikari
. mk.sh
cd ../
echo "Flashing kernel.elf"
fastboot flash boot hikari_boot.img
fastboot reboot
read && exit
