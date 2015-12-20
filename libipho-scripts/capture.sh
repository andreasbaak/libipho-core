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

cd ${LIBIPHO_BASE}
source libipho_env.sh

${LIBIPHO_BASE}/create_directories.sh

if [ "${USE_ANDROID_SCREEN}" = true ]; then
  # Start the server application that transmits the images to the Android app
  libipho-screen-server ${LIBIPHO_SCREEN_FIFO} &
  echo $! > libipho-screen-server.pid
fi

gphoto2 --hook-script=${LIBIPHO_BASE}/hook.sh --capture-tethered --keep --keep-raw
