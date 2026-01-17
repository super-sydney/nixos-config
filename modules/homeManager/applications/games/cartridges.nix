{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.cartridges.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Cartridges (GTK game launcher).";
  };

  config = lib.mkIf config.cartridges.enable {
    home.packages = with pkgs; [ cartridges ];
  };
}
