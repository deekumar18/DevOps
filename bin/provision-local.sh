#!/usr/bin/env bash

source ./DevOps/bin/_env.sh

ENV=${1:-sandbox}

echo "Building $ENV environment Vagrant instance"

cd DevOps/vagrant
vagrant up $ENV
vagrant provision $ENV
