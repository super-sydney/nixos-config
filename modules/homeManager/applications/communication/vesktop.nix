{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.vesktop.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Vesktop.";
  };

  config = lib.mkIf config.vesktop.enable {
    programs.vesktop = {
      enable = true;
    };
  };
}
