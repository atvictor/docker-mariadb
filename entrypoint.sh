#!/bin/bash

if [ ! -d "/var/lib/mysql/mysql" ]; then
  mysql_install_db
  cat <<EOF | mysqld --bootstrap --loose-skip-ndbcluster
FLUSH PRIVILEGES;
DELETE FROM mysql.user;
CREATE USER 'root'@'%' IDENTIFIED BY '${MARIADB_PASSWORD}';
GRANT ALL ON *.* TO 'root'@'%' WITH GRANT OPTION;
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db LIKE 'test%';
EOF
  chown -R mysql:mysql /var/lib/mysql
fi

exec "$@"
