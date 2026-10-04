({ config, lib, ... }: let
  cfg = config.modules.desktop;
in {
  options.modules.desktop = {
    enable = lib.mkEnableOption "Niri desktop and supporting system services";
  };
  config = lib.mkIf cfg.enable {
    programs.niri.enable = true;

    services = {
      displayManager.ly = {
        enable = true;
        x11Support = true;
      };
      xserver.xkb = {
        layout = "us,ru";
        variant = "colemak,";
        options = "grp:none";
      };
      earlyoom = {
        enable = true;
        enableNotifications = true;
      };
    };

    systemd.services.display-manager.environment.XDG_CURRENT_DESKTOP = "X-NIXOS-SYSTEMD-AWARE";
  };
})
