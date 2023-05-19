# /etc/profile

#
# Definir nossa umask.
#
umask 022

#
# Acrescente "$1" a $PATH quando ainda não estiver.
# Essa API de função é acessível para scripts em
#     /etc/profile.d
#
append_path()
{
    case ":$PATH:" in
        *:"$1":*)
            ;;

        *)
            PATH="${PATH:+$PATH:}$1"
            ;;
    esac
}

#
# Acrescente nossos caminhos comum.
#
append_path '/usr/local/sbin'
append_path '/usr/local/bin'
append_path '/usr/bin'

#
# Forçar PATH a ser o ambiente.
#
export PATH

#
# Carregar perfis de /etc/profile.d.
#
if test -d /etc/profile.d/;
then
    for profile in /etc/profile.d/*.sh; do
        test -r "$profile" && . "$profile"
    done

    unset profile
fi

#
# Descarregue nossas funções de API de perfil.
#
unset -f append_path

#
# Configuração bash global de origem, quando
# interativa, mas não no modo posix ou sh.
#
if test "$BASH" &&\
    test "$PS1" &&\
    test -z "$POSIXLY_CORRECT" &&\
    test "${0#-}" != sh &&\
    test -r /etc/bash.bashrc
then
    . /etc/bash.bashrc
fi

#
# Termcap não está muito novo.
#
unset TERMCAP

#
# Man é mais rápido para obter isso.
#
unset MANPATH
