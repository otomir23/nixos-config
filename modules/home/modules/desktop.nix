({ config, lib, pkgs, ... }: let
  cfg = config.modules.desktop;
in {
  options.modules.desktop = {
    enable = lib.mkEnableOption "desktop programs, appearance and services";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      # theme
      bibata-cursors
      aporetic # system font
      noto-fonts-cjk-sans
      # controls
      playerctl
      brightnessctl
      # basic apps
      helium
      mpv
      nautilus
      nautilus-open-any-terminal
      kdePackages.kcalc
      kdePackages.kate
      gnome-font-viewer
      libreoffice-qt
    ];

    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Aporetic Sans" ];
        serif = [ "Aporetic Serif" ];
        monospace = [ "Aporetic Sans Mono" ];
      };
    };

    modules = {
      awww.enable = true;
      niri.enable = true;
      ghostty.enable = true;
      mako.enable = true;
      vicinae.enable = true;
      zed.enable = true;
    };

    gtk = let
      settings = {
        gtk-enable-primary-paste = false;
        gtk-application-prefer-dark-theme = true;
      };
      formatGtk2Option =
        n: v:
        let
          v' =
            if lib.isBool v then
              lib.boolToString v
            else if lib.isString v then
              ''"${v}"''
            else
              toString v;
        in
          "${lib.escape [ "=" ] n} = ${v'}";
      gtk2Settings = lib.concatMapStrings (n: "${formatGtk2Option n settings.${n}}\n") (
        lib.attrNames settings
      );
      theme = {
        name = "Terafox";
        package = pkgs.nightfox-gtk-theme;
      };
    in {
      enable = true;
      theme = theme;
      font.name = "sans-serif";
      gtk2.extraConfig = gtk2Settings;
      gtk3.extraConfig = settings;
      gtk4 = {
        theme = theme;
        extraConfig = settings;
      };
    };
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
    };

    systemd.user.tmpfiles.rules = [
      "e %h/Downloads - - - 1w"
    ];
  };
})
