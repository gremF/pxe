#!/bin/sh
set -e

cd /app

if [ ! -f /app/data/iventoy.dat ]; then
    cp /app/data_tmp/iventoy.dat /app/data/iventoy.dat
fi

if [ ! -f /app/data/mac.db ]; then
    cp /app/data_tmp/mac.db /app/data/mac.db
fi

rm -rf /app/data_tmp

if [ "$AUTO_START_PXE" = "true" ]; then
    ./iventoy.sh -R start &
else
    ./iventoy.sh start &
fi

exec sleep infinity
