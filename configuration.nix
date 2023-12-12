Encontrar essa linha abaixo e substituir apenas os programas no arquivo etc/nixos/configuration.nix:

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.robsonnakane = {
    isNormalUser = true;
    description = "Robson Nakane";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      neofetch
      simple-scan
      gnome.gnome-tweaks
      jdk
      btop
      kitty
      gnome.gnome-disk-utility
      
];
  };

Adicionar as linhas abaixo dos programas acima:
  #Install Flatpak
  services.flatpak.enable = true;
  #Automatic Upgrades
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-unstable"

##To build an ISO image for the channel nixos-unstable:##
# $ git clone https://github.com/NixOS/nixpkgs.git
# $ cd nixpkgs/nixos
# $ git switch nixos-unstable
# $ nix-build -A config.system.build.isoImage -I nixos-config=modules/installer/cd-dvd/installation-cd-minimal.nix default.nix
