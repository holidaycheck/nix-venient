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
esac

nix-install-from-channel() {
  local _channel="$1"
  local _pkg="$2"

  nix-env -f http://nixos.org/channels/"$_channel"/nixexprs.tar.xz -i "$_pkg"; 
}

nix-get-sources() {
  local _pkg="$1"
  local _output=$(nix-build '<nixpkgs>' -A "$_pkg".src --no-out-link | xargs basename | cut -f 2- -d "-")

  nix-build '<nixpkgs>' -A "$_pkg".src -o "$_output"
}

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
