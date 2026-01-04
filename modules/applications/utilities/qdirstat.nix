{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.qdirstat.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable QDirStat.";
  };

  config = lib.mkIf config.qdirstat.enable {
    home.packages = with pkgs; [ qdirstat ];
  };
}
