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

BACKUP_DIR_PREFIX=${HOME}/pictures-backup

NUM=1
while [[ -d "${BACKUP_DIR_PREFIX}_${NUM}" ]]; do
  ((NUM++))
done
BACKUP_TARGET_DIR=${BACKUP_DIR_PREFIX}_${NUM}
echo "[ Creating backup in ${BACKUP_TARGET_DIR} ]"
mv ${PICTURE_TARGET_DIR} ${BACKUP_TARGET_DIR}
${LIBIPHO_BASE}/create_directories.sh
cp ${LIBIPHO_BASE}/res/DEFAULT_PICTURE ${LIBIPHO_BASE}/DSC_0.JPG
${LIBIPHO_BASE}/gallery/reset_gallery.sh
${LIBIPHO_BASE}/hook.sh
