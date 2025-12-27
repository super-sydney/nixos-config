{ pkgs, lib, config, ... }:

{
  options.signalDesktop.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Signal Desktop.";
  };

  config = lib.mkIf config.signalDesktop.enable {
    home.packages = with pkgs; [ signal-desktop ];
  };
}
