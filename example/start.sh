#!/bin/bash

set -ex

echo "Starting Death Note Demo..."

docker-compose -f interlock.yml up -d
docker-compose -f worker.yml up -d
docker-compose -f demo.yml up -d

echo "Starting Death Note Secceed."