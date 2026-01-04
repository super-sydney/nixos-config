{
  config,
  pkgs,
  lib,
  ...
}:

with lib;

let
  cfg = config.nvtop;
in
{
  options.nvtop = {
    enable = mkEnableOption "nvtop GPU monitoring tool";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      nvtopPackages.nvidia
      nvtopPackages.amd

    ];
  };
}
