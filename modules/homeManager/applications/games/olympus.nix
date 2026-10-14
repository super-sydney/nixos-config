{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.olympus.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Olympus celeste mod manager";
  };

  config = lib.mkIf config.olympus.enable {
    home.packages = with pkgs; [
      (olympus.override { celesteWrapper = "steam-run"; })
    ];
  };
}
