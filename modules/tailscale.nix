({ config, lib, ... }: let
  cfg = config.modules.tailscale;
in {
  options.modules.tailscale = {
    enable = lib.mkEnableOption "Tailscale networking";
  };
  config = lib.mkIf cfg.enable {
    services.tailscale.enable = true;
  };
})
