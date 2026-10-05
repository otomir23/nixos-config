({ config, lib, ... }: let
  cfg = config.modules.helix;
in {
  options.modules.helix = {
    enable = lib.mkEnableOption "Helix with the Terafox theme";
  };
  config = lib.mkIf cfg.enable {
    programs.helix = {
      enable = true;
      settings.theme = "terafox";
      themes.terafox = import ./theme.nix;
    };
    home.sessionVariables.EDITOR = "hx";
  };
})
