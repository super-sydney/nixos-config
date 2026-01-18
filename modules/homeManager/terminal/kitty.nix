{
  config,
  pkgs,
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
      shellIntegration.enableFishIntegration = lib.mkIf config.fish.enable true;
      settings = {
        shell = lib.mkIf config.fish.enable "${pkgs.fish}/bin/fish";
        hide_window_decorations = "yes";
        font_family = "Fira Code";
        disable_ligatures = "always";
        enable_audio_bell = "no";
        window_padding_width = 4;
      };
    };
  };
}
