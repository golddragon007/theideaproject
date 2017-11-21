FROM wodby/drupal-php:7.1-3.0.0
USER root
RUN sed -i 's/www-data:x:82:82/www-data:x:1000:1000/' /etc/passwd
RUN sed -i 's/www-data:x:82/www-data:x:1000/' /etc/group
RUN find / -user 82 -exec chown 1000 {} \;
RUN find / -group 82 -exec chgrp 1000 {} \;
USER www-data:1000
