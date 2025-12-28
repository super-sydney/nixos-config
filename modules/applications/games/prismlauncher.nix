{ pkgs, lib, config, ... }:

{
  options.prismlauncher.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable PrismLauncher.";
  };

  config = lib.mkIf config.prismlauncher.enable {
    home.packages = with pkgs; [ prismlauncher ];

    programs.java.enable = true;
  };
}
