{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.wine.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Wine and helpers.";
  };

  config = lib.mkIf config.wine.enable {
    home.packages = with pkgs; [
      wine
      winetricks
      protontricks
    ];
  };
}
