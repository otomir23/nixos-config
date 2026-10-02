({ pkgs, config, lib, ... }: let
  cfg = config.modules.rbw;
in {
  options.modules.rbw = {
    enable = lib.mkEnableOption "unofficial bitwarden cli";
  };
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      pinentry-qt
    ];

    programs.rbw.enable = true;
    home.sessionVariables.SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/rbw/ssh-agent-socket";
  };
})
