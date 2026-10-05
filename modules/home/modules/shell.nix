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
      icons = "auto";
      extraOptions = [ "-1" "--group-directories-first" "-a" ];
    };
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    programs.zoxide.enable = true;
    programs.bat.enable = true;
    programs.ripgrep.enable = true;
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set fish_greeting # Disable greeting
      '';
      plugins = [];
    };
    home.shell.enableFishIntegration = true;
  };
})
