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
source ${LIBIPHO_BASE}/tools/log_util.sh

log "Begin"

if [ $# -ne 1 ]; then
    echo "Usage: $0 image_filename"
    exit 1
fi

PICTURE=$1

TARGET_FILE=${HTML_DIR}/js/libipho-pictures.js

# write the data first into a temporary file in order to minimize
# the time in which the target file could be corruped
TEMP_TARGET_FILE=${TARGET_FILE}_next

# Insert text at the beginning of the last line
sed "\$i<a href=\"${GALLERY_RELATIVE_DIR}/$PICTURE\"> <img src=\"${THUMBNAIL_RELATIVE_DIR}/$PICTURE\"></a>\\\\" ${TARGET_FILE} > $TEMP_TARGET_FILE

# swap the file with the real target
mv $TEMP_TARGET_FILE $TARGET_FILE
log "End"
