# Source Main Config File
CONFIG_FILE="/home/dione/scripts/config.sh"
source ${CONFIG_FILE}
echo "" &>> ${LOGFILE}

# Move each file into a directory based on change-time
for file in $(find ${RAW_PRIMARY_DIR} -maxdepth 1 -type f); do
  #TODO: Bug if the filename has a space in it... hopefully it never does
  DIRNAME=$(date -r ${file} +'%B%Y')
  RAW_DATE_DIR="${RAW_PRIMARY_DIR}/${DIRNAME}"
  echo "Moving [$file] to [${RAW_DATE_DIR}]..." &>> ${LOGFILE}
  mkdir -p ${RAW_DATE_DIR}
  mv -S .orig -b $file ${RAW_DATE_DIR}/.
done

# Export log to git repository
${ROOT_DIR}/export_log.sh
