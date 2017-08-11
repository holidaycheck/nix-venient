# nix-venient

![travis-status](https://travis-ci.org/holidaycheck/nix-venient.svg?branch=master)

Provides a collection of convenient functions for working with nix and nixpkgs.

### Installation

The easiest way is to install it via nix:

```
$ git clone https://github.com/holidaycheck/nix-venient.git
$ nix-env -f . -i
```

### Usage

```
$ nix-venient
Usage: nix-venient <command> <args>

  list-deps             - list dependencies of a package
  nixpkgs-version       - get version of <nixpkgs>
  channel-rev           - get git revision of a channel
  channel-sha           - get SHA of a channel
  fetch-source          - fetch sources of a package
  install-from-channel  - install package from a given channel
  search                - search for a package in <nixpkgs>
  version               - print version

For additional information try 'nix-venient <command> --help'
```
