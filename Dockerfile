FROM debian:jessie

RUN groupadd -r mysql && \
    useradd -r -g mysql mysql -d /var/lib/mysql -s /bin/false

RUN apt-get update && \
    apt-get install -y software-properties-common apt-transport-https && \
    apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db && \
    add-apt-repository 'deb https://mariadb.cu.be/mariadb-10.0.21/repo/debian jessie main' && \
    apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y rsync galera mariadb-galera-server

RUN ln -sf /dev/stderr /var/log/mysql/mariadb-slow.log && \
    ln -sf /dev/stderr /var/log/mysql/error.log

COPY entrypoint.sh /
RUN chmod u+x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
