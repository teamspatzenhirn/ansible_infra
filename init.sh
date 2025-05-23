#!/bin/bash

# Create "ansible" user
adduser --disabled-password --gecos '' ansible
cat <<EOF > /etc/sudoers.d/ansible
# Allow ansible to use sudo without a password
ansible ALL=(ALL:ALL) NOPASSWD: ALL
EOF

# Grant passwordless sudo rights to the "ansible" user
chmod 0440 /etc/sudoers.d/ansible

# Install SSH keys for the "ansible" user
mkdir /home/ansible/.ssh
chown ansible:ansible /home/ansible/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILM0Um7JeUdTZWasgK8iIzgZL5eB7Y1xRG3wIT4QL3mr ansible" > /home/ansible/.ssh/authorized_keys

apt-get update

# Install python-minimal for Ansible
apt-get -y install python3

apt-get -y install openssh-server

sed -i "s/#Port 22/Port 2244/g" /etc/ssh/sshd_config
systemctl enable ssh
systemctl restart ssh
