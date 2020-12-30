# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./boot-loader
      ./hardware
      ./networking
      ./time
      ./internationalisation
      ./packages
      ./users
      ./podman
      ./programs
      ./services
      ./release
    ];
}
