PRIMARY_DIRECTORY="/media/usb_mount/Photos"
BACKUP_DIRECTORY="/media/usb_mount/Backup"
LOGFILE="/media/usb_mount/Backup/log.txt"
RAW_PRIMARY_DIR="${PRIMARY_DIRECTORY}/Raw"
RAW_DAILY_DIR="${RAW_PRIMARY_DIR}/$(date +'%d%B%Y')"

echo "$(date)" &>> ${LOGFILE}
echo "Checking ${RAW_PRIMARY_DIR} For New Files..." &>> ${LOGFILE}
for file in $(find ${RAW_PRIMARY_DIR} -maxdepth 1 -type f); do
  echo "Moving [$file] to [${RAW_DAILY_DIR}]..." &>> ${LOGFILE}
  mkdir -p ${RAW_DAILY_DIR}
  mv $file ${RAW_DAILY_DIR}/.
done
echo "Sync-ing [${PRIMARY_DIRECTORY}] with [${BACKUP_DIRECTORY}]" &>> ${LOGFILE}
rsync -rv ${PRIMARY_DIRECTORY} ${BACKUP_DIRECTORY} --log-file=${LOGFILE}
echo "" &>> ${LOGFILE}
