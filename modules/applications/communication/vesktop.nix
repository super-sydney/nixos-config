{ pkgs, lib, config, ... }:

{
  options.vesktop.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Vesktop.";
  };

  config = lib.mkIf config.vesktop.enable {
    home.packages = with pkgs; [ vesktop ];
  };
}
