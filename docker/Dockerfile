# syntax=docker/dockerfile:1
FROM alpine AS mysql-image

RUN apk add\
 zsh\
 git\
 neovim

# create empty config in order to avoid initial prompt
RUN touch ~/.zshrc

CMD tail -f /dev/null
