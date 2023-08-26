# syntax=docker/dockerfile:1
FROM alpine AS mysql-image

RUN apk add\
 zsh\
 mysql\
 mysql-client

COPY ./docker/my.cnf /etc/my.cnf
COPY ./docker/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY ./docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# create empty config in order to avoid initial prompt
RUN touch ~/.zshrc

CMD /entrypoint.sh
