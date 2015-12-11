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

#################################################
# Create a filesystem lock (using mkdir)
# and execute the update_gallery.sh script
# only if no other instance is holding the lock.
#################################################

if [ $# -le 2 ]; then
  echo "Runs your executable only after acquiring a lock."
  echo "If the lock cannot be aquired immediately, wait"
  echo "until the lock has been released."
  echo ""
  echo "Usage: $0 <lock_dir> <executable> ..."
  echo ""
  echo "  lock_dir    Directory used as filesystem lock, e.g., /tmp/my-command-lock"
  echo "              The directory must only be created by this script."
  echo "  executable  Executable to run after the lock has been acquired"
  echo ""
  echo "All further command line parameters are passed to the executable"
  echo "as command line paramters."
  exit 1
fi

LOCKDIR="$1"
PIDFILE="${LOCKDIR}/PID"
EXECUTABLE="$2"

echo "[ Trying to lock ${LOCKDIR} ]"
if mkdir "${LOCKDIR}" &>/dev/null; then
    # trap if storing the PID fails
    trap 'echo "[ Lock ${LOCKDIR} released, PID $$. ]"
          rm -rf "${LOCKDIR}"' 0
    echo "[ Lock ${LOCKDIR} acquired, PID $$. ]"
    echo "$$" >"${PIDFILE}"
	# eat the first two command line arguments
	shift 2
    ${EXECUTABLE} $@
else
    # lock failed, now check if the other PID is alive
    OTHERPID="$(cat "${PIDFILE}" 2> /dev/null)"
    if [ $? != 0 ]; then
      echo "[ Lock ${LOCKDIR} failed, but is about to be released. Retrying. ]"
      exec "$0" "$@"
	else
      echo "[ Lock ${LOCKDIR} failed. Waiting for PID: $OTHERPID ]"
    fi

    if ! kill -0 $OTHERPID &>/dev/null; then
        echo "[ Removing stale lock ${LOCKDIR} of nonexistant PID ${OTHERPID} ]"
        rm -rf "${LOCKDIR}"
    else
        sleep 0.5
    fi
    exec "$0" "$@"
fi
