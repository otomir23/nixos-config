{
  inlay_hints = {
    enabled = true;
  };
  hour_format = "hour24";
  auto_update = false;
  base_keymap = "JetBrains";
  theme = {
    mode = "system";
    light = "Ayu Light";
    dark = "Terafox - blurred";
  };
  ui_font_family = "Aporetic Sans";
  buffer_font_family = "Aporetic Sans Mono";
  lsp = {
    nix = {
      binary = {
        path_lookup = true;
      };
    };
  };
  load_direnv = "shell_hook";
  ui_font_size = 14;
  buffer_font_size = 14;
}
