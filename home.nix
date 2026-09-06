{ config, pkgs, herdr, ... }:

{
  home.username = "nixos";
  home.homeDirectory = "/home/nixos";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
  home.packages = with pkgs; [
    nodejs
    git
    ripgrep
    fd
    fzf
    jq
    lazygit
    herdr.packages.${pkgs.system}.default   
    claude-code
    codex
    opencode
  ];
  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history.size = 10000;
    history.save = 10000;
    history.ignoreDups = true;
  };

  programs.starship = {
    enable = true;
  };  
}
