Usage :$ > kex option 

           or

         > nethunter kex option


nethunter kex option : Command to directly start kex from termux

Option : start  stop  status  restart  reset  kill

Example : kex start
        

To start kex : kex start   

To stop kex : kex stop     

To check status : kex status

To restart by removing some files : kex restart

To reset kex by deleting files ~/.vnc/passwd: kex reset 


**If process id : some_number (stale) then do kex reset
**Using kill may return /proc mounted error



Example of successful kex running :

[File name : kex  location : /data/data/com.termux/files/home/kali-arm64/usr/bin or /usr/bin in kali ] <if you need edit it do it carefully!>

+=====***   KEX MENU   ***=====+

Termux home :
        Usage : nethunter kex <option>
        <option> :   start    stop    status   kill ->(chance of error due to proc not mounted)                     restart reset
        Example : nethunter kex start


In kali cmd (after type nethunter in termux)
        Usage: kex <option>
        <option> :   start    stop    status   kill ->(chance of error due to proc not mounted)                    restart reset
        Example ┌──(kali㉿localhost)-[~] └─$ :  kex start
** start Kali NetHunter cli as root is not recommended in this script

==============================================================================================

TigerVNC server sessions:

X DISPLAY #     RFB PORT #      PROCESS ID      SERVER
:2            5902            32064           Xtigervnc


