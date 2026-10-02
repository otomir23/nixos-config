({ config, lib, ... }: let
  cfg = config.modules.sshd;
in {
  options.modules.sshd = {
    enable = lib.mkEnableOption "OpenSSH daemon";
  };
  config = lib.mkIf cfg.enable {
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
      };
    };
    users.users = {
      damir.openssh.authorizedKeys.keyFiles = [ ./keys/damir.pub ];
    };
  };
})
