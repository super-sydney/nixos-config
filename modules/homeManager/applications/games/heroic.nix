{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.heroic.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Heroic (GTK game launcher).";
  };

  config = lib.mkIf config.heroic.enable {
    home.packages = with pkgs; [
      heroic
    ];
  };
}
