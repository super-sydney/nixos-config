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
    programs.fish.interactiveShellInit = ''
      set fish_greeting # disable greeting
    '';

    home.sessionVariables.SHELL = "${pkgs.fish}/bin/fish";
  };
}
