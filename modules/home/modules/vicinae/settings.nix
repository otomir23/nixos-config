{
  "$schema" = "https://vicinae.com/schemas/config.json";
  pop_to_root_on_close = true;
  wrap_navigation = true;
  font.normal = {
    family = "Aporetic Sans";
    size = 10.5;
  };
  theme.dark = {
    name = "terafox";
    icon_theme = "Bibata-Modern-Classic";
  };
  launcher_window = {
    rounding = 16;
    opacity = 0.85;
    compact_mode.enabled = true;
  };
  favorites = [
    "applications:helium"
    "applications:io.github.yukigram"
    "@knoopx/store.vicinae.nix:packages"
    "clipboard:history"
  ];
  providers = {
    applications.entrypoints = {
      ableton-live.alias = "ableton";
      helium.alias = "browser";
      "io.github.yukigram".alias = "telegram";
      vesktop.alias = "discord";
    };
    core.entrypoints.sponsor.enabled = false;
    system.entrypoints.browse-apps.enabled = true;
  };
}
