({ pkgs, config, lib, ... }: let
  cfg = config.modules.audio;
in {
  options.modules.audio = {
    enable = lib.mkEnableOption "PipeWire audio and musnix tuning";
    perfomance = lib.mkOption {
      description = "Optimize for perfomance at the cost of power efficency.";
      default = false;
      type = lib.types.bool;
    };
  };
  config = lib.mkIf cfg.enable {
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    musnix = lib.mkIf cfg.perfomance {
      enable = true;
      rtcqs.enable = true;
    };
    boot.kernelParams = lib.mkIf cfg.perfomance [ "threadirqs" "iommu=pt" ];
    environment.systemPackages = with pkgs; [
      wiremix
    ];
  };
})
