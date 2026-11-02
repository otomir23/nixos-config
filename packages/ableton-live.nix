# wrapper to remove entries conflicting with regular wine
{ flakeMaintainers, ableton-linux, runCommand }:
  runCommand "ableton-live"
    {
      meta = (ableton-linux.meta or { }) // {
        mainProgram = "ableton-live";
        maintainers = (ableton-linux.meta.maintainers or []) ++ [ flakeMaintainers.damir ];
      };
    }
    ''
      mkdir -p $out/{bin,share}
      ln -s ${ableton-linux}/bin/ableton-live $out/bin/ableton-live
      ln -s ${ableton-linux}/bin/pipeasio-settings $out/bin/pipeasio-settings
      ln -s ${ableton-linux}/share/icons $out/share/icons
      ln -s ${ableton-linux}/share/applications $out/share/applications
      ln -s ${ableton-linux}/share/mime $out/share/mime
    ''
