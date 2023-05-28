
sudo groupadd smbshare
sudo umount /media/usb_mount 
sudo fdisk -l
sudo blkid
sudo mount /dev/sda1 /media/usb_mount/ -o dmask=000,fmask=111
sudo chgrp -R smbshare /media/usb_mount #FAILED to changer mount permissions... still worked ok though
sudo usermod -aG smbshare dione
sudo smbpasswd -e dione
sudo testparm # Test samba config
sudo systemctl restart nmbd # restart samba server
#sudo ufw allow from 192.168.205.0/24 to any app Samba # ufw firewall not enabled
smbclient '\\localhost\public' -U dione #Test samba
