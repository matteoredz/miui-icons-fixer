#!/system/bin/sh
mount -o rw,remount /system
if [ $? == 0 ]
then echo Mounted RW system
else exit
fi
# copy all files to destination directory
cp -f /sdcard/miui_mod_icons/* /system/media/theme/miui_mod_icons
if [ $? == 0 ]
then echo Icons successfully moved to theme directory
else
        echo Cannot move icons to destination. Restore RO system
        mount -o ro,remount /system
        exit
fi
# set correct permission to icons
chmod 644 /system/media/theme/miui_mod_icons/*
if [ $? == 0 ]
then echo Setting 644 permissions
else
        echo Set permission aborted. Restore RO system
        mount -o ro,remount /system
        exit
fi
# Mount RO system
mount -o ro,remount /system
if [ $? == 0 ]
then echo Completed. Please reapply your theme
else
        echo Error reverting RO system
        exit
fi
exit
