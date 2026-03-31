{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.proton-vpn.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Proton VPN GUI.";
  };

  config = lib.mkIf config.proton-vpn.enable {
    home.packages = with pkgs; [ proton-vpn ];
  };
}
