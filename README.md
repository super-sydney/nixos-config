## Useful Links
- Using git with NixOS: https://librephoenix.com/2024-03-14-managing-your-nixos-config-with-git#org4e1c396
- Search for packages/options: https://search.nixos.org/packages
- Reference structure: https://github.com/Just-Helpful/nixos

## Themes
- GTK and Gnome Shell: https://github.com/catppuccin/gtk
  - Gnome Shell themes can be applied using the user-themes extension
  - GTK themes can be installed using dconf/gsettings, but it's more consistent to replace the default themes by taking the `gtk-3.0` and `gtk-4.0` directories from the theme and replacing the corresponding `~/.config/gtk-` directories.
- Icons: https://github.com/vinceliuice/Tela-icon-theme
- Cursor: https://github.com/ful1e5/BreezeX_Cursor

## Useful commands
- Check if config is valid: `nix flake check`
- Rebuild config `nixos-rebuild switch --flake ~/.config/nixos#laptop-sydney`

## Notes
- Edit active global modules in `./hosts/<host-name>/default.nix` and active local modules in `./hosts/<host-name>/home.nix`
