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

echo "[ Hook is starting. ]"

PICTURE_FILE=`ls DSC_*.JPG | tail -n 1`
if [ -z "$PICTURE_FILE" ]; then
  echo "[ Did not find a new jpg file. Exiting hook. ]"
  exit
fi

FULL_FILENAME=${PICTURE_TARGET_DIR}/${PICTURE_FILE}
FULL_THUMBNAIL_FILENAME=${THUMBNAIL_TARGET_DIR}/${PICTURE_FILE}
FULL_GALLERY_FILENAME=${GALLERY_TARGET_DIR}/${PICTURE_FILE}

echo "[ Moving image ${PICTURE_FILE} to ${FULL_FILENAME} ]"

mv ${PICTURE_FILE} ${FULL_FILENAME}

if [ "${USE_ANDROID_SCREEN}" = true ]; then
  echo ${FULL_FILENAME} > ${LIBIPHO_SCREEN_FIFO}
else
  ${LIBIPHO_BASE}/tools/run_with_lock.sh ${SCREEN_LOCK} ${LIBIPHO_BASE}/screen/update_libipho_screen.sh ${PICTURE_FILE}
fi

echo "[ Creating gallery image... ]"
epeg -m 1280 -q 80 ${FULL_FILENAME} ${FULL_GALLERY_FILENAME}

echo "[ Creating thumbnail... ]"
#convert -thumbnail 100 ${FULL_FILENAME} ${FULL_THUMBNAIL_FILENAME}
epeg -m 100 -q 80 ${FULL_FILENAME} ${FULL_THUMBNAIL_FILENAME}

${LIBIPHO_BASE}/tools/run_with_lock.sh /var/volatile/tmp/update-gallery-lock ${LIBIPHO_BASE}/gallery/update_gallery.sh ${PICTURE_FILE}
echo "[ Hook has finished. ]"
