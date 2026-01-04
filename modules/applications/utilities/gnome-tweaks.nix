{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.gnomeTweaks.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Gnome Tweaks.";
  };

  config = lib.mkIf config.gnomeTweaks.enable {
    home.packages = with pkgs; [ gnome-tweaks ];
  };
}
