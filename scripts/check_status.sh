# Report Disk Usage and CPU Temps
echo "$(date)"
echo "Checking Disk Usage..."
df -BG
echo "----------------------"
echo "Checking CPU Temps..." 
bash ${ROOT_DIR}/check_temp.sh 
echo "----------------------" 
