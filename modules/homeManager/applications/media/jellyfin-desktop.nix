{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.jellyfin-desktop.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Jellyfin Desktop.";
  };

  config = lib.mkIf config.jellyfin-desktop.enable {
    home.packages = with pkgs; [
      (jellyfin-desktop.overrideAttrs (previous: {
        nativeBuildInputs = (previous.nativeBuildInputs or [ ]) ++ [ makeWrapper ];

        postFixup = (previous.postFixup or "") + ''
          wrapProgram $out/bin/jellyfin-desktop \
            --set LIBVA_DRIVER_NAME dummy
        '';
      }))
    ];
  };
}
