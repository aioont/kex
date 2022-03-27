#!/bin/bash
echo -e "[File name : kex  location : /data/data/com.termux/files/home/kali-arm64/usr/bin or /usr/bin in kali ] <if you need edit it do it carefully!>
\n+=====***   KEX MENU   ***=====+\n\nTermux home : \n\tUsage : nethunter kex <option>\n\t<option> :   start    stop    status   kill ->(chance of error due to proc not mounted)                     restart reset \n\tExample : nethunter kex start"
echo -e "\n\nIn kali cmd (after type nethunter in termux) \n\tUsage: kex <option>\n\t<option> :   start    stop    status   kill ->(chance of error due to proc not mounted)                    restart reset \n\tExample ┌──(kali㉿localhost)-[~] └─$ :  kex start \n** start Kali NetHunter cli as root is not recommended in this script  \n\n=============================================================================================="

vnc_start() {
    if [ ! -f ~/.vnc/passwd ]; then
        vnc_passwd
    fi
    USR=$(whoami)
    if [ $USR = "root" ]; then
        SCR=:1
    else
        SCR=:2
    fi
    export USER=$USR; LD_PRELOAD=/usr/lib/aarch64-linux-gnu/libgcc_s.so.1 nohup vncserver $SCR >/dev/null 2>&1 </dev/null
}

vnc_stop() {
    vncserver -kill :*
    return $?
}

vnc_passwd() {
    vncpasswd
    return $?
}

vnc_status() {
    session_list=$(vncserver -list)
    if [[ $session_list == *"590"* ]]; then
        echo "$session_list"
    else
        echo "There is nothing to list :)"
        echo "You can start a new session by <<  vncserver -depth 24 -geometry 1920x1080 :1  >> after typing <<  nethunter  >>"
    fi
}

 vnc_kill() {
    pkill Xtigervnc
    return $?
}

vnc_restart() {
     cd ~/.vnc/
     rm -rf *.log *.pid
     cd /
     rm -rf /tmp/.X* /tmp/.xfsm* /tmp/.l2s* /tmp/.ICE-unix
     vnc_stop
     vnc_start
     vnc_status
echo "If no port number or display number displayed - only heading displayed - script failed at restarting "
}
vnc_reset() {
     cd ~/.vnc/
     rm -rf *.log *.pid
     cd /
     rm -rf /tmp/.X* /tmp/.xfsm* /tmp/.l2s* /tmp/.ICE-unix
echo "Cleaned files.New User : "
     vnc_passwd
}

function ask() {
    while true; do
    read -p "Do you want to restart kex [Y|y or N|n] :" REPLY
    case $REPLY in
        [Yy]* )
              vnc_restart
     vncserver -depth 24 -geometry 1920x1080 :1
              ;;
        [Nn]* )
              exit
              ;;
        * ) echo "Please answer yes or no.";;
    esac
    done
}



case "$1" in
    start)
        vnc_start
        vnc_status
        echo -e "\nIf you can't see PROCESS_ID or showing (stale) change SCR:2 to SCR:Any_Number in /use/bin/kex\n"
        ;;
    stop)
        vnc_stop
        ;;
    status)
        vnc_status
        ;;
    kill)
        vnc_kill
        ;;
    restart)
         vnc_restart
        ;;
       reset)
         vnc_reset
        ;;
    *)
     vncserver -depth 24 -geometry 1920x1080 :1
esac
