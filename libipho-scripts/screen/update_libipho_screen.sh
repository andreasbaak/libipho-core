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

if [ $# -ne 1 ]; then
    echo "Usage: $0 image_filename"
    exit 1
fi

source ${LIBIPHO_BASE}/libipho_env.sh

PLACEHOLDER="##IMAGE_FULL_FILENAME##"
IMAGE_FILENAME=$1
IMAGE_RELATIVE_FILENAME=${PICTURE_RELATIVE_DIR}/${IMAGE_FILENAME}

echo "[ Updating libipho screen, image filename: $IMAGE_FILENAME ]"
sed "s|${PLACEHOLDER}|${IMAGE_RELATIVE_FILENAME}|g" ${SCREEN_TEMPLATE_FILE} > ${SCREEN_TARGET_FILE}.tmp
mv ${SCREEN_TARGET_FILE}.tmp ${SCREEN_TARGET_FILE}
echo "[ Libipho screen updated. ]"
