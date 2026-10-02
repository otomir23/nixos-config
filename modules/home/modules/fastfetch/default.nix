({ config, lib, ... }: let
  cfg = config.modules.fastfetch;
in {
  options.modules.fastfetch = {
    enable = lib.mkEnableOption "fastfetch configuration";
  };
  config = lib.mkIf cfg.enable {
    programs.fastfetch = {
      enable = true;
      settings = import ./settings.nix;
    };
  };
})
