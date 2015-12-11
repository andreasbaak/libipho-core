set TARGET_IP_ADDR=192.168.1.50

pscp -r photobooth-scripts/ ubuntu@%TARGET_IP_ADDR%:photobooth/
pscp -r html/ ubuntu@%TARGET_IP_ADDR%:/var/www/html/
REM show empty screen
pscp photobooth-scripts/screen_template.html ubuntu@%TARGET_IP_ADDR%:/var/www/html/screen.html
pause
