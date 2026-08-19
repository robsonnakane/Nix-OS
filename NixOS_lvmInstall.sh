#!/usr/bin/env bash
set -euo pipefail

SSDs=()

# 1. Filtra discos por hardware: busca SSDs (rota=0), ignora mídias rom/loop e o pendrive SanDisk
for disk_name in $(lsblk -d -o name,rota | awk '$2==0 && $1 !~ /loop|rom/ {print $1}'); do
  disk_path="/dev/$disk_name"

  # Obtém informações de fabricante/modelo via udevadm
  disk_info=$(udevadm info --query=property --name="$disk_path" 2>/dev/null | grep -E "ID_VENDOR|ID_MODEL" || true)

  # Ignora se o disco for da marca SanDisk (ignora maiúsculas/minúsculas)
  if echo "$disk_info" | grep -qi "sandisk"; then
    echo "Aviso: Pendrive SanDisk detectado em $disk_path. Ignorando para proteção."
    continue
  fi

  SSDs+=("$disk_path")
done

if [ ${#SSDs[@]} -eq 0 ]; then
  echo "Erro: Nenhum SSD interno disponível encontrado."
  exit 1
fi

echo "SSDs selecionados para formatação LVM: ${SSDs[*]}"

# 2. Desmonta e limpa a tabela de partições de cada SSD interno
for disk in "${SSDs[@]}"; do
  echo "Limpando completamente o disco $disk..."
  wipefs -a -f "$disk"
  sgdisk -Z "$disk"
done

# 3. Cria os Physical Volumes (PV) no LVM
for disk in "${SSDs[@]}"; do
  pvcreate -y "$disk"
done

# 4. Cria o Volume Group (VG) chamado 'nixos-vg' agrupando os SSDs
vgcreate nixos-vg "${SSDs[@]}"

# 5. Cria os Logical Volumes (LV) para Swap e Raiz (Root)
# Aloca 8GB fixos para Swap e todo o espaço restante para a raiz
lvcreate -L 8G -n swap nixos-vg
lvcreate -l 100%FREE -n root nixos-vg

# 6. Aplica os sistemas de arquivos correspondentes
mkfs.ext4 -L nixos /dev/nixos-vg/root
mkswap -L swap /dev/nixos-vg/swap

# 7. Monta a estrutura para o instalador do NixOS
mount /dev/nixos-vg/root /mnt
swapon /dev/nixos-vg/swap

echo "LVM pronto! Os volumes já estão montados em /mnt."
echo "Iniciando o instalador gráfico do NixOS utilizando a estrutura LVM montada..."
sudo calamares -d
