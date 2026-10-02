({ config, lib, ... }: let
  cfg = config.modules.nvidia;
in {
  options.modules.nvidia = {
    enable = lib.mkEnableOption "NVIDIA drivers and CUDA";
  };
  config = lib.mkIf cfg.enable {
    # starting drivers early
    boot = {
      initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
      kernelParams = [ "nvidia-drm.fbdev=1" ];
    };

    # load driver for Xorg and Wayland
    services.xserver.videoDrivers = ["nvidia"];
    hardware.nvidia = {
      modesetting.enable = true;
      open = true;
      nvidiaSettings = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    # CUDA support & cache for it
    nix.settings = {
      substituters = [
        "https://cache.nixos-cuda.org"
      ];
      trusted-public-keys = [
        "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      ];
    };
    nixpkgs.config.cudaSupport = true;
  };
})
