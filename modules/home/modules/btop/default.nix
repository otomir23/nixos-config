({ config, lib, ... }: let
  cfg = config.modules.btop;
  theme = import ./theme.nix;
in {
  options.modules.btop = {
    enable = lib.mkEnableOption "btop with the Terafox theme";
  };
  config = lib.mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "terafox";
        theme_background = false;
      };
      themes.terafox = lib.generators.toKeyValue {
        mkKeyValue = name: value: "theme[${name}]=${builtins.toJSON value}";
      } theme;
    };
  };
})
