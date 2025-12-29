{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.python.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Python tooling.";
  };

  config = lib.mkIf config.python.enable {
    home.packages = with pkgs; [ uv ];
  };
}
