{ pkgs, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim
  # firefox
    tmux
  ];

  # Some programs need SUID wrappers, can be configured further or are
}
