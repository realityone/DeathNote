#!/bin/bash

set -ex

for (( i = 0; i < 3; i++ )); do
    project="demo_2048_$i"
    cat 2048_base.yml | sed "s/__HOSTNAME__/$project/" | docker-compose -p $project -f - up -d
done

docker ps --filter=label=interlock.domain=death-note.co -q | xargs docker pause
