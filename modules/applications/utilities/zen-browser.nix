{
  pkgs,
  lib,
  config,
  ...
}:

let
  userChromeSrc = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/omeyenburg/catppuccin-zen-browser/main/themes/Mocha/Mauve/userChrome.css";
    sha256 = "1lvpxcfzg969jxn1djl8adrfnw76djhgb8pi69zvld61qxjrlgcc";
  };
  userContentSrc = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/omeyenburg/catppuccin-zen-browser/main/themes/Mocha/Mauve/userContent.css";
    sha256 = "0jnlgkmk2mswzrwfhis9skk6a9svc995bd1a9292hy94wr2kqyi9";
  };
in
{
  options.zenBrowser.enable = lib.mkOption {
    type = lib.types.bool;
    default = false;
    description = "Enable Zen Browser via zen-browser flake and apply Catppuccin Mocha Mauve theme CSS.";
  };

  config = lib.mkIf config.zenBrowser.enable {
    # Enable Zen Browser program (provided by imported HM module)
    programs.zen-browser.enable = true;

    # Theme CSS files for Zen profile located at ~/.zen/chrome
    home.file.".zen/chrome/userChrome.css".source = userChromeSrc;
    home.file.".zen/chrome/userContent.css".source = userContentSrc;
  };
}
