#!/bin/bash
if [ ! -f init ]; then
  composer install
  mkdir private_files web/sites/default/files
  cd web
  drush si -y --site-name=TheIdeaProject --site-mail=TheIdeaProject@test.com --account-name=admin --account-pass=123 --db-url=mysql://drupal:drupal@mariadb/drupal standard
  chmod 666 sites/default/settings.php
  echo "\$config_directories['sync'] = '../config/prod';" >> sites/default/settings.php
  echo "\$settings['file_private_path'] = '../private_files';" >> sites/default/settings.php
  echo "\$settings['file_public_path'] = 'sites/default/files';" >> sites/default/settings.php
  echo "\$settings['install_profile'] = 'standard';" >> sites/default/settings.php
  chmod 444 sites/default/settings.php
  drush ev '\Drupal::entityManager()->getStorage("shortcut_set")->load("default")->delete();'
  drush config-set -y "system.site" uuid "f1a9fa87-20c1-42f1-b5f3-d75013dac850"
  drush cim -y sync
  drush cim -y sync
  drush config-set -y "system.file" "path.temporary" "/tmp"
  drush en -y the_idea_project
  drush cr
  echo 1 > ../init
fi
