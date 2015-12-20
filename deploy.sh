TARGET_IP_ADDR=192.168.1.50
USERNAME=libipho

scp -r libipho-scripts/* ${USERNAME}@${TARGET_IP_ADDR}:libipho/
scp -r html/* ${USERNAME}@${TARGET_IP_ADDR}:www/

