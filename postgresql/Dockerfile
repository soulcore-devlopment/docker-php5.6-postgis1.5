FROM centos:centos6.9

ADD exclude-postgres.repo /etc/yum.repos.d/exclude-postgres.repo

#RUN rpm -i https://download.postgresql.org/pub/repos/yum/9.0/redhat/rhel-6-x86_64/pgdg-redhat90-9.0-5.noarch.rpm && \
#    yum update -y --setopt=tsflags=nodocs && yum install -y -y --setopt=tsflags=nodocs \
#    postgresql90-contrib.x86_64 postgresql90.x86_64 postgresql90.x86_64 \
#    postgresql90-server.x86_64 postgis90-utils.x86_64 \
#    postgis90.x86_64 proj-epsg proj-nad \
#    yum clean all

RUN rpm -i https://download.postgresql.org/pub/repos/yum/9.1/redhat/rhel-6-x86_64/pgdg-centos91-9.1-6.noarch.rpm && \
    yum update -y --setopt=tsflags=nodocs && yum install -y -y --setopt=tsflags=nodocs \
    postgresql91-contrib.x86_64 postgresql91.x86_64 postgresql91.x86_64 \
    postgresql91-server.x86_64 postgis91-utils.x86_64 \
    postgis91.x86_64 proj-epsg proj-nad \
    yum clean all

EXPOSE 5432/TCP

ENV POSTGRES_DATA_FOLDER /data

VOLUME [ /data ]

ENV LOCALE en_US
ENV ENCODING UTF-8
ENV POSTGRES_PASSWD postgres

ADD run-postgresql.sh /run-postgresql.sh
RUN chmod -v +x /run-postgresql.sh

ENTRYPOINT [ "/run-postgresql.sh" ]

CMD [ "postgres" ]
