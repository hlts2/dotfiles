DEVICE=/dev/nvme0n1
BOOT_PART=${DEVICE}p1
SWAP_PART=${DEVICE}p2
ROOT_PART=${DEVICE}p3

BOOT_PART_SIZE=+500M
SWAP_PART_SIZE=+24G

ROOT=/mnt
BOOT=${ROOT}/boot

EFI_VARS_DIRECTORY=/sys/firmware/efi/efivars

USER=funapy

# --------------------------
# ---- Check Startup Mode --
# --------------------------
if [ -z "$(ls $EFI_VARS_DIRECTORY)" ]; then
    echo Not EFI boot
    return 1
fi

# --------------------------
# ---- Keybord -------------
# --------------------------
loadkeys jp106

# --------------------------
# ---- System Clock --------
# --------------------------
timedatectl set-ntp true

# ----------------------------
# ---- Print Storage Info ----
# ----------------------------
lsblk

# ----------------------------
# ---- Clean Root Partition --
# ----------------------------
rm -rf ${ROOT}/*

# --------------------------
# ---- Unmount -------------
# --------------------------
echo "unmount volumes"

umount -f ${BOOT} && sync
umount -f ${ROOT} && sync
umount -f ${BOOT_PART} && sync
umount -f ${SWAP_PART} && sync
umount -f ${ROOT_PART} && sync
umount -f ${DEVICE} && sync

# --------------------------
# ---- Partitioning --------
# --------------------------
echo "start to remove partion ${DEVICE}"

(echo d; echo 3; echo w) | fdisk ${DEVICE}
(echo d; echo 2; echo w) | fdisk ${DEVICE}
(echo d; echo 1; echo w) | fdisk ${DEVICE}
sleep 5

echo "start to create partion ${DEVICE}"

(echo g; echo w) | fdisk ${DEVICE}

(echo n; echo ""; echo ""; echo ${BOOT_PART_SIZE}; echo w) | fdisk ${DEVICE}
(echo n; echo ""; echo ""; echo ${SWAP_PART_SIZE}; echo w) | fdisk ${DEVICE}
(echo n; echo ""; echo ""; echo ""; echo w) | fdisk ${DEVICE}
sleep 10

echo "start to change partiion type"

(echo t; echo 1; echo 1; echo w) | fdisk ${DEVICE}
(echo t; echo 2; echo 19; echo w) | fdisk ${DEVICE}
(echo t; echo 3; echo 23; echo w) | fdisk ${DEVICE}
sleep 10

fdisk -l

# --------------------------
# ---- Format --------------
# --------------------------
echo "format ${BOOT_PART}"
mkfs.fat -F32 ${BOOT_PART} && sync
sleep 10

echo "format ${SWAP_PART}"
mkswap ${SWAP_PART} && sync
sleep 10

echo "format ${ROOT_PART}"
mkfs.ext4 ${ROOT_PART} && sync
sleep 10

# --------------------------
# ---- Mount ---------------
# --------------------------
echo "mount ${ROOT_PART}"
mkdir ${ROOT}
mount ${ROOT_PART} ${ROOT} && sync

echo "mount ${BOOT_PART}"
mkdir ${BOOT}
mount ${BOOT_PART} ${BOOT} && sync

echo "mount ${SWAP_PART}"
swapon ${SWAP_PART} && sync

# --------------------------
# ---- Pkg Install ---------
# --------------------------
echo start to download deps
reflector --country Japan --sort rate --save /etc/pacman.d/mirrorlist
pacstrap ${ROOT} base linux linux-firmware

# --------------------------
# ---- fstab ---------------
# --------------------------
genfstab -U ${ROOT} >> ${ROOT}/etc/fstab

# --------------------------
# ---- dotfiles ------------
# --------------------------
cp -R ../../../dotfiles /mnt

# --------------------------
# ---- Next Step -----------
# --------------------------
echo successful install
echo please enter the following command.
echo $ arch-chroot ${ROOT}
