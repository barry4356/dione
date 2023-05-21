PRIMARY_DIRECTORY="/media/usb_mount/Photos"
BACKUP_DIRECTORY="/media/usb_mount/Backup"
LOGFILE="/media/usb_mount/Backup/log.txt"

rsync -rv ${PRIMARY_DIRECTORY} ${BACKUP_DIRECTORY} --log-file=${LOGFILE}
