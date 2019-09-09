#!/usr/bin/env bash

# Build Info
export ENTITY_NAME=revive
export GIT_COMMIT=$(git rev-parse HEAD)

# Zscaler Tricks
ZSCALER_CERT=/etc/ssl/certs/zscaler.pem
if [ -f $ZSCALER_CERT ]; then
  export AWS_CA_BUNDLE=$ZSCALER_CERT
  export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
fi

function banner() {
  echo "CMG Online revive Builder"
  echo "========================="
  echo "BUILD INFO"
  echo "* ENTITY_NAME: $ENTITY_NAME"
  echo "* VERSION: $VERSION"
  echo "* GIT_COMMIT: $GIT_COMMIT"
  echo
  echo "ZSCALER TRICKS"
  echo "* AWS_CA_BUNDLE: $AWS_CA_BUNDLE"
  echo "* OBJC_DISABLE_INITIALIZE_FORK_SAFETY: $OBJC_DISABLE_INITIALIZE_FORK_SAFETY"
  echo
}

function get_workspace() {
  local workspace="dev-sandbox-vpc"

  case "$ENV" in
    sandbox)
      workspace="dev-$ENV-vpc"
      ;;
    test)
      workspace="dev-$ENV-vpc"
      ;;
    ithc)
      workspace="dev-ithc-env"
      ;;
    staging)
      workspace="prod-$ENV-vpc"
      ;;
    production)
      workspace="prod-$ENV-vpc"
      ;;
  esac

  echo "$workspace"
}

function get_resource_prefix() {
  local resource_prefix="ds"

  case "$ENV" in
    sandbox)
      resource_prefix="ds"
      ;;
    test)
      resource_prefix="dt"
      ;;
    ithc)
      resource_prefix="di"
      ;;
    staging)
      resource_prefix="ps"
      ;;
    production)
      resource_prefix="pp"
      ;;
  esac

  echo "$resource_prefix"
}

banner

echo "Clearing SSH Agent"
ssh-add -D