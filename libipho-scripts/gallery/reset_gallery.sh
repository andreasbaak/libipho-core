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

TARGET_FILE=${HTML_DIR}/js/libipho-pictures.js

rm ${TARGET_FILE}
cat >> ${TARGET_FILE} << EOL
document.write('\\
');
EOL
log "End"

