#
# Contribuidor: {{ nome_do_autor(); }}
#

pkgname=filesystem
pkgver=2023.01.31
pkgrel=1
pkgdesc='Arquivos básicos do Arch Linux'
arch=('x86_64')
license=('cIO')
url='http://localhost/archlinux'
depends=('iana-etc')
backup=('etc/crypttab'
    'etc/fstab'
    'etc/group'
    'etc/gshadow'
    'etc/host.conf'
    'etc/hosts'
    'etc/issue'
    'etc/ld.so.conf'
    'etc/nsswitch.conf'
    'etc/passwd'
    'etc/profile'
    'etc/resolv.conf'
    'etc/securetty'
    'etc/shadow'
    'etc/shells'
    'etc/subuid'
    'etc/subgid')
source=('crypttab'
    'env-generator'
    'fstab'
    'group'
    'gshadow'
    'host.conf'
    'hosts'
    'issue'
    'ld.so.conf'
    'locale.sh'
    'nsswitch.conf'
    'os-release'
    'profile'
    'passwd'
    'resolv.conf'
    'securetty'
    'shadow'
    'shells'
    'sysctl'
    'sysusers'
    'tmpfiles'
    'subuid'
    'subgid'
    'archlinux-logo.svg'
    'archlinux-logo.png'
    'archlinux-logo-text.svg'
    'archlinux-logo-text-dark.svg')
sha256sums=('SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP'
    'SKIP')

#
#
#
package()
{
    cd "$pkgdir"

    #
    # Configurar o sistema de arquivos raiz.
    #
    for d in boot dev etc home mnt usr var opt srv/http run; do
        install -d -m755 $d
    done

    install -d -m555 proc
    install -d -m555 sys
    install -d -m0750 root
    install -d -m1777 tmp

    #
    # vsftpd não vai fazer o procedimento com permissões
    # de gravação ativadas /srv/ftp.
    # ftp (uid 14/gid 11).
    #
    install -d -m555 -g 11 srv/ftp

    #
    # Configurar /etc e /usr/share/factory/etc.
    #
    install -d etc/{ld.so.conf.d,skel,profile.d} usr/share/factory/etc

    for f in fstab group host.conf hosts issue ld.so.conf nsswitch.conf \
        passwd resolv.conf securetty shells profile subuid subgid; do
        install -m644 "$srcdir"/$f etc/
        install -m644 "$srcdir"/$f usr/share/factory/etc/
    done

    ln -s ../proc/self/mounts etc/mtab
    for f in gshadow shadow crypttab; do
        install -m600 "$srcdir"/$f etc/
        install -m600 "$srcdir"/$f usr/share/factory/etc/
    done

    touch etc/arch-release
    install -m644 "$srcdir"/locale.sh etc/profile.d/locale.sh
    install -Dm644 "$srcdir"/os-release usr/lib/os-release

    #
    # Configurar /var.
    #
    for d in cache local opt log/old lib/misc empty; do
        install -d -m755 var/$d
    done

    install -d -m1777 var/{tmp,spool/mail}

    #
    # Permitir corridas setgid (gid 50) para escrever
    # pontuações.
    #
    install -d -m775 -g 50 var/games
    ln -s spool/mail var/mail
    ln -s ../run var/run
    ln -s ../run/lock var/lock

    #
    # Configurar hierarquia /usr.
    #
    for d in bin include lib share/{misc,pixmaps} src; do
        install -d -m755 usr/$d
    done

    for d in {1..8}; do
        install -d -m755 usr/share/man/man$d
    done

    #
    # Adicionar links simbólicos de lib.
    #
    ln -s usr/lib lib
    [[ $CARCH = 'x86_64' ]] && {
        ln -s usr/lib lib64
        ln -s lib usr/lib64
    }

    #
    # Adicionar links simbólicos bin.
    #
    ln -s usr/bin bin
    ln -s usr/bin sbin
    ln -s bin usr/sbin

    #
    # Configurar hierarquia /usr/local.
    #
    for d in bin etc games include lib man sbin share src; do
        install -d -m755 usr/local/$d
    done

    ln -s ../man usr/local/share/man

    #
    # Configurar systemd-sysctl.
    #
    install -D -m644 "$srcdir"/sysctl usr/lib/sysctl.d/10-arch.conf

    #
    # Configurar systemd-sysusers.
    #
    install -D -m644 "$srcdir"/sysusers usr/lib/sysusers.d/arch.conf

    #
    # Configurar systemd-tmpfiles.
    #
    install -D -m644 "$srcdir"/tmpfiles usr/lib/tmpfiles.d/arch.conf

    #
    # Configurar systemd.environment-generator.
    #
    install -D -m755 "$srcdir"/env-generator usr/lib/systemd/system-environment-generators/10-arch

    #
    # Adicionar logotipo.
    #
    install -D -m644 "$srcdir"/archlinux-logo{.png,.svg,-text.svg,-text-dark.svg} usr/share/pixmaps
}
