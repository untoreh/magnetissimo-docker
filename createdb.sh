#!/bin/sh
 
su postgres <<EOF
cat <<EOP | psql
CREATE USER torrent WITH PASSWORD 'CHANGE_ME';
CREATE DATABASE torrent OWNER torrent;
ALTER USER torrent CREATEDB;
\q
EOP
EOF
