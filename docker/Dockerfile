# syntax=docker/dockerfile:1
FROM alpine AS mysql-image

RUN apk add\
 zsh\
 git\
 neovim\
 mysql\
 mysql-client\
 mariadb-doc\
 man-db

COPY ./docker/my.cnf /etc/my.cnf
COPY ./docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# create empty config in order to avoid initial prompt
RUN touch ~/.zshrc

# RUN mysql_install_db -u mysql --datadir=/var/lib/mysql
# RUN chown -R mysql:mysql /var/lib/mysql

CMD /entrypoint.sh
# CMD ["tail", "-f", "/dev/null"]


# 
# mysql -u mysql
