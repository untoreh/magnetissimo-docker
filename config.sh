#!/bin/sh

after="config :magnetissimo, Magnetissimo.Repo,"
sed "/$after/a\\
\    password: \"CHANGE_ME\",\\
\    username: \"torrent\",\\
\    database: \"torrent\",\\
\    hostname: \"localhost\",\\
\    port: 5432," -i ./config/prod.exs
sed "s/ssl: true/ssl: false/" -i ./config/prod.exs

sed -r 's/magnetissimo_dev/torrent/' -i ./config/dev.exs 
sed -r 's/pool_size: 50/pool_size: 50,/' -i ./config/dev.exs
echo '  password: "CHANGE_ME",' >> ./config/dev.exs
echo '  username: "torrent"' >> ./config/dev.exs

sed 's/:sizeable]]/:sizeable, :scrivener_ecto, :scrivener_html, :mix]]/' -i ./mix.exs
