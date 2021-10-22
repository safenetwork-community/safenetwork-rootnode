#!/bin/sh

PLATFORM_ARCH=`uname -m`

case "$PLATFORM_ARCH" in
  "armv7l")
  PLATFORM_ARCH="armv7-unknown-linux-musleabihf"
  ;;
  "armv6l")
  PLATFORM_ARCH="arm-unknown-linux-musleabi"
  ;;
  *)
  PLATFORM_ARCH=$PLATFORM_ARCH"-unknown-linux-musl"
  ;;
esac

# Add new paltform if unknown.
echo $PLATFORM_ARCH

# Create safe folders
mkdir -p ~/.safe/cli

# Install the safe network command line interface
curl -L $(curl --silent https://api.github.com/repos/maidsafe/sn_cli/releases/latest | \
  jq --arg PLATFORM_ARCH "$PLATFORM_ARCH" \
  -r '.assets[] | select(.name | endswith($PLATFORM_ARCH+".tar.gz")).browser_download_url') | \
  tar xz -C ~/.safe/

# Add .bashrc and .bash_profile
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/dev/src/shared_files/.bash_profile -o ~/.bash_profile
RUN curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/dev/src/shared_files/.bashrc -o ~/.bashrc
