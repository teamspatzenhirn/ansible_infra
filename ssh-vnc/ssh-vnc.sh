#!/bin/bash

# Team Spatzenhirn - VNC via SSH (ssh-vnc)
# Variant for Linux using bash 
# !WARNING!: developed to be used with bash/zsh with GNOME/XFCE, 
# other setups may work but are not officially supported)
# This script has a Windows/PowerShell counterpart in ssh-vnc.ps1
# Both scripts follow a common structure / enumeration
# !IMPORTANT!: When updating: Please update both variants accordingly
# Linux and Windows variant are meant to work as similar as possible!
#
# --------------------------------------
# 1. Specify Arguments and Usage Message
usage() { 
    echo "Usage: ssh-vnc [-p port] [-u user] [-h host] [-d display] [-f fqdn]" 1>&2; exit 1; 
}

# --------------------------------------
# 2. Download / Install VNCviewer if not available
if ! command -v vncviewer >/dev/null 2>&1
then
    sudo apt-get -y install tigervnc-viewer 
fi

# --------------------------------------
# 3. Download Dependencies

# --------------------------------------
# 4. Specify Default Values
ruser=$USER

hosts=(pc05 pc06 pc07 pc08)
reachable=()
for host in "${hosts[@]}"; do
    if ping -c1 -W1 "$host.spatz.wtf" >/dev/null; then
        reachable+=( "$host" )
    fi
done
rhost=$(shuf -n1 -e "${reachable[@]}")

display=$(shuf -i 2-9 -n 1)

# --------------------------------------
# 5. Parse Arguments
while getopts ":p:u:h:d:f:" o; do
    case "${o}" in
        p)
            port=${OPTARG}
            ;;
        u)
            ruser=${OPTARG}
            ;;
	    h)
            rhost=${OPTARG}
	        ;;
	    d)
            display=${OPTARG}
	        ;;
	    f)
            fqdn=${OPTARG}
	        ;;
        *)
            usage
            ;;
    esac
done

# --------------------------------------
# 6. Complete Arguments with Defaults
if [ -z ${port+x} ];
then
    port='590'${display}
fi

if [ -z ${fqdn+x} ];
then
    fqdn=${rhost}'.spatz.wtf'
fi

# --------------------------------------
# 7. Start VNCserver via SSH in separate process / window
sshcommand="ssh -t -t -L ${port}:localhost:${port} -p2244 ${ruser}@${fqdn} 'vncserver -fg -nolock -rfbport ${port}' || sleep 10"
x-terminal-emulator -e "$sshcommand" &
sleep 1

# --------------------------------------
# 8. Setup Handling for Closing / Termination
kill_ssh () {
    kill $(pgrep -f "${sshcommand}") 2>/dev/null
    exit
}
trap kill_ssh INT

# --------------------------------------
# 9. Wait for VNCserver / Port Forwarding to be running
until timeout 1 bash -c "</dev/tcp/localhost/${port}" 2>/dev/null ; do
    echo "waiting for vncserver"
    sleep 2
done
sleep 1

# --------------------------------------
# 10. Start VNCviewer
vncviewer localhost:$port

# --------------------------------------
# 11. Kill SSH process and Exit
kill_ssh
