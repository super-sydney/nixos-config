{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.monophony.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Monophony (YouTube music streaming app).";
  };

  config = lib.mkIf config.monophony.enable {
    home.packages = with pkgs; [ monophony ];
  };
}
