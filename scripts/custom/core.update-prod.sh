#!/bin/bash

echo "Executing core for update-prod.sh"
composer install --no-dev -o \
 && cd web \
 && drush updb -y \
 && drush cim sync -y \
 && drush entity-updates -y \
 && echo "Successfully updated."
