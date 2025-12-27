{ lib, ... }:

{
  options.fish.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Fish shell system-wide.";
  };

  config.programs.fish.enable = lib.mkDefault false;
}
