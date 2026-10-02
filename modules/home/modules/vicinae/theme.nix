{
  meta = {
    version = 1;
    name = "Terafox";
    description = "A dark green-blue Terafox theme with restrained orange accents.";
    variant = "dark";
    inherits = "vicinae-dark";
  };
  colors = {
    core = {
      accent = "#7aa4a1";
      accent_foreground = "#0f1c1e";
      background = "#152528";
      foreground = "#e6eaea";
      secondary_background = "#0f1c1e";
      border = "#2d4f56";
    };
    main_window = {
      border = "#2d4f56";
      footer.background = "colors.core.secondary_background";
    };
    settings_window.border = "#2d4f56";
    accents = {
      blue = "#5a93aa";
      green = "#7aa4a1";
      magenta = "#ad5c7c";
      orange = "#ff8349";
      purple = "#ad5c7c";
      red = "#e85c51";
      yellow = "#fda47f";
      cyan = "#a1cdd8";
    };
    shortcut.border = "colors.core.border";
    text = {
      default = "colors.core.foreground";
      muted = "#6d7f8b";
      danger = "colors.accents.red";
      success = "colors.accents.green";
      placeholder = "#587b7b";
      selection = { background = "#425e5e"; foreground = "#eaeeee"; };
      links = { default = "#a1cdd8"; visited = "#cb7985"; };
    };
    input = {
      border = "#2d4f56";
      border_focus = "#ff8349";
      border_error = "colors.accents.red";
    };
    button.primary = {
      background = "#1d3337";
      foreground = "#eaeeee";
      hover.background = "#254147";
      focus.outline = "colors.core.accent";
    };
    list.item = {
      hover = { foreground = "#eaeeee"; secondary_foreground = "#cbd9d8"; };
      selection = {
        background = "#425e5e";
        foreground = "#eaeeee";
        secondary_background = "#293e40";
        secondary_foreground = "#cbd9d8";
      };
    };
    grid.item = {
      background = "#1d3337";
      hover.outline = "#7aa4a1";
      selection.outline = "#a1cdd8";
    };
    scrollbars.background = "#2d4f56";
    loading = { bar = "#ff8349"; spinner = "#eaeeee"; };
  };
}
