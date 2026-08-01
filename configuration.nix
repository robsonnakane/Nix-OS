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
  kitty
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
  #teams
  zoom-us
  telegram-desktop
  tuxguitar
  rsync
  tailscale
  #pkgs.linuxKernel.kernels.linux_latest_libre #para computadores mais novos
  pkgs.linuxKernel.kernels.linux_zen #para computadores mais antigos ( caso não funcione, não ultilize )

  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  # Enable Bluetooth support
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  #Enable Flatpak
  services.flatpak.enable = true;

  #Enable Kernels Packages
  #boot.kernelPackages = pkgs.linuxPackages_latest; #para computadores mais novos
  boot.kernelPackages = pkgs.linuxPackages_zen; #para computadores mais antigos

  #Enable an experimental Rust support:
  boot.kernelPatches = [
  {
    name = "Rust Support";
    patch = null;
    features = {
      rust = true;
     };
   }
  ];

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
