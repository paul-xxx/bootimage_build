#!/bin/bash
echo "Making ramdisk's"
cd ramdisk
find . | cpio -o -H newc | gzip > ../ramdisk.cpio.gz
cd ../
echo "Making kernel.elf"
python ../mkelf.py -o kernel.elf zImage@0x40208000 ramdisk.cpio.gz@0x41500000,ramdisk RPM.bin@0x20000,rpm
echo "Cleanup"
mv kernel.elf ../hikari_boot.img
rm ramdisk.cpio.gz
