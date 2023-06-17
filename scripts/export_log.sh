# Source Main Config File
CONFIG_FILE="/home/dione/scripts/config.sh"
source ${CONFIG_FILE}

# Send Logfile to Git
pushd $LOG_REPO &> /dev/null
git checkout logging
cp $LOGFILE logs/.
cat $LOGFILE >> logs/log.txt
git add logs/*
git commit -m "$(date +'%d%B%Y'): Added logs"
git push
popd &> /dev/null
