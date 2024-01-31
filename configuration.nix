  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  pkgs.steam
  pkgs.wineWowPackages.waylandFull  
  pkgs.google-chrome
  pkgs.thunderbird
  pkgs.firefox
  pkgs.neofetch
  pkgs.gnome.simple-scan
  pkgs.jdk
  pkgs.btop
  pkgs.kitty
  pkgs.spotify
  pkgs.vlc
  pkgs.zoom-us
  pkgs.libsForQt5.kdenlive
  pkgs.onlyoffice-bin
  pkgs.inkscape
  pkgs.rpi-imager
  pkgs.mediawriter
  pkgs.audacious
  pkgs.tuxguitar
  pkgs.gnome.gnome-boxes
  pkgs.libsForQt5.kate
  pkgs.lsd
  pkgs.krusader
  pkgs.libsForQt5.kompare
  pkgs.foomatic-db
  pkgs.bluez
  pkgs.gnome.gnome-disk-utility
  #pkgs.linuxKernel.kernels.linux_latest_libre #para computadores mais novos
  #pkgs.linuxKernel.kernels.linux_zen #para computadores mais antigos ( caso não funcione, não ultilize )

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
  #boot.kernelPackages = pkgs.linuxPackages_zen; #para computadores mais antigos

  #Enable Steam
  programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
};

  #Enable gamescope for Steam
  programs.steam.gamescopeSession.enable = true;
