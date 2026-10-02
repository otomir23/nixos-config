({ config, lib, pkgs, ... }: let
  cfg = config.services.figma-agent;
in {
  options.services.figma-agent = {
    enable = lib.mkEnableOption "Figma Agent user service";
  };
  config = lib.mkIf cfg.enable {
    systemd.user.services.figma-agent = {
      Unit.Description = "Figma Agent";
      Service = {
        ExecStart = "${pkgs.figma-agent}/bin/figma-agent";
        Restart = "on-failure";
      };
      Install.WantedBy = [ "default.target" ];
    };
  };
})
