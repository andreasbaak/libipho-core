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

log "Making 'please wait' overlay in the html visible"
${LIBIPHO_BASE}/tools/run_with_lock.sh ${SCREEN_LOCK} sed -i "s|display:none|display:block|g" ${SCREEN_TARGET_FILE}
