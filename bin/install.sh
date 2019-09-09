#!/usr/bin/env bash

source ./DevOps/bin/_env.sh

if ! [ -x "$(command -v pip)" ]; then
  echo 'Error: Python Pip is not installed. Please install this first' >&2
  exit 1
fi

if [ -f /etc/ssl/certs/zscaler.pem ]; then
  pip config set global.cert /etc/ssl/certs/zscaler.pem
  trustedHosts="--trusted-host pypi.python.org --trusted-host files.pythonhosted.org --trusted-host pypi.org"
fi

pip install -r DevOps/requirements.txt $trustedHosts --user
ansible-galaxy install -r DevOps/requirements.yml -c -p ./DevOps/ansible/playbooks/roles --force
