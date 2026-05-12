{
  config,
  pkgs,
  lib,
  ...
}:

{
  options.sound-juicer.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Sound Juicer.";
  };

  config = lib.mkIf config.sound-juicer.enable {
    home.packages = with pkgs; [
      sound-juicer
    ];
  };
}
