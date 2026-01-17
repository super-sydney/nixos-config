{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.protonvpnGui.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Proton VPN GUI.";
  };

  config = lib.mkIf config.protonvpnGui.enable {
    home.packages = with pkgs; [ protonvpn-gui ];
  };
}
