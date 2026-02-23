{
  config,
  lib,
  ...
}:

with lib;

let
  cfg = config.nix-ld;
in
{
  options.nix-ld = {
    enable = mkEnableOption "nix-ld compatibility layer";
  };

  config = mkIf cfg.enable {
    programs.nix-ld.enable = true;
  };
}
