# Setup Config Variables
LOGFILE="/home/dione/log_$(date +'%m%d%Y').txt"
GIT_REPO="/home/dione/git/dione"

# Write System Status to Log
echo "$(date)" &>> ${LOGFILE}
echo "Checking Disk Usage..." &>> ${LOGFILE}
df -h &>> ${LOGFILE}
echo "----------------------" &>> ${LOGFILE}
echo "Checking CPU Temps..." &>> ${LOGFILE}
bash ${GIT_REPO}/check_temp.sh &>> ${LOGFILE} 
echo "----------------------" &>> ${LOGFILE}

# Setup Photo-Backup Config Variables
PHOTO_DIRECTORY="/mnt/primary_ext_drive/Photos"
BACKUP_DIRECTORY="/mnt/secondary_ext_drive/Backup"
RAW_PRIMARY_DIR="${PHOTO_DIRECTORY}/Raw"

# Organize Raw Photos
echo "Checking [${RAW_PRIMARY_DIR}] For New Files..." &>> ${LOGFILE}
for file in $(find ${RAW_PRIMARY_DIR} -maxdepth 1 -type f); do
  #TODO: Bug if the filename has a space in it...
  DIRNAME=$(date -r ${file} +'%B%Y')
  RAW_DATE_DIR="${RAW_PRIMARY_DIR}/$DIRNAME"
  echo "Moving [$file] to [${RAW_DATE_DIR}]..." &>> ${LOGFILE}
  mkdir -p ${RAW_DATE_DIR}
  # mv -S .orig -b $file ${RAW_DATE_DIR}/.
  cp --backup=t $file ${RAW_DATE_DIR}/. && rm $file
done

# Sync Photos to Backup
echo "Sync-ing [${PHOTO_DIRECTORY}] with [${BACKUP_DIRECTORY}]" &>> ${LOGFILE}
rsync -rv ${PHOTO_DIRECTORY} ${BACKUP_DIRECTORY} --log-file=${LOGFILE}

# Sync PC Backup to Secondary Drive
PC_BACKUP_DIR="/mnt/primary_ext_drive/PCBackup"
echo "Sync-ing [${PC_BACKUP_DIR}] with [${BACKUP_DIRECTORY}]" &>> ${LOGFILE}
rsync -rv ${PC_BACKUP_DIR} ${BACKUP_DIRECTORY} --log-file=${LOGFILE}

# Check Disk Usage
echo "Checking Disk Usage..." &>> ${LOGFILE}
df -h &>> ${LOGFILE}
echo "----------------------" &>> ${LOGFILE}
echo "" &>> ${LOGFILE}

# Send Logfile to Git
pushd $GIT_REPO &> /dev/null
git checkout logging
cp $LOGFILE logs/.
cat $LOGFILE >> logs/log.txt
git add logs/*
git commit -m "$(date +'%d%B%Y'): Added logs"
git push
git checkout main
popd &> /dev/null
