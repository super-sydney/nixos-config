{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.nautilusOpenAnyTerminal.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable nautilus-open-any-terminal configuration.";
  };

  config = lib.mkIf config.nautilusOpenAnyTerminal.enable {
    programs.nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };
  };
}
