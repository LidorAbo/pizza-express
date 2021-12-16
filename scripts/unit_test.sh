#!/bin/bash
docker_compose_folder=docker-compose
cd ../${docker_compose_folder} || exit
export PORT=$(cat .env | tail -n 1 | cut -d '=' -f 2 )
export REDIS_HOST=$(cat .env | head -n 1 | cut -d '=' -f 2 )
docker-compose up -d $REDIS_HOST unit-test 