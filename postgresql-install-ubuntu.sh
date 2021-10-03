#!/bin/bash
# PostgreSQL install
# Ubuntu Dist
# Author: Emanuel A Carneiro
# email contact: emanuel.ac.pro@gmail.com
# Instagram: @emanuel.ac.pro @pg4devs @iroot.tech

# Choice version
export PG_VERSION='13'

# Repo pgdg
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list

# Cert and key
apt-get -y install wget ca-certificates
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Install
apt-get -y update
apt-get -y upgrade
apt-get -y install postgresql-${PG_VERSION} postgresql-server-dev-${PG_VERSION} postgresql-client-${PG_VERSION} pg-activity

# Restart process
systemctl restart postgresql@${PG_VERSION}-main

# Ajust listan_address
cat << EOF > /etc/postgresql/${PG_VERSION}/main/conf.d/listen.conf
listen_addresses = '*'
EOF
chown postgres:postgres /etc/postgresql/${PG_VERSION}/main/conf.d/listen.conf

systemctl restart postgresql@${PG_VERSION}-main
