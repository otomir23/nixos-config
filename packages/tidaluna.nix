# refs:
# https://github.com/Inrixia/TidaLuna/blob/master/nix/linux-package.nix
# https://github.com/Inrixia/TidaLuna/blob/master/nix/darwin-package.nix
#
# wrapper to update fetcher hash
{ flakeMaintainers, stdenv, tidal-hifi, tidal, pnpm_12, injections, fetchPnpmDeps }: let
  pnpm = pnpm_12;
  mkInjection = prev: prev.override {
    inherit pnpm;
    fetchPnpmDeps = { ... }@params: fetchPnpmDeps (params // {
      inherit pnpm;
      hash = "sha256-i4a9Vh10Ri8kBlXGnn59PI8I0AZJhZa8KuPcOdhKxVA=";
    });
  };
  linuxPkg = tidal-hifi.overrideAttrs (oldAttrs: {
    postInstall = ''
      mv $out/share/tidal-hifi/resources/app.asar $out/share/tidal-hifi/resources/original.asar

      mkdir -p "$out/share/tidal-hifi/resources/app/"
      cp -R ${mkInjection injections.injection-linux}/* $out/share/tidal-hifi/resources/app/
    '';
    meta = oldAttrs.meta // {
      maintainers = oldAttrs.meta.maintainers ++ [ flakeMaintainers.damir ];
    };
  });
  darwinPkg = tidal.overrideAttrs (oldAttrs: {
    postInstall =
      (oldAttrs.postInstall or "")
      + ''
        if [ -f "$out/Applications/TIDAL.app/Contents/Resources/app.asar" ]; then
          mv "$out/Applications/TIDAL.app/Contents/Resources/app.asar" \
             "$out/Applications/TIDAL.app/Contents/Resources/original.asar"
        fi

        mkdir -p "$out/Applications/TIDAL.app/Contents/Resources/app/"
        cp -R ${mkInjection injections.injection-darwin}/* "$out/Applications/TIDAL.app/Contents/Resources/app/"
      '';
    meta = oldAttrs.meta // {
      maintainers = oldAttrs.meta.maintainers ++ [ flakeMaintainers.damir ];
    };
  });
in
  if stdenv.hostPlatform.isDarwin
  then darwinPkg
  else linuxPkg
