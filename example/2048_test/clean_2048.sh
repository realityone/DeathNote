#!/bin/bash

set -ex

docker ps --filter=label=interlock.domain=death-note.co -q | xargs docker unpause
docker ps --filter=label=interlock.domain=death-note.co -aq | xargs docker rm -f