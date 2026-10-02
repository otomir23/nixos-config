({ config, lib, pkgs, ... }: let
  cfg = config.modules.console;
in {
  options.modules.console = {
    enable = lib.mkEnableOption "console configuration with Cozette and Colemak";
    doubleScale = lib.mkOption {
      description = "Use 12x26 version of Cozette.";
      default = false;
      type = lib.types.bool;
    };
  };
  config = lib.mkIf cfg.enable {
    console = {
      earlySetup = true;
      font = let
        scale = if cfg.doubleScale then "12x26" else "6x13";
      in "${pkgs.cozette}/share/consolefonts/cozette${scale}.psfu";
      packages = [ pkgs.cozette ];
      keyMap = "colemak";
    };
  };
})
