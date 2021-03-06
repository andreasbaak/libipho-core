#!/bin/sh
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

if [ -z "$LIBIPHO_WWW" ] || [ -z "$LIBIPHO_BASE" ]; then
    logger -s -t "libipho_env.sh" "Error: LIBIPHO_BASE or LIBIPHO_WWW variable is unset."
    exit 1
fi

export HTML_DIR=${LIBIPHO_WWW}
export PICTURE_RELATIVE_DIR=libipho-pictures
export THUMBNAIL_RELATIVE_DIR=${PICTURE_RELATIVE_DIR}/thumbnails
export GALLERY_RELATIVE_DIR=${PICTURE_RELATIVE_DIR}/gallery
export PICTURE_TARGET_DIR=${HTML_DIR}/${PICTURE_RELATIVE_DIR}
export THUMBNAIL_TARGET_DIR=${HTML_DIR}/${THUMBNAIL_RELATIVE_DIR}
export GALLERY_TARGET_DIR=${HTML_DIR}/${GALLERY_RELATIVE_DIR}
export SCREEN_TEMPLATE_FILE=${LIBIPHO_BASE}/res/screen_template.html
export SCREEN_TARGET_FILE=${HTML_DIR}/screen.html

export SCREEN_LOCK=/var/volatile/tmp/libipho-screen-lock

export USE_ANDROID_SCREEN=false

export GPIO_PIN_TRIGGER=67
export GPIO_PIN_DELETE_LAST=30
export GPIO_PIN_DELETE_ALL=60
