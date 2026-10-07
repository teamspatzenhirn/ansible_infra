#! /bin/bash

set -e

read -p "Username: " username
kanidm person credential create-reset-token -D idm_admin --ttl 43200 $username
