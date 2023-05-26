# Setup Config Variables
PHOTO_DIRECTORY="/media/usb_mount/Photos"
BACKUP_DIRECTORY="/media/usb_mount/Backup"
LOGFILE="/media/usb_mount/Backup/log.txt"
RAW_PRIMARY_DIR="${PHOTO_DIRECTORY}/Raw"

# Organize Raw Photos
echo "$(date)" &>> ${LOGFILE}
echo "Checking Disk Usage..." &>> ${LOGFILE}
df -h &>> ${LOGFILE}
echo "----------------------" &>> ${LOGFILE}
echo "Checking [${RAW_PRIMARY_DIR}] For New Files..." &>> ${LOGFILE}
for file in $(find ${RAW_PRIMARY_DIR} -maxdepth 1 -type f); do
  #TODO: Bug if the filename has a space in it...
  DIRNAME=$(date -r ${file} +'%B%Y')
  RAW_DATE_DIR="${RAW_PRIMARY_DIR}/$DIRNAME"
  echo "Moving [$file] to [${RAW_DATE_DIR}]..." &>> ${LOGFILE}
  mkdir -p ${RAW_DATE_DIR}
  cp --backup=t $file ${RAW_DATE_DIR}/. && rm $file
done

# Sync Photos to Backup
echo "Sync-ing [${PHOTO_DIRECTORY}] with [${BACKUP_DIRECTORY}]" &>> ${LOGFILE}
rsync -rv ${PHOTO_DIRECTORY} ${BACKUP_DIRECTORY} --log-file=${LOGFILE}
echo "Checking Disk Usage..." &>> ${LOGFILE}
df -h &>> ${LOGFILE}
echo "----------------------" &>> ${LOGFILE}
echo "" &>> ${LOGFILE}
