# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
#Robson note: copy and paste, only the information you need

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  # Use provided UUIDs instead of blkid probing (required for btrfs subvolumes)
  boot.loader.grub.fsIdentifier = "provided";

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."robsonnakane" = {
    isNormalUser = true;
    description = "Robson Nakane";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #steam
  #wineWowPackages.waylandFull  
  google-chrome
  thunderbird
  firefox
  simple-scan
  jdk
  btop
  ptyxis
  spotify
  vlc
  zoom-us
  kdePackages.kdenlive
  onlyoffice-desktopeditors
  inkscape
  rpi-imager
  mediawriter
  audacious
  tuxguitar
  gnome-boxes
  kdePackages.kate
  lsd
  foomatic-db
  bluez
  gnome-disk-utility
  nautilus
  gnome-tweaks
  flatpak
  gnome-software  
  lshw
  python3
  fastfetch
  collision
  distrobox
  boxbuddy
  audacity
  kdePackages.gwenview
  gimp
  transmission_4
  zoom-us
  telegram-desktop
  tuxguitar
  rsync
  tailscale
  libnotify
  pkgs.kdePackages.partitionmanager
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable Bluetooth support
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  #Enable Flatpak
  services.flatpak.enable = true;

  ##AutoUpgrade & Reboot Notification	

  system.autoUpgrade = {
    enable = true;
    allowReboot = false;          # como você quer
    dates = "daily";
    # randomizedDelaySec = "30min";  # opcional
  };
 
  # Notificação após o upgrade
  systemd.services.nixos-upgrade = {
    serviceConfig.ExecStartPost = [
      # Notificação de desktop (precisa de sessão gráfica ativa)
      "${pkgs.libnotify}/bin/notify-send -u critical 'NixOS atualizado' 'Verifique se precisa reiniciar o sistema'"
    ];
  };

nix = {
  settings.auto-optimise-store = true;
  gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
};

##Montagem do disco extra (alterar as informações como sda ou sdb alé do código UUID
fileSystems."/mnt/sda1" = {
  device = "/dev/disk/by-uuid/99bdcf5c-4a8d-46b4-af38-2a1fc2f0756c";
  fsType = "btrfs";
  options = [ 
    "users" 
    "nofail" 
    "compress=zstd" # Ativa compressão transparente para economizar espaço
    "rw"            # Garante acesso de leitura e escrita
  ];
};

  ##Enable Steam
  #programs.steam = {
  #enable = true;
  #remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  #dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
#};

  ##Enable gamescope for Steam
  #programs.steam.gamescopeSession.enable = true;
  
  #Enable Firewall
  networking.firewall = {
  enable = true;
  allowedTCPPorts = [ 80 443 ];
  allowedUDPPortRanges = [
    { from = 4000; to = 4007; }
    { from = 8000; to = 8010; }
  ];
  };

##Tailscale configuration
  services.tailscale = {
    # Enable tailscale at startup
    enable = true;

    # If you would like to use a preauthorized key, set
    # authKeyFile = "/run/secrets/tailscale_key";
    # Note: maximum expire time is 90 days
  };

  ##Gnome Session ( only for GNOME interface, I think so )
  #GNOME without the apps
  services.gnome.core-utilities.enable = false;
  
  #Disabling GNOME services
  services.gnome.tracker-miners.enable = false;
  services.gnome.tracker.enable = false;
  
  #GNOME games
  #services.gnome.games.enable = true;
 
  #GNOME core developer tools
  #services.gnome.core-developer-tools.enable = true; 

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
