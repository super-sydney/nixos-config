{ pkgs, lib, config, ... }:

{
  options.gitkraken.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable GitKraken.";
  };

  config = lib.mkIf config.gitkraken.enable {
    home.packages = with pkgs; [ gitkraken ];
  };
}
