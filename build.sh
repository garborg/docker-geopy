#!/usr/bin/env sh

name="pyosmnx"
image_id=$(docker build -q .)

echo "$image_id"

projdir=$(pwd)
docker run -d \
    -p 8888:8888 \
    -v $projdir:/home/jovyan/work \
    --user root \
    -e GRANT_SUDO=yes \
    --name $name \
    $image_id

pycmd="import rtree; import geopandas; import osmnx; rtree.Rtree(); print('\nOK')"
docker exec $name python -c "$pycmd"
