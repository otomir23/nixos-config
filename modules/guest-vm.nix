({ config, lib, ... }: let
  cfg = config.modules.guest;
in {
  options.modules.guest = {
    enable = lib.mkEnableOption "NixOS configuraton for hosts inside guest VMs";
  };
  config = lib.mkIf cfg.enable {
    security.pam.services.login.allowNullPassword = true;
    security.pam.services.sshd.allowNullPassword = true;
    users.users = {
      root.password = lib.mkForce "insecure";
      vm = {
        isNormalUser = true;
        description = "Virtual Machine Test User";
        extraGroups = [ "networkmanager" "wheel" ];
        password = lib.mkForce "insecure";
      };
    };
    virtualisation.vmVariant = {
      virtualisation = {
        graphics = false;
      };
    };
  };
})
