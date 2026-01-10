{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.adwsteamgtk.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable adwsteamgtk (Adwaita for Steam wrapper).";
  };

  config = lib.mkIf config.adwsteamgtk.enable {
    home.packages = with pkgs; [ adwsteamgtk ];
  };
}
