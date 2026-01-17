{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.todoist.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Todoist.";
  };

  config = lib.mkIf config.todoist.enable {
    home.packages = with pkgs; [ todoist-electron ];
  };
}
