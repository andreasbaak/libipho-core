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

# enable GPIO ports needed for the "delete buttons"
echo ${GPIO_PIN_DELETE_LAST} > /sys/class/gpio/export
echo ${GPIO_PIN_DELETE_ALL} > /sys/class/gpio/export
# enable reading from the pin
echo "in" > /sys/class/gpio/gpio${GPIO_PIN_DELETE_LAST}/direction
echo "in" > /sys/class/gpio/gpio${GPIO_PIN_DELETE_ALL}/direction
# configure pins for interrupt handling
echo "both" > /sys/class/gpio/gpio${GPIO_PIN_DELETE_LAST}/edge
echo "both" > /sys/class/gpio/gpio${GPIO_PIN_DELETE_ALL}/edge
