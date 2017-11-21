#!/bin/bash
docker-compose up -d
docker-compose exec php sh -c 'cd /var/www/html && ./init.sh'
