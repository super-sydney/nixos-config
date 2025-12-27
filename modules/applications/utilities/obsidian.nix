{ pkgs, lib, config, ... }:

{
  options.obsidian.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Obsidian.";
  };

  config = lib.mkIf config.obsidian.enable {
    home.packages = with pkgs; [ obsidian ];
  };
}
