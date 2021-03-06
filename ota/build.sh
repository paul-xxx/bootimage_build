#!/bin/bash
#changebefore
OSFLD=$mm
#changebefore
echo ""
echo "BPaul OTA repack script"
echo ""
if [ -e tmp ]
then
rm -rf tmp
fi
cd custom
if [ -e custom-hikari-mra58k-$(date -u +%Y%m%d).zip ]
then
echo "Removing old OTA package 'hikari-mra58k-$(date -u +%Y%m%d).zip'"
rm custom-hikari-mra58k-$(date -u +%Y%m%d).zip
fi
cd ../
echo ""
echo "Unpacking..."
echo ""
mkdir tmp
cd tmp
cp ../../$OSFLD/out/target/product/hikari/aosp_hikari-ota-eng.paul.zip tmp.zip
7z x tmp.zip
rm tmp.zip
rm boot.img
mkdir ktmp
cd ktmp
cp ../../../$OSFLD/out/target/product/hikari/ramdisk.img ramdisk.cpio.gz
cp ../../../$OSFLD/out/target/product/hikari/kernel zImage
cp ../../../$OSFLD/device/sony/hikari/prebuilt/RPM.bin RPM.bin
echo ""
echo "Making new Kernel..."
echo ""
python ../../mkelf.py -o ../boot.img zImage@0x40208000 ramdisk.cpio.gz@0x41500000,ramdisk RPM.bin@0x20000,rpm
cd ../
echo ""
echo "Adding recovery..."
echo ""
rm META-INF/com/google/android/updater-script
cp ../fota/recovery.img recovery.img
cp ../fota/updater-script META-INF/com/google/android/updater-script
rm -rf ktmp
echo ""
echo "Repacking Now!..."
echo ""
zip -r ../custom-hikari-mra58k-$(date -u +%Y%m%d).zip *
cd ../
rm -rf tmp
if [ -o custom ]
then
mkdir custom
else
echo ""
echo "Has releases folder, contune..."
echo ""
fi
mv custom-hikari-mra58k-$(date -u +%Y%m%d).zip custom/custom-hikari-mra58k-$(date -u +%Y%m%d).zip
echo ""
echo "New package 'custom-hikari-mra58k-$(date -u +%Y%m%d).zip' created..."
echo ""
echo "Done :)"
echo ""
echo "Press any key for rm -rf /*"
read && exit
