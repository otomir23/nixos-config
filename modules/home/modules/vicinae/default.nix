({ config, lib, ... }: let
  cfg = config.modules.vicinae;
in {
  options.modules.vicinae = {
    enable = lib.mkEnableOption "Vicinae launcher configuration";
  };
  config = lib.mkIf cfg.enable {
    programs.vicinae = {
      enable = true;
      systemd.enable = true;
      settings = import ./settings.nix;
      themes.terafox = import ./theme.nix;
    };
    wayland.windowManager.niri.settings.binds = lib.mkIf config.wayland.windowManager.niri.enable {
      "Mod+Space" = {
        _props.repeat = false;
        spawn = [ "vicinae" "toggle" ];
      };
      "Mod+V" = {
        _props.repeat = false;
        spawn = [ "vicinae" "vicinae://launch/clipboard/history" ];
      };
    };
  };
})
