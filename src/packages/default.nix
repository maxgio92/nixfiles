{ pkgs, ... }:
{

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bind
    firefox brave
    gcc
    gnumake
    gnupg
    go
    kubectl kustomize k9s kind
	pciutils
    spotify
    tmux
    wget vim
  ];

  # Some programs need SUID wrappers, can be configured further or are
}
