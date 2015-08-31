FROM debian:jessie

RUN groupadd -r mysql && \
    useradd -r -g mysql mysql -d /var/lib/mysql -s /bin/false

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0xcbcb082a1bb943db && \
    echo "deb http://ftp.igh.cnrs.fr/pub/mariadb/repo/10.0/debian jessie main" >> /etc/apt/sources.list && \
    apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y rsync galera mariadb-galera-server

RUN ln -sf /dev/stderr /var/log/mysql/mariadb-slow.log && \
    ln -sf /dev/stderr /var/log/mysql/error.log

COPY entrypoint.sh /
RUN chmod u+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
