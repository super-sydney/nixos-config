{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.feishin.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable feishin Music Player";
  };

  config = lib.mkIf config.feishin.enable {
    home.packages = with pkgs; [
      feishin
    ];
  };
}
