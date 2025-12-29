{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.pikaBackup.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Pika Backup.";
  };

  config = lib.mkIf config.pikaBackup.enable {
    home.packages = with pkgs; [ pika-backup ];
  };
}
