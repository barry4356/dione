# Setup Config Variables
PRIMARY_DIRECTORY="/media/usb_mount/Photos"
BACKUP_DIRECTORY="/media/usb_mount/Backup"
LOGFILE="/media/usb_mount/Backup/log.txt"
RAW_PRIMARY_DIR="${PRIMARY_DIRECTORY}/Raw"

# Organize Raw Photos
echo "$(date)" &>> ${LOGFILE}
echo "Checking ${RAW_PRIMARY_DIR} For New Files..." &>> ${LOGFILE}
for file in $(find ${RAW_PRIMARY_DIR} -maxdepth 1 -type f); do
  DIRNAME=$(date -r ${file} +'%B%Y')
  RAW_DATE_DIR="${RAW_PRIMARY_DIR}/$DIRNAME"
  echo "Moving [$file] to [${RAW_DATE_DIR}]..." &>> ${LOGFILE}
  mkdir -p ${RAW_DATE_DIR}
  cp --backup=t $file ${RAW_DATE_DIR}/.
  rm $file
done

# Sync to Backup
echo "Sync-ing [${PRIMARY_DIRECTORY}] with [${BACKUP_DIRECTORY}]" &>> ${LOGFILE}
rsync -rv ${PRIMARY_DIRECTORY} ${BACKUP_DIRECTORY} --log-file=${LOGFILE}
echo "" &>> ${LOGFILE}
