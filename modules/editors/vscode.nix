{ config, pkgs, lib, ... }:

{
  options.vscode.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable VS Code installation.";
  };

  config = lib.mkIf config.vscode.enable {
    # Install VSCode through Home Manager
    home.packages = with pkgs; [ vscode ];
  };
}
