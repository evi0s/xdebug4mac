#!/bin/bash

# Enable Apache rewrite module
a2enmod rewrite

# For xdebug module
cat > /etc/php/7.3/apache2/conf.d/20-xdebug.ini << EOF
zend_extension=xdebug.so
xdebug.remote_enable=1
xdebug.remote_port=9010
xdebug.remote_host=host.docker.internal
xdebug.remote_log=/tmp/xdebug-remote.log
xdebug.remote_handler=dbgp
EOF

# Start services
/etc/init.d/mysql start
apache2ctl start
/etc/init.d/ssh start

# Create database users
mysql -e "CREATE DATABASE user;"
mysql -e "GRANT USAGE ON *.* TO 'user'@'localhost' IDENTIFIED BY 'user' WITH GRANT OPTION; GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP ON user.* TO 'user'@'localhost' IDENTIFIED BY 'user'; FLUSH PRIVILEGES;"

exec sleep infinity
