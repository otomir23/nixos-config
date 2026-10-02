{
  "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
  logo = {
    source = "${./art.txt}";
    padding = { top = 2; right = 6; };
    color."1" = "37";
  };
  display.separator = " ✦  ";
  modules = [
    "break"
    "break"
    {
      type = "title";
      color = { user = "33"; at = "37"; host = "33"; };
    }
    "break"
    { type = "os"; key = "os             "; keyColor = "32"; }
    { type = "kernel"; key = "kernel         "; keyColor = "32"; }
    { type = "shell"; key = "shell          "; keyColor = "32"; }
    { type = "terminal"; key = "terminal       "; keyColor = "32"; }
    { type = "wm"; format = "{} ({3})"; key = "window manager "; keyColor = "32"; }
    "break"
    { type = "cpu"; format = "{1}"; key = "cpu            "; keyColor = "32"; }
    { type = "gpu"; format = "{2} + {3}"; key = "gpu            "; keyColor = "32"; hideType = "integrated"; }
    { type = "memory"; key = "ram            "; keyColor = "32"; format = "{1} / {2}"; }
    { type = "swap"; key = "swap           "; keyColor = "32"; format = "{1} / {2}"; }
    { type = "disk"; key = "ssd            "; keyColor = "32"; format = "{1} / {2}"; }
    "break"
    { type = "uptime"; key = "uptime         "; keyColor = "32"; format = "{1}d {2}h {3}m {4}s"; }
    "break"
    { type = "colors"; symbol = "circle"; }
    "break"
    "break"
  ];
}
