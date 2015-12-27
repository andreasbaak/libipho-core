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

# Source this file in order to define two logging functions.


# Function that logs its parameter to the syslog.
# Make sure to set the LOG_TAG variable in the script that uses the function
# to something appropriate that will be used as a tag for the log message.
log() {
	logger -t "$(basename $0)[$$]" "$@"
}

# If this function is called, all subsequent
# stdout and stderr is logged
# both to syslog and to stderr.
logAllOutput() {
    exec 1> >(logger -s -t "$(basename $0)[$$]") 2>&1
}
