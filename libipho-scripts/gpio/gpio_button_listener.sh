#!/bin/bash
#
# This file is part of Libipho, an open source photobooth package.
# Libipho is free software: you can redistribute it and/or modify it
# under the terms of the GNU General Public License
# as published by the Free Software Foundation, version 2.
#
# This program is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
# FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
# details.
#
# Copyright (C) 2005 Andreas Baak (andreas.baak@gmail.com)
# License: http://www.gnu.org/licenses/gpl.html GPL version 2
#

source ${LIBIPHO_BASE}/libipho_env.sh

GALLERY_LIST=${HTML_DIR}/js/libipho-pictures.js

STATE0="NOT_PRESSED"
STATE1="PRESSED"

B0_STATE=${STATE0}
B1_STATE=${STATE0}

GPIO_PIN_0=/sys/class/gpio/gpio${GPIO_PIN_DELETE_LAST}/value # Delete last picture
GPIO_PIN_1=/sys/class/gpio/gpio${GPIO_PIN_DELETE_ALL}/value # Delete all pictures

while true; do
  GPIO_RES=`gpio-notify ${GPIO_PIN_0} ${GPIO_PIN_1}`
  if [[ "${GPIO_RES}" = "${GPIO_PIN_1} 0" ]]; then
    echo "[ Button 1 has been pressed: Deleting all pictures. ]"
	${LIBIPHO_BASE}/reset_with_backup.sh
  fi
  if [[ "${GPIO_RES}" = "${GPIO_PIN_0} 0" ]]; then
    echo "[ Button 0 has been pressed: Deleting last picture. ]"

    SECOND_LAST_LINE=`tail -n 2 ${GALLERY_LIST} | head -n 1`
    # Check whether the line starts with <a href=
    RES=`echo $SECOND_LAST_LINE | grep "^<a href="`
    if  [[ -z "${RES}" ]]; then
      echo "[ Did not find a picture in the gallery. Deleting nothing. ]"
    else
      GALLERY_PICTURE_TO_REMOVE=`echo $SECOND_LAST_LINE | sed 's/<a href="\([^"]*\).*$/\1/g'`
      echo "[ Removing picture ${GALLERY_PICTURE_TO_REMOVE} ]"
      # First remove the corresponding line from the list of pictures
      sed -i "\,${GALLERY_PICTURE_TO_REMOVE},d" ${GALLERY_LIST}
      # Delete picture in order to prevent it from re-appearing in the gallery
      rm ${HTML_DIR}/${GALLERY_PICTURE_TO_REMOVE}
      # Show the previous picture on the screen.
      # Therefore, first delete the picture here.
      PICTURE_TO_REMOVE=`echo $GALLERY_PICTURE_TO_REMOVE | sed "s#${GALLERY_RELATIVE_DIR}#${PICTURE_RELATIVE_DIR}#g"`
      echo "Removing picture ${PICTURE_TO_REMOVE}"
      rm ${HTML_DIR}/${PICTURE_TO_REMOVE}
      # Update screen to show the second last picture
      PICTURE=`ls -tr ${HTML_DIR}/${PICTURE_RELATIVE_DIR} | grep "\.JPG" | tail -n 1`
      if [[ -z "${PICTURE}" ]]; then 
        echo "No picture available. Showing empty screen."
        cp ${SCREEN_TEMPLATE_FILE} ${SCREEN_TARGET_FILE}
      else
        echo "[ Showing previous picture ${PICTURE} ]"
        ${LIBIPHO_BASE}/screen/update_libipho_screen.sh ${PICTURE}
      fi
    fi
  fi
done
