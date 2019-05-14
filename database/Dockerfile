FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD rootpassword
ENV MYSQL_DATABASE taki
ENV MYSQL_USER user
ENV MYSQL_PASSWORD password

ADD script.sql /docker-entrypoint-initdb.d

EXPOSE 3306
