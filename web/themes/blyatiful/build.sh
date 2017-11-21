#!/bin/bash

lessc less/style.less css/style.css
docker-compose exec php sh -c 'cd /var/www/html/web && drush cr'
