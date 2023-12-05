#!/usr/bin/env bash

###Nix OS###
###Atualização completa do sistema###

##Execução do arquivo de atualização no terminal##
#/home/robsonnakane/Documentos/'Atualização Nix OS.sh'#

#Edição do arquivo no terminal#
#nano /home/robsonnakane/Documentos/'Atualização Nix OS.sh'#

###Atualização do sitema
sudo nixos-rebuild switch;

##Instalação dos programas Flatpak##
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.adobe.Flash-Player-Projector -y; flatpak install flathub com.skype.Client -y;

##Atualização do Flatpak##
flatpak update -y;

systemctl reboot
