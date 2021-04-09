{ pkgs, ... }:
{

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim
    firefox
    tmux
    spotify
    gnumake
    gnupg
  ];

  # Some programs need SUID wrappers, can be configured further or are
}
