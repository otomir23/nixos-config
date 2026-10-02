({ config, lib, pkgs, ... }: let
  cfg = config.modules.iwd;
in {
  options.modules.iwd = {
    enable = lib.mkEnableOption "iNet wireless daemon";
    country = lib.mkOption {
      description = "Two-letter uppercase country code for device region";
      type = lib.types.str;
    };
  };
  config = lib.mkIf cfg.enable {
    networking = {
      networkmanager.enable = false;
      wireless = {
        iwd = {
          enable = true;

          settings = {
            General = {
              AddressRandomization = "disabled";
              Country = cfg.country;
            };
            Network = {
              EnableIPv6 = false;
            };
            Settings = {
              AutoConnect = true;
            };
          };
        };
      };
    };
    boot.extraModprobeConfig = ''
      options iwlwifi bt_coex_active=N
      options iwlwifi power_save=N
      options iwlmvm power_scheme=1
    '';
    environment.systemPackages = with pkgs; [
      impala
    ];
  };
})
