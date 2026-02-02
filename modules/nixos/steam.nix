{
  config,
  pkgs,
  lib,
  inputs,
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
      inputs.dw-proton.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    programs.steam.gamescopeSession.enable = true;

    environment.systemPackages = with pkgs; [
      mangohud
    ];

    programs.gamemode.enable = true;
  };
}
