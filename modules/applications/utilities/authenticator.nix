{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.authenticator.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Authenticator (GNOME 2FA app).";
  };

  config = lib.mkIf config.authenticator.enable {
    home.packages = with pkgs; [ authenticator ];
  };
}
