Encontrar o # abaixo e substituir apenas os programas no arquivo etc/nixos/configuration.nix:

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.robsonnakane = {
    isNormalUser = true;
    description = "Robson Nakane";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      neofetch
      simple-scan
      gnome.gnome-tweaks
      jdk
      btop
      kitty
      gnome.gnome-boxes
      spotify
      vlc
      steam
      zoom
      kdenlive
      onlyoffice-bin
      transmission
      inkscape-with-extensions
      thunderbird
      rpi-imager
      mediawriter
      gnome.gedit
      google-chrome
      gnome-firmware
      audacious
      asunder
      tuxguitar
    ];
  };

Adicionar esta # logo abaixo dos programas acima:
  #Install Flatpak
  services.flatpak.enable = true;
  #Automatic Upgrades
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
