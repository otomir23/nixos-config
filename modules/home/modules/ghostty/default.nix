({ config, lib, ... }: let
  cfg = config.modules.ghostty;
in {
  options.modules.ghostty = {
    enable = lib.mkEnableOption "Ghostty configuration";
  };
  config = lib.mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      settings = {
        background-opacity = 0.85;
        background-blur = true;
        theme = "Terafox";
        window-padding-x = 8;
        window-padding-y = 8;
        font-family = "monospace";
      };
    };
    wayland.windowManager.niri.settings.binds = lib.mkIf config.wayland.windowManager.niri.enable {
      "Mod+T" = {
        _props.hotkey-overlay-title = "Open a Terminal";
        spawn-sh = "ghostty +new-window";
      };
    };
  };
})
