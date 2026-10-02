({ config, lib, pkgs, ... }: let
  cfg = config.modules.mihomo;
  yamlFormat = pkgs.formats.yaml {};
  settings = lib.recursiveUpdate (import ./settings.nix) cfg.settings;
  sharedConfig = yamlFormat.generate "mihomo.yml" settings;
  runtimeConfig = "/run/mihomo/config.yaml";
in {
  options.modules.mihomo = {
    enable = lib.mkEnableOption "mihomo tun & webui";
    settings = lib.mkOption {
      type = yamlFormat.type;
      default = {};
      description = "Overrides for the shared settings.";
    };
    proxyProvidersFile = lib.mkOption {
      type = lib.types.str;
      default = "/etc/mihomo/proxy-providers.yaml";
      description = "Runtime path to a YAML file with a proxy providers.";
    };
  };
  config = lib.mkIf cfg.enable {
    services.mihomo = {
      enable = true;
      configFile = runtimeConfig;
      webui = pkgs.metacubexd;
      tunMode = true;
      processesInfo = true;
    };
    systemd.services.mihomo = {
      requires = [ "mihomo-config.service" ];
      after = [ "mihomo-config.service" ];
      restartTriggers = [ sharedConfig ];
    };

    # i want to keep proxy providers outside of the store,
    # so im merging the generated config with a provided file from module options
    systemd.services.mihomo-config = {
      description = "Merge Mihomo configurations";
      partOf = [ "mihomo.service" ];
      unitConfig.RequiresMountsFor = [ cfg.proxyProvidersFile ];
      script = let
        yq = lib.getExe pkgs.yq-go;
      in ''
        if [ ! -f "$CREDENTIALS_DIRECTORY/proxy-providers.yaml" ]; then
          echo "Missing proxy-provider.yaml file" >&2
          exit 1
        fi

        ${yq} eval-all \
          'select(fileIndex == 0) * (select(fileIndex == 1) | pick(["proxy-providers"]))' \
          ${sharedConfig} "$CREDENTIALS_DIRECTORY/proxy-providers.yaml" \
          > ${runtimeConfig}
      '';
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        RuntimeDirectory = "mihomo";
        RuntimeDirectoryMode = "0700";
        UMask = "0077";
        LoadCredential = "proxy-providers.yaml:${cfg.proxyProvidersFile}";
        ProtectHome = true;
        ProtectSystem = "strict";
      };
    };

    # makes it work better i dont remember honestly
    services.resolved.enable = true;
    networking.firewall.checkReversePath = "loose";
  };
})
