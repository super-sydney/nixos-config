{
  pkgs,
  lib,
  config,
  ...
}:

{
  options.steam.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Steam.";
  };

  config = lib.mkIf config.steam.enable {
    programs.steam.enable = true;
    programs.steam.extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    programs.steam.gamescopeSession.enable = true;

    environment.systemPackages = with pkgs; [
      mangohud
    ];

    programs.gamemode.enable = true;
  };
}
