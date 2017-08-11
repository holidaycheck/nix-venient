{ pkgs ? import <nixpkgs> {} }:

let
  inherit (pkgs) stdenv lib curl jq makeWrapper;
in
  stdenv.mkDerivation rec {

    version = "0.1";
    name = "nix-venient-${version}";
    src = builtins.filterSource (name: type: !lib.hasPrefix "result" (baseNameOf name) && name != ".git") ./.;

    nativeBuildInputs = [ makeWrapper ];
    buildPhase = ":";
    installPhase = ''
      mkdir -p $out/bin
      cp -R nix-venient lib $out/bin
      wrapProgram $out/bin/nix-venient --suffix PATH : ${lib.makeBinPath [ curl jq ]}
    '';
  }
