DEVICE=/dev/nvme0n1
BOOT_PART=${DEVICE}p1
SWAP_PART=${DEVICE}p2
ROOT_PART=${DEVICE}p3

ROOT=/mnt
BOOT=${ROOT}/boot

EFI_VARS_DIRECTORY=/sys/firmware/efi/efivars

# --------------------------
# ---- Check Startup Mode --
# --------------------------
if [ -z "$(ls $EFI_VARS_DIRECTORY)" ]; then
    echo Not EFI boot
    return 1
fi

# ---------------------------
# ---- Install Partion Tool -
# ---------------------------
pacman -Syu parted

# --------------------------
# ---- Partition -----------
# --------------------------
echo "partition ${DEVICE}"


# --------------------------
# ---- Format --------------
# --------------------------
echo "format ${BOOT_PART}"

echo "format ${SWAP_PART}"

echo "format ${ROOT_PART}"

# --------------------------
# ---- Mount ---------------
# --------------------------

# --------------------------
# ---- Keybord -------------
# --------------------------
loadkeys jp106

# --------------------------
# ---- System Clock --------
# --------------------------
timedatectl set-ntp true

# --------------------------
# ---- Pkg Install ---------
# --------------------------
pacstrap ${ROOT} base linux linux-firmware

# --------------------------
# ---- Fstab ---------------
# --------------------------
genfstab -U ${ROOT} >> ${ROOT}/etc/fstab
