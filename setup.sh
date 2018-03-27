#!/usr/bin/env bash

docker-compose exec superset fabmanager create-admin --app superset
docker-compose exec superset superset db upgrade
docker-compose exec superset superset init
