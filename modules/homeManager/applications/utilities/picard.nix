{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.picard.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable MusicBrainz Picard.";
  };

  config = lib.mkIf config.picard.enable {
    home.packages = with pkgs; [ picard ];
  };
}
