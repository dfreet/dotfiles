# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use kernel 6.18 for nvidia compatibility
  boot.kernelPackages = pkgs.linuxPackages_6_18;

  boot.initrd.luks.devices."luks-1879f864-5f03-4328-8703-775529b24e6d".device = "/dev/disk/by-uuid/1879f864-5f03-4328-8703-775529b24e6d";
  networking.hostName = "nix_legion"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.devyn = {
    isNormalUser = true;
    description = "Devyn";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  hardware.bluetooth.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  environment.pathsToLink = [ "/libexec" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # cli text editor
    firefox # web browser
    networkmanagerapplet # utility for networkmanager
    git # version control
    prismlauncher # minecraft
    unzip # decompress files
    openssl # socket layer (for eduroam)
    xev # monitor events
    (python313.withPackages (python313Packages: with python313Packages; [ # (for eduroam)
      dbus-python
      pyopenssl
    ]))
    pwvucontrol # set volume with pipewire
    neofetch # display system information
    arandr # monitor configuration gui
  ];

  environment.shells = with pkgs; [ zsh ] ;
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = with pkgs; pinentry-gtk2;
  };

  # List services that you want to enable:
  services.xserver = {
    enable = true;
    dpi = pkgs.lib.mkForce 120;

    displayManager.lightdm.enable = true;

    desktopManager = {
      xterm.enable = false;
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu # application launcher
        i3status # default i3 status bar
        i3blocks # alternative status bar (installing both for now)
	i3-volume # volume control
      ];
    };
  };

  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "devyn";
    };
    defaultSession = "none+i3";
  };
  services.blueman.enable = true;
  services.upower.enable = true;

  programs.i3lock.enable = true; # default i3 screen lock

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
