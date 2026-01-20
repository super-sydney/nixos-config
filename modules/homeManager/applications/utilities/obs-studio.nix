{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.obs-studio.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Calibre.";
  };

  config = lib.mkIf config.obs-studio.enable {
    programs.obs-studio.enable = true;
  };
}
