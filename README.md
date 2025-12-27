## Project Structure

### Overview

This is a declarative NixOS configuration using Flakes. It defines your entire system (packages, settings, themes, services) in code. When you run `nixos-rebuild`, Nix reads this config and sets up your system exactly as described.

### Key Files & Directories

#### `flake.nix` - The Entry Point

This file is the main entrypoint. It defines:

1. **Inputs** - External dependencies:
   - `nixpkgs` - The main package repository
   - `home-manager` - Tool for managing user-level configuration
   - `nix-flatpak` - Support for Flatpak applications

2. **Outputs** - What gets built when you rebuild:
   - `nixosConfigurations` - System-wide settings (NixOS)
   - `homeManagerUsers` - User-level settings (home-manager)

The flake connects everything together and tells Nix which modules to load for each host.

#### `hosts/` - Per-Host Configurations

Each host (computer) gets its own directory with system-specific settings:

```
hosts/laptop-sydney/
  ├── default.nix              # NixOS settings (system-wide)
  ├── home.nix                 # Home-manager settings (user-specific)
  ├── hardware-configuration.nix # Hardware info (auto-generated)
  ├── localisation.nix         # Time, locale, keyboard
  ├── network.nix              # Network settings
  ├── services.nix             # System services (display manager, audio)
  └── users.nix                # User accounts
```

#### `modules/` - Reusable Configuration Modules

Modules that can be enabled/disabled. They're organized by category, and each directory has a `default.nix` that exports its modules (using `//` to merge submodules). The root `modules/default.nix` combines everything into `nixosModules` (system-level) and `homeManagerModules` (user-level) sets that `flake.nix` imports:

```
modules/
├── nixos/                    # System-level modules
│   ├── default.nix           # Exports: { flatpak, fish, steam, ... }
│   ├── flatpak.nix
│   ├── fish.nix
│   └── steam.nix
│
├── applications/             # User-level apps
│   ├── default.nix           # Exports and merges subdirs
│   ├── communication/
│   ├── games/
│   ├── media/
│   └── utilities/
│
├── desktop/, editors/, languages/, terminal/  # Similar structure
│
└── default.nix               # Final assembly:
                              # { nixosModules, homeManagerModules }
```

### Understanding Modules

Every module defines configurable `options` and the actual executed `config`. Example from `modules/terminal/fish.nix`:

```nix
options.fish.enable = lib.mkOption {
  type = lib.types.bool;
  default = false;
  description = "Enable Fish shell.";
};

config = lib.mkIf config.fish.enable {
  programs.fish.enable = true;
};
```

Enable it in your host config:

```nix
# hosts/laptop-sydney/home.nix
fish.enable = true;
```

The `default.nix` chain automatically makes all modules available. New modules just need to be exported in their directory's `default.nix` to be included.

### Adding a New Host

To add another machine, create a new directory in `hosts/`:

```bash
cp -r hosts/laptop-sydney hosts/new-machine
# Edit hosts/new-machine/hardware-configuration.nix (run `nixos-generate-config` to get it)
# Edit other files for new-machine-specific settings
```

Then in `flake.nix`, add:

```nix
"new-machine" = nixpkgs.lib.nixosSystem { ... };
```

### Adding a New Module

1. Create file: `modules/category/module-name.nix`
2. Define `options` and `config` following the pattern above
3. Export it in the directory's `default.nix`
4. Enable it in `hosts/*/default.nix` or `hosts/*/home.nix`

### Rebuilding the System

```bash
# Rebuild and switch to new configuration
sudo nixos-rebuild switch --flake ~/.config/nixos#laptop-sydney

# Build without switching (useful for testing)
sudo nixos-rebuild build --flake ~/.config/nixos#laptop-sydney

# Check if config is valid
nix flake check ~/.config/nixos#laptop-sydney
```

The `#laptop-sydney` tells Nix which host config to use from `flake.nix`'s `nixosConfigurations`.

## Useful Links

- Using git with NixOS: https://librephoenix.com/2024-03-14-managing-your-nixos-config-with-git#org4e1c396
- Search for packages/options: https://search.nixos.org/packages
- Reference structure: https://github.com/Just-Helpful/nixos

## Themes

- GTK and GNOME Shell: https://github.com/catppuccin/gtk
  - GNOME Shell themes can be applied using the user-themes extension
  - GTK themes can be installed using dconf/gsettings, but it's more consistent to replace the default themes by taking the `gtk-3.0` and `gtk-4.0` directories from the theme and replacing the corresponding `~/.config/gtk-*` directories.
- Icons: https://github.com/vinceliuice/Tela-icon-theme
- Cursor: https://github.com/ful1e5/BreezeX_Cursor
