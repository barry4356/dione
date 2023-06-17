# Source Main Config File
CONFIG_FILE="/home/dione/scripts/config.sh"
source ${CONFIG_FILE}

# Set additional config vars
PHOTO_DIRECTORY="/mnt/primary_ext_drive/Photos"
BACKUP_DIRECTORY="/mnt/secondary_ext_drive/Backup"
PC_BACKUP_DIR="/mnt/primary_ext_drive/PCBackup"
ANDROID_BACKUP_DIR="/mnt/primary_ext_drive/AndroidBackup"

echo "" &>> ${LOGFILE}

# Write System Status to Log
${ROOT_DIR}/check_status.sh &>> ${LOGFILE}

# Sync Photos to Backup
echo "Sync-ing [${PHOTO_DIRECTORY}] with [${BACKUP_DIRECTORY}]" &>> ${LOGFILE}
#rsync -rv --update ${PHOTO_DIRECTORY} ${BACKUP_DIRECTORY} --log-file=${LOGFILE}

# Sync PC Backup to Secondary Drive
echo "Sync-ing [${PC_BACKUP_DIR}] with [${BACKUP_DIRECTORY}]" &>> ${LOGFILE}
rsync -rv --update ${PC_BACKUP_DIR} ${BACKUP_DIRECTORY} --log-file=${LOGFILE}

# Sync Android Backup to Secondary Drive
echo "Sync-ing [${ANDROID_BACKUP_DIR}] with [${BACKUP_DIRECTORY}]" &>> ${LOGFILE}
rsync -rv --update ${ANDROID_BACKUP_DIR} ${BACKUP_DIRECTORY} --log-file=${LOGFILE}

# Write System Status to Log
${ROOT_DIR}/check_status.sh &>> ${LOGFILE}

# Send Logfile to Git
pushd $LOG_REPO &> /dev/null
git checkout logging
cp $LOGFILE logs/.
cat $LOGFILE >> logs/log.txt
git add logs/*
git commit -m "$(date +'%d%B%Y'): Added logs"
git push
popd &> /dev/null
