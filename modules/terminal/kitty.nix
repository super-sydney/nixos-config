{
  pkgs,
  config,
  lib,
  ...
}:

{
  options.kitty.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Kitty terminal.";
  };

  config = lib.mkIf config.kitty.enable {
    programs.kitty.enable = true;
  };
}
