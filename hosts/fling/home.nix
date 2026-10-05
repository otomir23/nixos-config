{ pkgs, ... }: {
  modules = {
    shell.enable = true;
    development.enable = true;
    desktop.enable = true;
    rbw.enable = true;
  };

  services = {
    figma-agent.enable = true;
    kdeconnect.enable = true;
  };

  home = {
    username = "damir";
    homeDirectory = "/home/damir";

    packages = with pkgs; [
      # music
      tidaLuna
      easyeffects
      # art
      krita
      aseprite
      ligma
      # video
      obs-studio
      ffmpeg
      # chat
      vesktop
      yukigram
      # gaming
      prismlauncher
      # misc
      qbittorrent
    ];

    # [!] read doc before changing
    stateVersion = "26.05";
  };

  programs = {
    firefox.enable = true;
    home-manager.enable = true;
  };
}
