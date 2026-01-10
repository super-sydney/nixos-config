{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.hieroglyphic.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Hieroglyphic (LaTeX symbol finder).";
  };

  config = lib.mkIf config.hieroglyphic.enable {
    home.packages = with pkgs; [ hieroglyphic ];
  };
}
