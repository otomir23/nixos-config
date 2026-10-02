{
  flakeMaintainers,
  lib,
  appimageTools,
  fetchurl,
}: appimageTools.wrapType2 rec {
  pname = "justlauncher";
  version = "2.1.1";

  src = fetchurl {
    url = "https://assets.justlauncher.org/justlauncher/launcher/installer/linux/JustLauncher-${version}-x86_64.AppImage";
    hash = "sha256-+LotsbGyQ9NUxvFwRLAN2ku9nz3GTO+SX28SkoE072E=";
  };

  meta = {
    description = "Your new favorite Minecraft launcher";
    homepage = "https://justlauncher.org";
    mainProgram = "JustLauncher";
    license = lib.licenses.unfree;
    sourceProvenance = with lib.sourceTypes; [ binaryNativeCode ];
    maintainers = [ flakeMaintainers.damir ];
    platforms = [ "x86_64-linux" ];
  };
}
