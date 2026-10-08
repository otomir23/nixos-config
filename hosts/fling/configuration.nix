{ pkgs, ... }: {
  modules = {
    nix = {
      enable = true;
      substituters = [ "yukigram" ];
    };
    console = {
      enable = true;
      doubleScale = true;
    };
    intel-graphics.enable = true;
    plymouth.enable = true;
    fish.enable = true;
    sshd.enable = true;
    home.enable = true;
    desktop.enable = true;
    printing.enable = true;
    audio.enable = true;
    bluetooth.enable = true;
    steam.enable = true;
    tailscale.enable = true;
    mihomo = {
      enable = true;
      proxyProvidersFile = "/home/damir/.config/mihomo/proxy-providers.yaml";
    };
    locale = {
      enable = true;
      base = "en_US.UTF-8";
      extra = "ru_RU.UTF-8";
    };
    iwd = {
      enable = true;
      country = "RU";
    };
    fingerprint.enable = true;
  };

  # bootloader
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_7_2;
    kernelModules = [ "bunny" ];
    kernelParams = [
      "nvme.noacpi=1"
      "mem_sleep_default=deep"
    ];
  };

  # myself
  users.users.damir = {
    isNormalUser = true;
    description = "Damir Modyarov";
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };
  home-manager.users.damir = ./home.nix;

  # setting my time zone
  time.timeZone = "Europe/Moscow";

  # hardware stuff
  services.framework-control.enable = true;
  hardware.sensor.iio.enable = true;
  hardware.acpilight.enable = true;
  services.fstrim.enable = true;
  services.fwupd.enable = true;
  services.thermald.enable = true;
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "powersave";
  };

  # KDE Connect
  programs.kdeconnect.enable = true;

  # [!] read doc before changing
  system.stateVersion = "26.05";
}
