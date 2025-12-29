{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.inputRemapper.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Input Remapper.";
  };

  config = lib.mkIf config.inputRemapper.enable {
    home.packages = with pkgs; [ input-remapper ];
  };
}
