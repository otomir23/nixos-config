({ pkgs, config, lib, ... }: let
  cfg = config.modules.development;
in {
  options.modules.development = {
    enable = lib.mkEnableOption "Git and development tools";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      nil
      nixd
      nodejs
      pnpm
      yarn-berry
      glab
      stdenv.cc
    ];

    programs.difftastic = {
      enable = true;
      git.enable = true;
    };
    programs.git = {
      enable = true;
      settings = {
        user = {
          email = "damir@otomir23.me";
          name = "Damir Modyarov";
        };
        init = {
          defaultBranch = "main";
        };
      };
      signing = {
        signByDefault = true;
        format = "ssh";
        key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFcJsd0Tn7nKCo7HkoLxHqazhX3hCFgwCy2J/8dkLym6";
      };
    };
    programs.gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
      };
    };
  };
})
