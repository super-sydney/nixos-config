{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.protonAuthenticator.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Proton Authenticator.";
  };

  config = lib.mkIf config.protonAuthenticator.enable {
    home.packages = with pkgs; [ proton-authenticator ];
  };
}
