# Source Main Config File
CONFIG_FILE="/home/dione/scripts/config.sh"
source ${CONFIG_FILE}

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
