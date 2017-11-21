# TheIdeaProject install guide

- [Prerequirements](#prerequirements)
    - [Base](#base)
    - [When using docker](#when-using-docker)
- [Install TheIdeaProject on Linux/Mac](#install-theideaproject-on-linuxmac)
    - [Install drupal](#install-drupal)
- [Install TheIdeaProject on Linux/Mac with docker](#install-theideaproject-on-linuxmac-with-docker)
    - [Install drupal](#install-drupal-1)
- [Install TheIdeaProject on Windows](#install-theideaproject-on-windows)
    - [Install drupal](#install-drupal-2)
- [Possible problems](#possible-problems)

## Prerequirements

### Base

- PHP 7.0 or newer
- composer ([https://getcomposer.org/download/](https://getcomposer.org/download/))
- drush ([http://docs.drush.org/en/8.x/install-alternative/](http://docs.drush.org/en/8.x/install-alternative/))
- npm ([https://howtonode.org/how-to-install-nodejs](https://howtonode.org/how-to-install-nodejs), [https://nodejs.org/en/download/](https://nodejs.org/en/download/))  
note: this needed only if you want to run behat, also, maybe better to use yarn...

Then continue the traditionally installation with: [Linux/Mac guide](#install-theideaproject-on-linuxmac) and/or [Windows Guide](#install-theideaproject-on-windows)

### When using docker

- PHP 7.0 or newer
- composer ([https://getcomposer.org/download/](https://getcomposer.org/download/))
- docker ([https://docs.docker.com/engine/installation/](https://docs.docker.com/engine/installation/))
    - This guide assumes you installed it so it doesn't need sudo to run
- docker-compose ([https://docs.docker.com/compose/install/](https://docs.docker.com/compose/install/))

Continue with: [Linux/Mac guide with docker](#install-theideaproject-on-linuxmac-with-docker)

## Install TheIdeaProject on Linux/Mac

### Install drupal

1. Clone the repo to your favorite place:  
`git clone https://github.com/golddragon007/theideaproject.git TheIdeaProject`
2. Enter the directory: `cd TheIdeaProject`
3. Get drupal and module files  
`composer install`
4. Import this site to your favorite apache+php config (i.e. XAMPP, Acquia Dev Desktop)  
**NOTE: at least PHP 7.0 required!**  
Webroot: `<git-root>/web`  
Create also a virtual host for it if your program didn't do that. (like: `TheIdeaProject.localhost` or `TheIdeaProject.lh` or `TheIdeaProject.dd`)  
After you finished: `cd web`
5. Install site:  
`drush si --site-name=TheIdeaProject --site-mail=TheIdeaProject@test.com --account-name=admin --account-pass=123 --db-url=mysql://username:password@localhost/TheIdeaProject standard`  
**NOTE**: don't forget to change the DB's user, password etc. in this command if needed!
6. Modify settings.php (add these lines):
    1. `$config_directories['sync'] = '../config/prod';`
    2. `$settings['file_private_path'] = '../private_files';`
    3. `$settings['file_public_path'] = 'sites/default/files';`
    4. `$settings['install_profile'] = 'standard';`
7. Rewrite some stuff and import configs:
    1. `drush ev '\Drupal::entityManager()->getStorage("shortcut_set")->load("default")->delete();'`
    2. `drush config-set  "system.site" uuid "f1a9fa87-20c1-42f1-b5f3-d75013dac850" -y`
    3. `drush cim -y`
    4. `drush cr`

## Install TheIdeaProject on Linux/Mac with docker

**NOTE**: if your host PC doesn't have PHP7, than you need to run composer commands inside the docker!
1. `./docker-start.sh` (or `docker-start.bat` on windows)
2. Visit your site at: [http://localhost:](http://localhost:8000/) [8000](http://localhost:8000/) , log in with user: admin , password: 123

## Install TheIdeaProject on Windows

I recommend: Windows 10 with Bash on Linux on Windows + Acquia Dev Desktop/XAMPP

If you use Bash + XAMPP, drupal site install same as the Linux case.

If you use Bash + Acquia Dev Desktop, run composer from Bash, and drush from ADD (if ADD's composer doesn't work).  
Note: ADD has composer, but… sometimes it's not really want to work (at least for me, it never worked)

When you **install npm** , install **WINDOWS version**! Because XAMPP and ADD will run cmd not bash.

### Install drupal

1. Clone repo to your favorite place:  
`git clone https://github.com/golddragon007/theideaproject.git TheIdeaProject`
2. Enter the directory: `cd TheIdeaProject`
3. Get drupal and module files  
`composer install`
4. Import this site to your favorite apache+php config (i.e. XAMPP, Acquia Dev Desktop)  
**NOTE: at least PHP 7.0 required!**  
Webroot: `<git-root>/web`  
Create also a virtual host for it if your program didn't do that. (like: `TheIdeaProject.localhost` or `TheIdeaProject.lh` or `TheIdeaProject.dd`)  
After you finished: `cd web`
5. Install site:  
`drush si --site-name=TheIdeaProject --site-mail=TheIdeaProject@test.com --account-name=admin --account-pass=123 --db-url=mysql://username:password@localhost/TheIdeaProject standard`  
**NOTE**: don't forget to change the DB's user, password etc. in this command if needed!
**NOTE 2**: If you use ADD you don't need to set the sql connection settings, because it's preset by ADD.
6. Modify settings.php (add these lines):
    1. `$config_directories['sync'] = '../config/prod';`
    2. `$settings['file_private_path'] = '../private_files';`
    3. `$settings['file_public_path'] = 'sites/default/files';`
    4. `$settings['install_profile'] = 'standard';`
7. Rewrite some stuff and import configs:
    1. Choose one of these:
        1. From **bash** :
`drush ev '\Drupal::entityManager()->getStorage("shortcut_set")->load("default")->delete();'`
        2. From **cmd** :
`drush ev "\Drupal::entityManager()->getStorage(\"shortcut_set\")->load(\"default\")->delete();"`
    2. `drush config-set  "system.site" uuid "f1a9fa87-20c1-42f1-b5f3-d75013dac850" -y`
    3. `drush cim -y sync`
    4. `drush cr`

## Possible problems

After installation, my site is broken into small pieces! (Windows)

Well, this happens when you don't have a properly setted temp directory. Go to /admin/config/media/file-system and watch what is there. Probably it will "/tmp". In windows it will be on your html directory's drive's root if you use ADD. Soo, if your web html is here and named phptest: E:\phptest than /tmp dir will be at: E:\tmp . Give 777 for it and cache rebuild, then you will be able to rock. This happens only once, if you didn't used this previously.

"Filename directory name or volume label syntax is incorrect" error at drush run (Windows, ADD)

Long story in short, your global drush and local drush conflicts. Delete drush\* files from <gitroot>/vendor/bin . Than you will be able to run drush.
