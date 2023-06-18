# Source Main Config File
CONFIG_FILE="/home/dione/scripts/config.sh"
source ${CONFIG_FILE}
echo "" &>> ${LOGFILE}

SD_RAW_DIR="/mnt/SDCard/DCIM"

# Write System Status to Log
${ROOT_DIR}/check_status.sh &>> ${LOGFILE}

echo "Ingesting Image Files From [${SD_RAW_DIR}]"

# Ingest Raw Photos
echo "Checking [${SD_RAW_DIR}] For Image Files..." &>> ${LOGFILE}
for directory in $(find ${SD_RAW_DIR} -maxdepth 1 -mindepth 1 -type d); do
  SD_DIRECTORY=$directory
  echo "Ingesting Image Files From [${SD_DIRECTORY}]..." &>> ${LOGFILE}
  rsync -avt --update ${SD_DIRECTORY}/* ${RAW_PRIMARY_DIR} --log-file=${LOGFILE}
done

# Write System Status to Log
${ROOT_DIR}/check_status.sh &>> ${LOGFILE}

# Export log to git repository
${ROOT_DIR}/export_log.sh
