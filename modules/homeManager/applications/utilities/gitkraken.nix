{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.gitkraken.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable GitKraken.";
  };

  config = lib.mkIf config.gitkraken.enable {
    home.packages = with pkgs; [ gitkraken ];

    # Download and install Catppuccin Mocha theme
    home.file.".gitkraken/themes/catppuccin-mocha.jsonc".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/gitkraken/main/themes/catppuccin-mocha.jsonc";
      sha256 = "sha256-u97bjJi3V2AI8Hw9wI25KfSe4bneX0QcOU0rzmeGaMM=";
    };
  };
}
