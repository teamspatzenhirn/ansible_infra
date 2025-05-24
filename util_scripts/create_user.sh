#! /bin/bash

set -e

read -p "First name: " first
read -p "Last name:  " last

first="${first,,}"
last="${last,,}"

username="${first}${last}"
displayname="${first^} ${last^}"
email="${first}.${last}@uni-ulm.de"

read -p "Is this email correct? ${email} [Y/n] " yesno
case $yesno in
  [Nn]* )
    read -p "Enter the correct email: " email
  ;;
esac

kanidm person create -D idm_admin $username "$displayname" > /dev/null
kanidm person update -D idm_admin $username --mail "$email" > /dev/null
kanidm person posix set -D idm_admin $username > /dev/null

read -p "Generate reset token? [y/N] " yesno
case $yesno in
  [Yy]* )
    kanidm person credential create-reset-token -D idm_admin $username 43200
  ;;
esac

user_dir="/u/${username}"
if [ -d "$user_dir" ]; then
  echo "Ensuring home directory permissions are correct."
  sudo chown -R $username:users "$user_dir"
fi

echo "User creation complete."
