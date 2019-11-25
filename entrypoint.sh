#!/bin/sh

# Debug mode
if [ "$DEBUG" ]; then
    set -x
fi

# Enable Apache rewrite module
a2enmod rewrite

# Xdebug remote port
if [ -z "$XDEBUGPORT" ]; then
    XDEBUGPORT=9010
fi

# For xdebug module
cat > /etc/php/7.3/apache2/conf.d/20-xdebug.ini << EOF
zend_extension=xdebug.so
xdebug.remote_enable=1
xdebug.remote_port=${XDEBUGPORT}
xdebug.remote_host=host.docker.internal
xdebug.remote_log=/tmp/xdebug-remote.log
xdebug.remote_handler=dbgp
EOF

# Start services
/etc/init.d/mysql start
apache2ctl start
/etc/init.d/ssh start

## Init database
if [ -z "$DBNAME" ]; then
    DBNAME=user
fi

if [ -z "$DBUSER" ]; then
    DBUSER=user
fi

if [ -z "$DBPASS" ]; then
    DBPASS=$(cat /dev/urandom | head -n 10 | md5sum | head -c 32)
    echo "Database init password: ${DBPASS}"
fi

# Create database users
mysql -e "CREATE DATABASE ${DBNAME};"
mysql -e "GRANT USAGE ON *.* TO '${DBUSER}'@'localhost' IDENTIFIED BY '${DBPASS}' WITH GRANT OPTION; GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP ON ${DBUSER}.* TO '${DBUSER}'@'localhost' IDENTIFIED BY '${DBPASS}'; GRANT EXECUTE ON ${DBNAME}.* TO '${DBUSER}'@'localhost' IDENTIFIED BY '${DBPASS}'; FLUSH PRIVILEGES;"

exec sleep infinity
