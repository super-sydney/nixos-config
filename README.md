## Useful Links
- Using git with NixOS: https://librephoenix.com/2024-03-14-managing-your-nixos-config-with-git#org4e1c396
- Search for packages/options: https://search.nixos.org/packages
- Reference structure: https://github.com/Just-Helpful/nixos

## Useful commands
- Check if config is valid: `nix flake check`
- Rebuild config `nixos-rebuild switch --flake ~/.config/nixos#laptop-sydney`

## Notes
- Edit active global modules in `./hosts/<host-name>/default.nix` and active local modules in `./hosts/<host-name>/home.nix`
