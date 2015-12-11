TARGET_IP_ADDR=192.168.178.50
USERNAME=root

ssh ${USERNAME}@${TARGET_IP_ADDR} "mkdir -p /home/root/photobooth"
scp -r photobooth-scripts/* ${USERNAME}@${TARGET_IP_ADDR}:photobooth/
scp -r html/* ${USERNAME}@${TARGET_IP_ADDR}:/www/pages/

