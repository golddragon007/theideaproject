# theideaproject
BME homework

## Installing (normal)
You need to use the standard Drupal installation. Drupal dependencies are managed with composer.

To import the existing configuration, you need to set the site uuid to the exported one:
`drush config-set "system.site" uuid "f1a9fa87-20c1-42f1-b5f3-d75013dac850" -y`

You also need to remove shortcuts from the fresh install, as the standard profile creates some by default:
`drush ev '\Drupal::entityManager()->getStorage("shortcut_set")->load("default")->delete();'`    

Detailed install guide is in the [INSTALL.md](/INSTALL.md)

