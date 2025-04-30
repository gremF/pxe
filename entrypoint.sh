#!/bin/sh
set -e

cd /app

if [ ! -f /app/data/iventoy.dat ]; then
    cp /app/data_default/iventoy.dat /app/data/iventoy.dat
    rm -rf /app/data_default
fi

if [ "$AUTO_START_PXE" = "true" ]; then
    ./iventoy.sh -R start &
else
    ./iventoy.sh start &
fi

exec sleep infinity
