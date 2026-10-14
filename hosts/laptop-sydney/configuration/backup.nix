{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.restic ];

  # Keep secrets outside the Nix store.
  # Create this file manually and restrict its permissions.
  services.restic.backups.laptop = {
    repository = "sftp:u685425@u685425.your-storagebox.de:/restic-backups";
    passwordFile = "/root/.config/restic/password";

    # Back up your home directory and NixOS configuration.
    paths = [
      "/home/sydney"
    ];

    # Exclude caches and disposable data.
    extraBackupArgs = [
      "--cleanup-cache"
      "--exclude-caches"
      "--iexclude-file=/home/sydney/.config/nixos/hosts/laptop-sydney/configuration/restic-excludes.txt"
    ];

    # Snapshot retention.
    pruneOpts = [
      "--keep-daily 30"
      "--keep-weekly 26"
      "--keep-monthly 24"
    ];

    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
      RandomizedDelaySec = "30m";
    };

    extraOptions = [
      "sftp.command='ssh -F /root/.ssh/config -o BatchMode=yes hetzner-restic -s sftp'"
    ];
  };
}
