FROM alpine

ENV PGDATA=/pgsql/data
ENV PGRUN=/run/pgsql
ENV PGDIR=/pgsql
ENV PGSTARTTIMEOUT=270

COPY ./*.sh /usr/local/bin/
COPY ./init /init

RUN apk add -t buildenv $(apk --update search -q erlang) elixir postgresql git libressl nodejs-npm  && \
  mkdir -p $PGDIR /run/postgresql && chmod 777 $PGDIR /run/postgresql && \
  su postgres -c "pg_ctl initdb -D $PGDATA && \
  pg_ctl start -D ${PGDATA} -s -w -t ${PGSTARTTIMEOUT}" && \
  git clone https://github.com/sergiotapia/magnetissimo.git && \
  cd magnetissimo && \
  echo -e 'Y\nY\n' | mix deps.get && \
  createdb.sh && \
  config.sh && \
  echo -e 'Y\nY\n' | mix ecto.create && \
  echo -e 'Y\nY\n' | mix ecto.migrate && \
  npm install && \
  sed -r 's/(applications: *\[)/\1:mix, /' -i mix.exs
  MIX_ENV=dev mix release --env=dev
  su postgres -c "pg_ctl stop -D ${PGDATA} -s -m fast" && \
  rm -rf $PGDATA && mkdir $PGDATA && \
  apk del --purge buildenv && \
  mv _build/dev/rel/magnetissimo/ /rel
  rm -rf /var/cache/apk/* /magnetissimo

EXPOSE 4000

# VOLUME ["/pgsql/data"]
# RUN adduser -D unpriv && \
#  adduser -D dyno && \
#  chown unpriv:dyno -hR $(ls -d /* | grep -Ev "dev|proc|sys")
# USER unpriv 

CMD ["/init"]
