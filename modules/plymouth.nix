({ config, lib, ... }: let
  cfg = config.modules.plymouth;
in {
  options.modules.plymouth = {
    enable = lib.mkEnableOption "Plymouth boot screen";
  };
  config = lib.mkIf cfg.enable {
    boot = {
      plymouth = {
        enable = true;
      };
      consoleLogLevel = 3;
      initrd = {
        verbose = false;
      };
      kernelParams = [
        "quiet"
        "rd.udev.log_level=3"
        "rd.systemd.show_status=auto"
      ];
    };
  };
})
