#! /bin/bash

set -e

kanidm_user="idm_admin"

read -p "First name:  " first
read -p "Last name:   " last

first="${first,,}"
last="${last,,}"

username="${first}${last}"
displayname="${first^} ${last^}"
email="${first}.${last}@uni-ulm.de"

echo "Username:    ${username}"
echo "Displayname: ${displayname}"

read -p "Is this email correct? ${email} [Y/n] " yesno
case $yesno in
  [Nn]* )
    read -p "Enter the correct email: " email
  ;;
esac

kanidm person create -D $kanidm_user $username "$displayname" > /dev/null
kanidm person update -D $kanidm_user $username --mail "$email" > /dev/null
kanidm person posix set -D $kanidm_user $username > /dev/null

read -p "Generate reset token? [y/N] " yesno
case $yesno in
  [Yy]* )
    kanidm person credential create-reset-token -D $kanidm_user $username 43200
  ;;
esac

user_dir="/u/${username}"
if [ -d "$user_dir" ]; then
  echo "Ensuring home directory permissions are correct (this can take a while for existing users)"
else
  echo "Generating new home directory from /opt/skel"
  sudo cp -R /opt/skel "$user_dir"

  ssh_dir="${user_dir}/.ssh"
  echo "Generating spatz pc ssh key and adding it to the user"
  sudo mkdir "$ssh_dir"
  sudo chmod 700 "$ssh_dir"
  sudo ssh-keygen -t ed25519 -f "${ssh_dir}/id_spatz" -N "" -C "${username}@SpatzPCs" > /dev/null

  pubkey=$(cat "${ssh_dir}/id_spatz.pub" | cut -d ' ' -f 1,2)
  kanidm person ssh add-publickey -D $kanidm_user $username "Spatz PCs" "$pubkey" > /dev/null
fi

sudo chown -R $username:users "$user_dir"

echo "User creation complete"
