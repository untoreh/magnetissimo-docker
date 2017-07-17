#!/bin/sh

sed -r 's/magnetissimo_dev/torrent/' -i ./config/dev.exs 
sed -r 's/pool_size: 50/pool_size: 50,/' -i ./config/dev.exs
echo '  password: "CHANGE_ME",' >> ./config/dev.exs
echo '  username: "torrent"' >> ./config/dev.exs
