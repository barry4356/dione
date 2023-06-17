# Source Main Config File
CONFIG_FILE="/home/dione/scripts/config.sh"
source ${CONFIG_FILE}

# Report Disk Usage and CPU Temps
echo "$(date)"
echo "Checking Disk Usage..."
df -BG
echo "----------------------"
echo "Checking CPU Temps..." 
bash ${ROOT_DIR}/check_temp.sh 
echo "----------------------" 
