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

GPIO_PIN=/sys/class/gpio/gpio${GPIO_PIN_TRIGGER}/value # Trigger from the remote control

FIFO=/tmp/gpio-remote-trigger-listener-fifo
mkfifo $FIFO

while true; do
  trap 'trap - SIGTERM && kill $GPIO_NOTIFY_PID && exit 0' SIGTERM SIGINT
  gpio-notify ${GPIO_PIN} > $FIFO &
  GPIO_NOTIFY_PID=$!
  read GPIO_RES < $FIFO
  wait $GPIO_NOTIFY_PID

  if [[ "${GPIO_RES}" = "${GPIO_PIN} 0" ]]; then
    echo "[ Trigger changed from 1 to 0. Showing wait screen. ]"
    if [ "${USE_ANDROID_SCREEN}" = true ]; then
        echo "+" > ${LIBIPHO_SCREEN_FIFO}
    else
        ${LIBIPHO_BASE}/screen/show_wait_screen.sh
    fi
  fi
  if [[ "${GPIO_RES}" = "${GPIO_PIN} 1" ]]; then
    echo "[ Trigger changed from 0 to 1. Doing nothing. ]"
  fi
done
