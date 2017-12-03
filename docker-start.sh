#!/bin/bash
docker-compose up -d
docker-compose exec php sh -c 'cd /var/www/html && ./wait-for-it.sh -t 60 mariadb:3306 -- ./init.sh'
