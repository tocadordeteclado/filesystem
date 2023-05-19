#!/bin/sh


#
# Carregue locale.conf em caminhos XDG.
# /etc/locale.conf cargas e substituições pelo console
# do kernel são feitas pelo systemd. Mas nós substituímos
# isso aqui, veja FS#56688.
#
if [ -z "$LANG" ];
then
    if [ -n "$XDG_CONFIG_HOME" ] && [ -r "$XDG_CONFIG_HOME/locale.conf" ];
    then
        . "$XDG_CONFIG_HOME/locale.conf"
    elif [ -n "$HOME" ] && [ -r "$HOME/.config/locale.conf" ];
    then
        . "$HOME/.config/locale.conf"
    elif [ -r /etc/locale.conf ];
    then
        . /etc/locale.conf
    fi
fi

#
# Faça a definição de LANG comum para C se ainda
# não estiver definido.
#
LANG=${LANG:-C}

#
# Exporte todas as variáveis de localidade (locale (7))
# quando elas existirem.
#
export LANG LANGUAGE \
    LC_CTYPE \
    LC_NUMERIC \
    LC_TIME \
    LC_COLLATE \
    LC_MONETARY \
    LC_MESSAGES \
    LC_PAPER \
    LC_NAME \
    LC_ADDRESS \
    LC_TELEPHONE \
    LC_MEASUREMENT \
    LC_IDENTIFICATION
