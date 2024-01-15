#!/usr/bin/env bash

###Nix OS###
###Atualização completa do sistema###

##Execução do arquivo de atualização no terminal##
#/home/robsonnakane/Documentos/'Atualização Nix OS.sh'#

#Edição do arquivo no terminal#
#sudo nano /home/robsonnakane/Documentos/'Atualização Nix OS.sh'#
#sudo nano /etc/nixos/configuration.nix

##Alteração do channel para unstable ( executar o comando primeiro e deixar como comentário após a primeira atualização )##
#sudo nix-channel --add https://channels.nixos.org/nixos-unstable nixos

#Limpeza dos pacotes inutilizados:
nix-collect-garbage

###Atualização do sitema
sudo nixos-rebuild switch --upgrade;

##Instalação dos programas Flatpak##
#flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo; flatpak install flathub com.skype.Client -y; flatpak install flathub com.adobe.Flash-Player-Projector -y; flatpak install flathub org.gnome.Extensions -y; 

##Atualização do Flatpak##
flatpak update -y;

systemctl reboot
