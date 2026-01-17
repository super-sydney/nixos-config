{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.git.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Git";
  };

  config = lib.mkIf config.git.enable {
    programs.git = {
      enable = true;

      settings.user = {
        name = lib.mkDefault "Sydney";
        email = lib.mkDefault "sydneykho@proton.me";
      };
    };
  };
}
