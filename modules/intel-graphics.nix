({ config, lib, ... }: let
  cfg = config.modules.intel-graphics;
in {
  options.modules.intel-graphics = {
    enable = lib.mkEnableOption "Intel graphics drivers";
  };
  config = lib.mkIf cfg.enable {
    # starting drivers early
    boot = {
      initrd.kernelModules = [ "i915" ];
    };

    # load driver
    hardware.graphics.enable = true;
  };
})
