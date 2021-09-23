#!/bin/bash

# Produce: pg4devs.com
# Author: Emanuel A Carneiro

#-
#- Install PostgreSQL 13 - Ubuntu 20.04 LTS
#-

# Env globals Variables
export PG_VERSION='13'

# Signed and install
sudo
sudo echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list
sudo apt-get -y install wget ca-certificates
sudo wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install postgresql-${PG_VERSION} postgresql-server-dev-${PG_VERSION} postgresql-client-${PG_VERSION} pg-activity

# Start automatically
sudo systemctl enable postgresql@${PG_VERSION}-main

# Restart
sudo systemctl restart postgresql@${PG_VERSION}-main

#-
#- pgModeler - Ubuntu 20.04 LTS
#-

# Libs deps
sudo apt-get install -y qt5-qmake libxml2-dev libqt5svg5*

# dirs
cd ~
mkdir workstation
cd workstation/
mkdir temp
cd temp

# code git
git clone https://github.com/pgmodeler/pgmodeler.git

# checkout
cd pgmodeler/
git checkout master
git pull

# Dirs Prefix
sudo mkdir /opt/pgModeler
sudo chown ${USER}:root /opt/pgModeler

# Prepare and Compilation
/usr/bin/qmake -r -spec linux-g++ CONFIG+=release PREFIX=/opt/pgModeler BINDIR=/opt/pgModeler PRIVATEBINDIR=/opt/pgModeler PRIVATELIBDIR=/opt/pgModeler/lib LANGDIR=/opt/pgModeler/lang SAMPLESDIR=/opt/pgModeler/samples SCHEMASDIR=/opt/pgModeler/schemas PLUGINSDIR=/opt/pgModeler/plugins CONFDIR=/opt/pgModeler/conf DOCDIR=/opt/pgModeler SHAREDIR=/opt/pgModeler TEMPDIR=/opt/pgModeler/tmp pgmodeler.pro
make && make install

# Run and enjoy
ls -l /opt/pgModeler/
/opt/pgModeler/pgmodeler
