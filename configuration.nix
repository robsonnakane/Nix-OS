# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
#
# Dica do Robson: mantenha apenas o que realmente precisa.
# Comando útil: sudo nix-env -p /nix/var/nix/profiles/system --delete-generations old

{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  ###############################################################################
  # Boot
  ###############################################################################
  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = false;
    # Use provided UUIDs instead of blkid probing (required for btrfs subvolumes)
    fsIdentifier = "provided";
  };

  ###############################################################################
  # Networking
  ###############################################################################
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;

    firewall = {
      enable = true;
      allowedTCPPorts = [ 80 443 ];
      allowedUDPPortRanges = [
        { from = 4000; to = 4007; }
        { from = 8000; to = 8010; }
      ];
    };
  };

  ###############################################################################
  # Localização e teclado
  ###############################################################################
  time.timeZone = "America/Sao_Paulo";

  i18n = {
    defaultLocale = "pt_BR.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS        = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT    = "pt_BR.UTF-8";
      LC_MONETARY       = "pt_BR.UTF-8";
      LC_NAME           = "pt_BR.UTF-8";
      LC_NUMERIC        = "pt_BR.UTF-8";
      LC_PAPER          = "pt_BR.UTF-8";
      LC_TELEPHONE      = "pt_BR.UTF-8";
      LC_TIME           = "pt_BR.UTF-8";
    };
  };

  console.keyMap = "br-abnt2";

  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  ###############################################################################
  # Desktop Environment (GNOME)
  ###############################################################################
  services.xserver.enable = true;

  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
  services.displayManager.autoLogin = {
    enable = true;
    user = "robsonnakane";
  };

  # GNOME minimalista
  services.gnome.core-apps.enable = false;
  services.gnome.tinysparql.enable = false;
  services.gnome.localsearch.enable = false;

  # Terminal padrão
  xdg.terminal-exec = {
    enable = true;
    settings.default = [ "org.gnome.Ptyxis.desktop" ];
  };

  ###############################################################################
  # Áudio
  ###############################################################################
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  ###############################################################################
  # Usuário
  ###############################################################################
  users.users.robsonnakane = {
    isNormalUser = true;
    description = "Robson Nakane";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  ###############################################################################
  # Pacotes do sistema
  ###############################################################################
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    # Utilitários
    nix-index
    btop
    lsd
    lshw
    fastfetch
    rsync
    libnotify
    python3

    # Navegadores e comunicação
    google-chrome
    firefox
    thunderbird
    telegram-desktop
    zoom-us
    pkgs.teams

    # Mídia e edição
    vlc
    spotify
    audacious
    audacity
    tuxguitar
    kdePackages.kdenlive
    gimp
    inkscape
    kdePackages.gwenview
    pkgs.obs-studio

    # Produtividade
    onlyoffice-desktopeditors
    kdePackages.kate
    ptyxis
    pkgs.obsidian
    
    # Sistema / Hardware
    simple-scan
    gnome-disk-utility
    nautilus
    gnome-tweaks
    gnome-boxes
    jdk
    foomatic-db
    bluez
    rpi-imager
    mediawriter
    pkgs.transmission_4
    pkgs.kdePackages.kget

    # Outros
    flatpak
    tailscale
  ];

  programs.firefox.enable = true;

  ###############################################################################
  # Serviços
  ###############################################################################
  services.printing.enable = true;
  services.openssh.enable = true;
  services.fwupd.enable = true;
  zramSwap.enable = true;

  # Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Tailscale
  services.tailscale.enable = true;

  # Flatpak
  services.flatpak.enable = true;

  ###############################################################################
  # Montagem de disco extra
  ###############################################################################
  fileSystems."/mnt/sdb1" = {
    device = "/dev/disk/by-uuid/99bdcf5c-4a8d-46b4-af38-2a1fc2f0756c";
    fsType = "btrfs";
    options = [
      "users"
      "nofail"
      "compress=zstd"
      "rw"
    ];
  };

  ###############################################################################
  # Nix (otimização e limpeza)
  ###############################################################################
  nix = {
    settings = {
      experimental-features = [ "nix-command" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 7d";
    };
  };

  ###############################################################################
  # Auto-upgrade do sistema
  ###############################################################################
  system.autoUpgrade = {
    enable = true;
    allowReboot = false;
    dates = "daily";
  };

  # Notificação após upgrade
  systemd.services.nixos-upgrade = {
    serviceConfig.ExecStartPost = [
      "${pkgs.libnotify}/bin/notify-send -u critical 'NixOS atualizado' 'Verifique se precisa reiniciar o sistema'"
    ];
  };

  ###############################################################################
  # Flatpak – atualização automática diária
  ###############################################################################
  systemd.services.flatpak-auto-update = {
    description = "Atualização Automática dos Flatpaks";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.flatpak}/bin/flatpak update -y --noninteractive";
    };
  };

  systemd.timers.flatpak-auto-update = {
    description = "Timer para Atualização Automática dos Flatpaks";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "daily";
      Persistent = true;
    };
  };

  ###############################################################################
  # Flatpak – instalação DECLARATIVA (sem flakes)
  ###############################################################################
  # Coloque aqui os Flatpaks que você quer ter instalados.
  # Formato: "org.exemplo.App"
  # Você pode descobrir o ID com: flatpak search nome-do-app
  system.userActivationScripts.flatpak-declarative = {
    text = ''
      # Adiciona o repositório Flathub (se ainda não existir)
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub \
        https://dl.flathub.org/repo/flathub.flatpakrepo

      # Lista de Flatpaks desejados
      desired=(
        # Exemplos (descomente e adicione os que quiser):
        "com.google.ChromeDev"
        "com.github.tchx84.Flatseal"
        "net.mkiol.SpeechNote"
            )

      # Instala os Flatpaks desejados
      for app in "''${desired[@]}"; do
        echo "Garantindo instalação de: $app"
        ${pkgs.flatpak}/bin/flatpak install -y --noninteractive flathub "$app" || true
      done

      # Remove Flatpaks não declarados (opcional – descomente se quiser limpeza total)
      ${pkgs.flatpak}/bin/flatpak uninstall --unused -y
    '';
  };

  ##Após a primeira reinicialização os flatpaks não forem instalados, para "forçar" a instalação, rodar o comando:
  #systemctl --user start flatpak-declarative

  ###############################################################################
  # Verificação semanal do Nix Store
  ###############################################################################
  systemd.services.nix-store-verify = {
    description = "Verificação completa de integridade do Nix Store";
    path = [ pkgs.nix ];
    script = ''
      echo "Iniciando verificação profunda do /nix/store..."
      nix-store --verify --check-contents
      echo "Verificação concluída com sucesso."
    '';
    serviceConfig = {
      Type = "oneshot";
      Nice = 19;
      CPUSchedulingPolicy = "idle";
    };
  };

  systemd.timers.nix-store-verify = {
    description = "Disparador semanal para o serviço nix-store-verify";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
    };
  };

  ###############################################################################
  # Versão do sistema
  ###############################################################################
  system.stateVersion = "26.05"; # Did you read the comment?
}
