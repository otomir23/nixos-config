({ config, lib, ... }: let
  cfg = config.modules.mako;
in {
  options.modules.mako = {
    enable = lib.mkEnableOption "Mako notification configuration";
  };
  config = lib.mkIf cfg.enable {
    services.mako = {
      enable = true;
      settings = {
        sort = "-time";
        background-color = "#00000090";
        border-size = 1;
        border-color = "#ffffff30";
        border-radius = 8;
        default-timeout = 5000;
        "mode=do-not-disturb".invisible = true;
      };
    };
  };
})
