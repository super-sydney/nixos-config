{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.libreoffice.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Libreoffice Suite.";
  };

  config = lib.mkIf config.libreoffice.enable {
    home.packages = with pkgs; [ libreoffice ];
  };
}
