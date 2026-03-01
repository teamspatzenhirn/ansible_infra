#!/bin/bash

# install curl if not available yet
if ! command -v curl >/dev/null 2>&1
then
    sudo apt-get -y install curl
fi

# install script that downloads and executes ssh-vnc.sh as executable
cat >/usr/local/bin/ssh-vnc <<EOL
#!/bin/bash
curl -Ls https://raw.githubusercontent.com/teamspatzenhirn/ansible_infra/refs/heads/main/ssh-vnc/ssh-vnc.sh | bash -s -- "$@"
EOL
chmod +x /usr/local/bin/ssh-vnc
