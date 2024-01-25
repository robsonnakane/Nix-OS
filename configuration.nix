Encontrar a linha abaixo e substituir o conteúdo adicional ao arquivo:

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  pkgs.google-chrome
  pkgs.gedit
  pkgs.thunderbird
  pkgs.firefox
  pkgs.neofetch
  pkgs.gnome.simple-scan
  pkgs.gnome.gnome-tweaks
  pkgs.jdk
  pkgs.btop
  pkgs.kitty
  pkgs.spotify
  pkgs.vlc
  pkgs.steam
  pkgs.zoom-us
  pkgs.libsForQt5.kdenlive
  pkgs.onlyoffice-bin
  pkgs.transmission
  pkgs.inkscape
  pkgs.rpi-imager
  pkgs.mediawriter
  pkgs.gnome-firmware
  pkgs.audacious
  pkgs.asunder
  pkgs.tuxguitar
  pkgs.gnome.gnome-boxes
  pkgs.libsForQt5.kate
  pkgs.lsd
  pkgs.krusader
  pkgs.libsForQt5.kompare
  pkgs.foomatic-db
  pkgs.bluez
  #pkgs.linuxKernel.kernels.linux_latest_libre #para computadores mais novos
  #pkgs.linuxKernel.kernels.linux_zen #para computadores mais antigos
  
#  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

#Install Flatpak
  services.flatpak.enable = true;
  ##para computadores mais novos
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  ##para computadores mais antigos
  #boot.kernelPackages = pkgs.linuxPackages_zen;
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-23.11";

  #Upgrade para a versão unstable do NixOS ( deixar como comentário após a alteração )  
  #system.autoUpgrade.channel = "https://channels.nixos.org/nixos-unstable"