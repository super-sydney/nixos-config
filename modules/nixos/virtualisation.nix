{ config, pkgs, lib, ... }:

{
  options.virtualisation.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable virtualization stack (libvirtd, virt-manager).";
  };

  config = lib.mkIf config.virtualisation.enable {
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
  };
}
