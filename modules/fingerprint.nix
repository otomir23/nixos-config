({ config, lib, ... }: let
  cfg = config.modules.fingerprint;
in {
  options.modules.fingerprint = {
    enable = lib.mkEnableOption "fingerprint unlock";
  };
  config = lib.mkIf cfg.enable {
    services.fprintd.enable = true;
    security.pam.services.login.fprintAuth = true;
  };
})
