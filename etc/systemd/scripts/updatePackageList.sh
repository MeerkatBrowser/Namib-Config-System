#!/bin/bash

ONLINE=false

function checkOnlineStatus() {
    if ping -c 1 github.com >> /dev/null 2>&1; then
        echo "online"
        ONLINE=true
    else
        echo "offline"
    fi
}

function refreshPackageList() {
    FILE='/var/lib/pacman/sync/core.files'
    if [ -f $FILE ]; then
        echo "File $FILE exists."
    else
        checkOnlineStatus
        if $ONLINE; then
            echo "Update local database..."
            pacman -Sy
            pacman-optimize && sync
        fi
    fi
}

refreshPackageList
