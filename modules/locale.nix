({ config, lib, ... }: let
  cfg = config.modules.locale;
in {
  options.modules.locale = {
    enable = lib.mkEnableOption "system locale config";
    base = lib.mkOption {
      type = lib.types.str;
    };
    extra = lib.mkOption {
      type = lib.types.str;
    };
  };
  config = lib.mkIf cfg.enable {
    i18n = {
      defaultLocale = cfg.base;
      extraLocaleSettings = {
        LC_ADDRESS = cfg.extra;
        LC_IDENTIFICATION = cfg.extra;
        LC_MEASUREMENT = cfg.extra;
        LC_MONETARY = cfg.extra;
        LC_NAME = cfg.extra;
        LC_NUMERIC = cfg.extra;
        LC_PAPER = cfg.extra;
        LC_TELEPHONE = cfg.extra;
        LC_TIME = cfg.extra;
      };
    };
  };
})
