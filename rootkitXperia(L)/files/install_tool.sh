#!/system/bin/sh

RICTYPE=0

if [ -e /sys/kernel/security/sony_ric/enable ]; then
	RICTYPE=3
elif [ -e /sbin/ric ]; then
	/data/local/tmp/busybox pkill /sbin/ric
	mount -o remount,rw /
	rm /sbin/ric
	mount -o remount,ro /
	/data/local/tmp/busybox pkill /sbin/ric
	RICTYPE=2
elif [ -e /system/bin/ric ]; then
	/system/bin/stop ric
	RICTYPE=1
fi

mount -o remount,rw /system

if [ -e /system/bin/su ]; then
	rm /system/bin/su
fi
if [ -e /system/xbin/su ]; then
	rm /system/xbin/su
fi
dd if=/data/local/tmp/su of=/system/xbin/su
chown root.root /system/xbin/su
chmod 06755 /system/xbin/su
ln -s /system/xbin/su /system/bin/su

dd if=/data/local/tmp/Superuser.apk of=/system/app/Superuser.apk
chown root.root /system/app/Superuser.apk
chmod 0644 /system/app/Superuser.apk

dd if=/data/local/tmp/busybox of=/system/xbin/busybox
chown root.shell /system/xbin/busybox
chmod 0755 /system/xbin/busybox
/system/xbin/busybox --install -s /system/xbin

if [ $RICTYPE -gt 0 ]; then
	if [ ! -e /system/etc/init.d ]; then
		/system/bin/mkdir /system/etc/init.d
	fi
	/system/bin/chown root.root /system/etc/init.d
	/system/bin/chmod 0755 /system/etc/init.d
	if [ -e /system/etc/hw_config.sh ]; then
		if grep "/system/xbin/busybox run-parts /system/etc/init.d" /system/etc/hw_config.sh > /dev/null; then
			:
		else
			echo "/system/xbin/busybox run-parts /system/etc/init.d" >> /system/etc/hw_config.sh
		fi
	elif [ -e /system/etc/init.qcom.post_boot.sh ]; then
		if grep "/system/xbin/busybox run-parts /system/etc/init.d" /system/etc/init.qcom.post_boot.sh > /dev/null; then
			:
		else
			echo "/system/xbin/busybox run-parts /system/etc/init.d" >> /system/etc/init.qcom.post_boot.sh
		fi
	fi
fi

case $RICTYPE in
1)
	echo "#!/system/bin/sh" > /system/etc/init.d/00stop_ric
	echo "" >> /system/etc/init.d/00stop_ric
	echo "/system/bin/stop ric" >> /system/etc/init.d/00stop_ric
	chown root.root /system/etc/init.d/00stop_ric
	chmod 0755 /system/etc/init.d/00stop_ric
	;;
2)
	dd if=/data/local/tmp/00stop_ric of=/system/etc/init.d/00stop_ric
	chown root.root /system/etc/init.d/00stop_ric
	chmod 0755 /system/etc/init.d/00stop_ric
	;;
3)
	echo "#!/system/bin/sh" > /system/etc/init.d/00stop_ric
	echo "" >> /system/etc/init.d/00stop_ric
	echo "echo 0 > /sys/kernel/security/sony_ric/enable" >> /system/etc/init.d/00stop_ric
	chown root.root /system/etc/init.d/00stop_ric
	chmod 0755 /system/etc/init.d/00stop_ric
	;;
esac

mount -o remount,ro /system
