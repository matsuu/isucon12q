#!/bin/sh

#PATH=/sbin:/bin:/usr/bin

# Hibernation selects the swapfile with highest priority. Since there may be
# other swapfiles configured, ensure /swap-hibinit is selected as hibernation
# target by setting to maximum priority. See LP#1968805.
swap_priority=32767

do_hibernate() {
    if [ -d /run/systemd/system ]; then
        systemctl hibernate
    else
        pm-hibernate
        swapoff /swap-hibinit
    fi
}


case "$2" in
    SBTN)
        swapon --priority=$swap_priority /swap-hibinit && do_hibernate
        ;;
    *)
        logger "ACPI action undefined: $2" ;;
esac
