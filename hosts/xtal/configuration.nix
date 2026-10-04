{ pkgs, ... }: {
  modules = {
    nix = {
      enable = true;
      substituters = [ "yukigram" ];
    };
    console.enable = true;
    nvidia.enable = true;
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
      perfomance = true;
    };
  };

  # bootloader stuff
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "max";
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxKernel.packages.linux_7_2;
    kernelModules = [ "bunny" ];
  };

  # myself
  users.users.damir = {
    isNormalUser = true;
    description = "Damir Modyarov";
    extraGroups = [ "wheel" "kvm" "dialout" "audio" ];
    shell = pkgs.fish;
  };
  home-manager.users.damir = ./home.nix;

  # setting my time zone
  time.timeZone = "Europe/Moscow";

  # hardware stuff
  hardware.graphics.enable = true;
  powerManagement.cpuFreqGovernor = "performance";
  services.udev.packages = [ pkgs.keychron-udev-rules ];

  # KDE Connect
  programs.kdeconnect.enable = true;

  # [!] read doc before changing
  system.stateVersion = "25.05";
}
