if [ ! -f /etc/ipsec.d/cert8.db ] ; then
   echo > /var/tmp/libreswan-nss-pwd
   certutil -N -f /var/tmp/libreswan-nss-pwd -d /etc/ipsec.d
   # SElinux only
   # restorecon /etc/ipsec.d/*db 2>/dev/null || :
   rm /var/tmp/libreswan-nss-pwd
fi
