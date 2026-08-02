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
  #teams
  zoom-us
  telegram-desktop
  tuxguitar
  rsync
  tailscale
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  # Enable Bluetooth support
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot

  #Enable Flatpak
  services.flatpak.enable = true;
  
  {
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

  # Necessário para o notify-send funcionar
  environment.systemPackages = with pkgs; [
    libnotify
  ];
}

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
