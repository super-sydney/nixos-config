{ lib, config, ... }:

{
  options.fish.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Fish shell system-wide.";
  };

  config = lib.mkIf config.fish.enable {
    programs.fish.enable = true;
  };
}
