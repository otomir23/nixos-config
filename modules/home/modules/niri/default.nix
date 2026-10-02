({ config, lib, ... }: let
  cfg = config.modules.niri;
in {
  options.modules.niri = {
    enable = lib.mkEnableOption "niri configuration";
  };
  config = lib.mkIf cfg.enable {
    wayland.windowManager.niri = {
      enable = true;
      checkConfig = true;
      settings = import ./settings.nix;
    };
  };
})
