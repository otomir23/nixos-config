({ config, lib, ... }: let
  cfg = config.modules.zed;
in {
  options.modules.zed = {
    enable = lib.mkEnableOption "Zed editor configuration";
  };
  config = lib.mkIf cfg.enable {
    programs.zed-editor = {
      enable = true;
      extensions = [ "nix" "nvim-nightfox" ];
      userSettings = import ./settings.nix;
    };
  };
})
