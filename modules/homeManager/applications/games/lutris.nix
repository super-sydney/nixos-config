{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.lutris.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Lutris (game management and launch platform).";
  };

  config = lib.mkIf config.lutris.enable {
    assertions = [
      {
        assertion = config.wine.enable;
        message = "Lutris requires wine to be enabled. Set wine.enable = true.";
      }
    ];

    home.packages = with pkgs; [ lutris ];
  };
}
