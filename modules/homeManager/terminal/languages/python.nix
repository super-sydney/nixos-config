{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}:

{
  options.python.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Python tooling.";
  };

  config = lib.mkIf config.python.enable {
    assertions = [
      {
        assertion = osConfig.nix-ld.enable;
        message = "Python tooling (uv) requires nix-ld to be enabled. Set nix-ld.enable = true.";
      }
    ];

    home.packages = with pkgs; [
      python313
      uv
    ];
  };
}
