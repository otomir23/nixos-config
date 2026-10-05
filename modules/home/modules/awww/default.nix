({ config, lib, pkgs, ... }: let
  cfg = config.modules.awww;
  package = config.services.awww.package;
in {
  options.modules.awww = {
    enable = lib.mkEnableOption "wallpapers with awww";
  };
  config = lib.mkIf cfg.enable {
    services.awww = {
      enable = true;
      extraArgs = [ "--no-cache" ];
    };

    systemd.user.services.awww.Service.ExecStartPost = pkgs.writeShellScript "awww-wallpaper" ''
      ${lib.getExe package} img ${./wallpapers.png}
    '';
  };
})
