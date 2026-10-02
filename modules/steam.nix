({ config, lib, ... }: let
  cfg = config.modules.steam;
in {
  options.modules.steam = {
    enable = lib.mkEnableOption "Steam";
  };
  config = lib.mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
})
