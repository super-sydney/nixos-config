{ config, pkgs, lib, ... }:

{
  options.vscode.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable VS Code installation.";
  };

  config = lib.mkIf config.vscode.enable {
    programs.vscode = {
      enable = true;

      profiles =
        let
          defaultExtensions = with pkgs.vscode-extensions; [
            catppuccin.catppuccin-vsc
            catppuccin.catppuccin-vsc-icons
            github.copilot-chat
            esbenp.prettier-vscode
            redhat.vscode-yaml
            ms-vsliveshare.vsliveshare
            yzhang.markdown-all-in-one
            shd101wyy.markdown-preview-enhanced
            usernamehw.errorlens
          ];
        in {
          default = {
            extensions = defaultExtensions;
            userSettings = {
              "editor.formatOnSave" = true;
              "files.trimTrailingWhitespace" = true;
              "files.insertFinalNewline" = true;
            };
          };

          python = {
            extensions = defaultExtensions ++ (with pkgs.vscode-extensions; [
              ms-python.python
              ms-python.vscode-pylance
            ]);

            userSettings = {
              # "python.formatting.provider" = "black";
              # "python.linting.enabled" = true;
              # "python.linting.flake8Enabled" = true;
              # "python.linting.mypyEnabled" = true;
            };
          };

          javascript = {
            extensions = defaultExtensions ++ (with pkgs.vscode-extensions; [
              dbaeumer.vscode-eslint
            ]);
            userSettings = {
            };
          };

          # C / C++ development profile
          c-cpp = {
            extensions = defaultExtensions ++ (with pkgs.vscode-extensions; [
              ms-vscode.cpptools
              ms-vscode.cmake-tools
              twxs.cmake
              ms-vscode.makefile-tools
            ]);
            userSettings = {
            };
          };

          # Nix development profile
          nix = {
            extensions = defaultExtensions ++ (with pkgs.vscode-extensions; [
              jnoortheen.nix-ide
              arrterian.nix-env-selector
            ]);
            userSettings = {
            };
          };
        };
    };
  };
}
