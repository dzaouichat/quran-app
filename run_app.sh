#!/bin/bash
export DISPLAY=:0
export LD_LIBRARY_PATH=$(nix-build --no-out-link -E '(import <nixpkgs> {}).zlib')/lib:$LD_LIBRARY_PATH
cd quran_app/build/linux/x64/release/bundle
./quran_app