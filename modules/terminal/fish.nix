{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.fish.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Fish shell.";
  };

  config = lib.mkIf config.fish.enable {
    programs.fish.enable = true;
    home.packages = with pkgs; [ fish ];
    home.sessionVariables.SHELL = "${pkgs.fish}/bin/fish";
  };
}
