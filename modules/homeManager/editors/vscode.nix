{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.vscode.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable VS Code installation.";
  };

  config = lib.mkIf config.vscode.enable {
    programs.vscode = {
      mutableExtensionsDir = true;
      enable = true;

    };
    home.packages = [ pkgs.nixfmt ];
  };
}
