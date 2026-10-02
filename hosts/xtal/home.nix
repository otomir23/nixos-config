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
      # dev
      android-studio
      androidenv.androidPkgs.platform-tools
      jetbrains-fleet
      jetbrains.webstorm
      jetbrains.idea
      # music
      ableton-live
      bitwig-studio
      tidaLuna
      easyeffects
      # art
      krita
      aseprite
      ligma
      blender
      # video
      davinci-resolve
      obs-studio
      ffmpeg
      # chat
      vesktop
      yukigram
      # gaming
      prismlauncher
      # misc
      qbittorrent
      wineWow64Packages.stableFull
      winetricks
    ];

    # [!] read doc before changing
    stateVersion = "25.05";
  };

  programs = {
    firefox = {
      enable = true;
      configPath = ".mozilla/firefox";
    };
    home-manager.enable = true;
  };
}
