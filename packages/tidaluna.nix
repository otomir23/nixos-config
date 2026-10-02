# refs:
# https://github.com/Inrixia/TidaLuna/blob/master/nix/linux-package.nix
# https://github.com/Inrixia/TidaLuna/blob/master/nix/darwin-package.nix
#
# pnpm isn't pinned to v10 in official TidaLuna packaging
# it breaks with my updated nixpkgs version beacause new pnpm versions dropped v3 fetcher support
# pinning it to v10 so it works again
{ stdenv, tidal-hifi, tidal, pnpm_10, injections, fetchPnpmDeps }: let
  pnpm = pnpm_10;
  mkInjection = prev: prev.override {
    inherit pnpm;
    fetchPnpmDeps = { ... }@params: fetchPnpmDeps ({ inherit pnpm; } // params);
  };
  linuxPkg = tidal-hifi.overrideAttrs {
    postInstall = ''
      mv $out/share/tidal-hifi/resources/app.asar $out/share/tidal-hifi/resources/original.asar

      mkdir -p "$out/share/tidal-hifi/resources/app/"
      cp -R ${mkInjection injections.injection-linux}/* $out/share/tidal-hifi/resources/app/
    '';
  };
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
  });
in
  if stdenv.hostPlatform.isDarwin
  then darwinPkg
  else linuxPkg
