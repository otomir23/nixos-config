({ config, lib, ... }: let
  cfg = config.modules.shell;
in {
  options.modules.shell = {
    enable = lib.mkEnableOption "shell tools";
  };
  config = lib.mkIf cfg.enable {
    modules = {
      btop.enable = true;
      fastfetch.enable = true;
      helix.enable = true;
    };

    programs.eza = {
      enable = true;
      enableFishIntegration = true;
      icons = "auto";
      extraOptions = [ "-1" "--group-directories-first" "-a" ];
    };
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };
    programs.bat.enable = true;
    programs.ripgrep.enable = true;
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      plugins = [];
    };
  };
})
