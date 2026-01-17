{
  config,
  pkgs,
  lib,
  ...
}:

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
        in
        {
          default = {
            extensions = defaultExtensions;
            userSettings = {
              "window.promptToSaveChanges" = lib.mkDefault "never";
              "files.watcherExclude" = lib.mkDefault {
                "**/settings.json" = true;
              };
              "editor.fontFamily" = lib.mkDefault "'Fira Code', 'Droid Sans Mono', 'monospace'";
              "editor.fontLigatures" = lib.mkDefault true;
              "editor.fontSize" = lib.mkDefault 16;
              "editor.formatOnSave" = lib.mkDefault true;
              "editor.formatOnSaveMode" = lib.mkDefault "file";
              "editor.formatOnPaste" = lib.mkDefault true;
              "editor.mouseWheelZoom" = lib.mkDefault true;
              "editor.rulers" = lib.mkDefault [
                {
                  column = 88;
                  color = "#7C7C7C";
                }
              ];
              "editor.wordWrap" = lib.mkDefault "bounded";
              "editor.wordWrapColumn" = lib.mkDefault 88;

              "files.autoSave" = lib.mkDefault "onFocusChange";
              "files.trimTrailingWhitespace" = lib.mkDefault true;
              "files.insertFinalNewline" = lib.mkDefault true;

              "search.exclude" = lib.mkDefault {
                "**/.venv/**" = true;
              };

              "terminal.integrated.cursorStyle" = lib.mkDefault "line";

              "workbench.colorTheme" = lib.mkDefault "Catppuccin Mocha";
              "workbench.editor.tabSizing" = lib.mkDefault "fixed";
              "workbench.iconTheme" = lib.mkDefault "catppuccin-mocha";

              "workbench.settings.applyToAllProfiles" = [
                "editor.fontFamily"
                "editor.fontLigatures"
                "editor.fontSize"
                "editor.formatOnSave"
                "editor.formatOnSaveMode"
                "editor.formatOnPaste"
                "editor.mouseWheelZoom"
                "editor.rulers"
                "editor.wordWrap"
                "editor.wordWrapColumn"
                "files.autoSave"
                "files.trimTrailingWhitespace"
                "files.insertFinalNewline"
                "files.watcherExclude"
                "search.exclude"
                "terminal.integrated.cursorStyle"
                "workbench.colorTheme"
                "workbench.editor.tabSizing"
                "workbench.iconTheme"
              ];
            };
          };

          python = {
            extensions =
              defaultExtensions
              ++ (with pkgs.vscode-extensions; [
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
            extensions =
              defaultExtensions
              ++ (with pkgs.vscode-extensions; [
                dbaeumer.vscode-eslint
              ]);
            userSettings = {
            };
          };

          # C / C++ development profile
          c-cpp = {
            extensions =
              defaultExtensions
              ++ (with pkgs.vscode-extensions; [
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
            extensions =
              defaultExtensions
              ++ (with pkgs.vscode-extensions; [
                jnoortheen.nix-ide
                arrterian.nix-env-selector
              ]);
            userSettings = {
            };
          };
        };
    };
    home.packages = [ pkgs.nixfmt ];
  };
}
