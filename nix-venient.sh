#!/usr/bin/env bash

VER=0.1
usage() {
    echo "nix-venient - $VER"
}

if [[ $# = 0 ]]; then
    usage
    exit 1
fi

case "$1" in
    "list-deps" )
        shift
        ./lib/list-deps $*
        exit $?
        ;;
    "nixpkgs-version" )
        shift
        ./lib/nixpkgs-version $*
        exit $?
        ;;
    "channel-rev" )
        shift
        ./lib/channel-rev $*
        exit $?
        ;;
    "channel-sha" )
        shift
        ./lib/channel-sha $*
        exit $?
        ;;
    "fetch-source" )
        shift
        ./lib/fetch-source $*
        exit $?
        ;;
    "install-from-channel" )
        shift
        ./lib/install-from-channel $*
        exit $?
        ;;
    "search" )
        shift
        ./lib/search $*
        exit $?
        ;;
esac
