{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.mattermost.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Mattermost.";
  };

  config = lib.mkIf config.mattermost.enable {
    home.packages = with pkgs; [ mattermost ];
  };
}
