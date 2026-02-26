{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = [ pkgs.cmake pkgs.flutter pkgs.zlib pkgs.glibc ];
}