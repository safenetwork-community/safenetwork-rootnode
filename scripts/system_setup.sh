#!/bin/bash

# Nvim support files
mkdir -p /usr/local/share/lua/5.1
curl -s https://raw.githubusercontent.com/safenetwork-community/safenetwork-dockerfiles/ubuntu/src/shared_files/.config/nvim/lua/keymappings.lua -o /usr/local/share/lua/5.1/keymappings.lua
