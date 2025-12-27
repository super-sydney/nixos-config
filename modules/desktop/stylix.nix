{ pkgs, lib, config, ... }:

{
  options.stylixConfig.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Stylix theme configuration.";
  };

  config = lib.mkIf config.stylixConfig.enable {
    # Ensure base16 schemes are available for stylix to use
    home.packages = with pkgs; [ base16-schemes ];

    stylix.enable = true;

    # Point stylix to Catppuccin Mocha base16 scheme
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

    # Font configuration
    stylix.fonts = {
      sansSerif = {
        package = pkgs.fira;
        name = "Fira Sans";
      };
      serif = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font";
      };
      monospace = {
        package = pkgs.nerd-fonts.fira-mono;
        name = "FiraMono Nerd Font";
      };
    };
  };
}