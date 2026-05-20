{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.nicotine-plus.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Nicotine+.";
  };

  config = lib.mkIf config.nicotine-plus.enable {
    home.packages = with pkgs; [
      nicotine-plus
    ];
  };
}
