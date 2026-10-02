({ pkgs, config, lib, ... }: let
  cfg = config.modules.audio;
in {
  options.modules.audio = {
    enable = lib.mkEnableOption "PipeWire audio and musnix tuning";
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
    musnix = {
      enable = true;
      rtcqs.enable = true;
    };
    boot.kernelParams = [ "threadirqs" "iommu=pt" ];
    environment.systemPackages = with pkgs; [
      wiremix
    ];
  };
})
