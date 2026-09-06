{ config, lib, pkgs, herdr, ... }:

{
 
  wsl.enable = true;
  wsl.defaultUser = "nixos";
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "26.05";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  programs.zsh.enable = true;
  users.users.nixos.shell = pkgs.zsh;
  home-manager.useGlobalPkgs = true; 
  home-manager.extraSpecialArgs = {
   inherit herdr;
  };

  home-manager.users.nixos = import ./home.nix;
}
