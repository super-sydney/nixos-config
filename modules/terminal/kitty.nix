{
  pkgs,
  config,
  lib,
  ...
}:

{
  options.kitty.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Kitty terminal.";
  };

  config = lib.mkIf config.kitty.enable {
    programs.kitty = {
      enable = true;
      themeFile = "Catppuccin-Mocha";
      settings = {
        hide_window_decorations = "yes";
        font_family = "Fira Code";
        disable_ligatures = "always";
        enable_audio_bell = "no";
        window_padding_width = 4;
      };
    };
  };
}
