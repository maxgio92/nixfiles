{ pkgs, ... }:
{

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim
    firefox brave
    tmux
    spotify
    gnumake
    gnupg
    kubectl kustomize
  ];

  # Some programs need SUID wrappers, can be configured further or are
}
