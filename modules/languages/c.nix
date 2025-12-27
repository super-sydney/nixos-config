{ config, pkgs, lib, ... }:

{
  options.c.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable C/C++ toolchain.";
  };

  config = lib.mkIf config.c.enable {
    home.packages = with pkgs; [
      gcc
      gdb
      lldb
    ];
  };
}
