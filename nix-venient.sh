#!/usr/bin/env bash

VERSION="0.1"

usage() {
    echo "Usage: nix-venient <command> <args>"
    echo ""
    echo "  list-deps             - list dependencies of a package"
    echo "  nixpkgs-version       - get version of <nixpkgs>"
    echo "  channel-rev           - get git revision of a channel"
    echo "  channel-sha           - get SHA of a channel"
    echo "  fetch-source          - fetch sources of a package"
    echo "  install-from-channel  - install package from a given channel"
    echo "  search                - search for a package in <nixpkgs>"
    echo "  version               - print version"
    echo ""
    echo "For additional information try 'nix-venient <command> --help'"
}

if [[ $# = 0 ]]; then
    usage
    exit 1
fi

case "$1" in
    "version" )
        echo "nix-venient ${VERSION}"
        exit 1
        ;;
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
    "*")
        usage
esac
