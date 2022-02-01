#!/data/data/com.termux/files/usr/bin/bash -e

echo -e "[ +++==========***  Starting nethunter  ***==========+++ ]\n"
echo "[ File name : nethunter  location : /data/data/com.termux/files/usr/bin ] <if you need edit it do it carefully!>"
echo "If you need older nethunter file copy partial code from https://offs.ec/2MceZWr "
echo "If you enter nethunter in termux,if it was successful you can see something like this ──(kali㉿localhost)-[~]
└─$"

cd ${HOME}
## termux-exec sets LD_PRELOAD so let's unset it before continuing
unset LD_PRELOAD
## Workaround for Libreoffice, also needs to bind a fake /proc/version
if [ ! -f kali-arm64/root/.version ]; then
    touch kali-arm64/root/.version
fi

## Default user is "kali"
user="kali"
home="/home/$user"
start="sudo -u kali /bin/bash"
## NH can be launched as root with the "-r" cmd attribute
## Also check if user kali exists, if not start as root


#fix code
fix_profile() {
    if [ -f ${DESTINATION}/root/.bash_profile ]; then
        sed -i '/if/,/fi/d' "${DESTINATION}/root/.bash_profile"
    fi
}


fix_uid() {
    GID=$(id -g)
    startkali -r usermod -u $UID kali 2>/dev/null
    startkali -r groupmod -g $GID kali 2>/dev/null
}


create_xsession_handler() {
    if [ $SETARCH = "arm64" ]; then
        LIBGCCPATH=/usr/lib/aarch64-linux-gnu
    else
        LIBGCCPATH=/usr/lib/arm-linux-gnueabihf
    fi
    VNC_WRAPPER=$DESTINATION/usr/bin/vnc
    cat > $VNC_WRAPPER
chmod +x $VNC_WRAPPER
}
#fix code end

#nethunter default code

if grep -q "kali" kali-arm64/etc/passwd; then
    KALIUSR="1";
else
    KALIUSR="0";
fi
if [[ $KALIUSR == "0" || ("$#" != "0" && ("$1" == "-r" || "$1" == "-R")) ]];then
    user="root"
    home="/$user"
    start="/bin/bash --login"
    if [[ "$#" != "0" && ("$1" == "-r" || "$1" == "-R") ]];then
        shift
    fi
fi

cmdline="proot \
        --link2symlink \
        -0 \
        -r kali-arm64 \
        -b /dev \
        -b /proc \
        -b kali-arm64$home:/dev/shm \
        -w $home \
           /usr/bin/env -i \
           HOME=$home \
           PATH=/usr/local/sbin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin \
           TERM=$TERM \
           LANG=C.UTF-8 \
           $start"


cmd="$@"
if [ "$#" == "0" ];then
    exec $cmdline
else
    $cmdline -c "$cmd"
fi

## Main

fix_profile
fix_uid
create_xsession_handler
