#!/usr/bin/env bash

display_usage() {
  echo "Please specify the environment you want to build for"
  echo -e "\nUsage: ./DevOps/bin/build.sh [environment] \n"
}

if [  $# -le 0 ]
then
  display_usage
  exit 1
fi

export ENV=$1
export VERSION=`date +"%Y.%m.%d"`

source ./DevOps/bin/_env.sh

export WORKSPACE=$(get_workspace)
export RESOURCE_PREFIX=$(get_resource_prefix)

timestamp=$(date +%s)

# . bin/install.sh
packer build \
  -var "env=$ENV" \
  -var "entity_name=$ENTITY_NAME" \
  -var "timestamp=$timestamp" \
  -var "workspace=$WORKSPACE" \
  -var "version=$VERSION-$BUILD_NUMBER" \
  ./DevOps/packer/$ENTITY_NAME.json