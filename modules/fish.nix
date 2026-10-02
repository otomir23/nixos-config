({ config, lib, pkgs, ... }: let
  cfg = config.modules.fish;
in {
  options.modules.fish = {
    enable = lib.mkEnableOption "fish shell";
  };
  config = lib.mkIf cfg.enable {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
        ${pkgs.any-nix-shell}/bin/any-nix-shell fish --info-right | source
      '';
    };
  };
})
