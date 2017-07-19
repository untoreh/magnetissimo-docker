#!/bin/sh
## run this script as the correct user

/usr/bin/createdb
cat <<EOP | psql
CREATE USER torrent WITH PASSWORD 'CHANGE_ME';
CREATE DATABASE torrent OWNER torrent;
ALTER USER torrent CREATEDB;
\q
EOP
