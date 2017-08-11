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
esac

nix-package-search() {
  # Originaly from: https://www.reddit.com/r/NixOS/comments/5yxt45/simple_nix_package_search/
  local CACHE="$HOME/.cache/nq-cache"
  if ! ( [ -e $CACHE ] && [ $(stat -c %Y $CACHE) -gt $(( $(date +%s) - 3600*24*7 )) ] ); then
          echo "update cache" 1>&2
          nice nix-env -qa --file "<nixpkgs>" --json > "$CACHE"
  fi
  jq -r 'to_entries | .[] | .key + "|" + .value.meta.description' < "$CACHE" |
    {
       if [ $# -gt 0 ]; then
          # double grep because coloring breaks column's char count
          # $* so that we include spaces (could do .* instead?)
            grep -i "$*" | column -t -s "|" | grep --color=always -i "$*"
       else
            column -t -s "|"
       fi
    }
}
