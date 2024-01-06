Encontrar essa linha abaixo e substituir apenas os programas no arquivo etc/nixos/configuration.nix:

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  pkgs.google-chrome
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
  pkgs.lsd

  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

#Install Flatpak
  services.flatpak.enable = true;
  #Automatic Upgrades
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  #Upgrade para a versão unstable do NixOS ( deixar como comentário após a alteração )
  #system.autoUpgrade.channel = "https://channels.nixos.org/nixos-unstable"

##To build an ISO image for the channel nixos-unstable:##
# $ git clone https://github.com/NixOS/nixpkgs.git
# $ cd nixpkgs/nixos
# $ git switch nixos-unstable
# $ nix-build -A config.system.build.isoImage -I nixos-config=modules/installer/cd-dvd/installation-cd-minimal.nix default.nix
