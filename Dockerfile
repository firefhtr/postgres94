FROM suse/sles12sp2:latest
ADD script/postgres-setup.sh /bin/postgres-setup.sh
RUN chmod +x /bin/postgres-setup.sh
RUN zypper --gpg-auto-import-keys ref -s
RUN zypper in -y vim postgresql-init postgresql94 postgresql94-server
RUN chown -v postgres:postgres /var/lib/pgsql/
RUN su postgres -c "initdb -D /var/lib/pgsql/data"
USER root
RUN echo "host    all             all             0.0.0.0/0               md5" >> /var/lib/pgsql/data/pg_hba.conf
RUN echo "listen_addresses='*'"  >> /var/lib/pgsql/data/postgresql.conf
EXPOSE 5432
ENTRYPOINT ["/bin/postgres-setup.sh"]
