#! /bin/bash

set -e

read -p "Username: " username
kanidm person credential create-reset-token -D idm_admin $username 43200
