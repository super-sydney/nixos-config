{
  config,
  pkgs,
  lib,
  ...
}:

{
  # Display and X11
  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Auto-rotation
  hardware.sensor.iio.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Power management
  services.power-profiles-daemon.enable = false;
  services.upower.enable = true;
  services.thermald.enable = true;
  services.auto-cpufreq.enable = true;

  # XDG portals (GNOME primary with GTK fallback)
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # GVFS for Trash, network mounts, MTP, etc.
  services.gvfs.enable = true;

  # Thumbnails support via Tumbler
  environment.systemPackages = with pkgs; [
    ffmpeg-headless
    ffmpegthumbnailer
    gdk-pixbuf

    pkgs.libheif.bin # provides heif-thumbnailer (the program that generates HEIF thumbnails)
    pkgs.libheif.out # provides heif.thumbnailer (allows for the viewing of HEIF thumbnails)

    # For more newer AVIF specific support usually not needed if libheif is installed
    pkgs.libavif

    # For JXL(JPEG XL) support
    pkgs.libjxl

    # For WebP support
    pkgs.webp-pixbuf-loader
  ];
  environment.pathsToLink = [
    "share/thumbnailers"
  ];

  # Bluetooth (BlueZ)
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  # Printing
  services.printing.enable = true;

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
