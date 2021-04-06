ROOT=/mnt
BOOT_ROADER=grub
GRUB_TARGET_PLATFORM=x86_64-efi
EFI_DIRECTORY=${ROOT}/boot
CUSTOM_KEY_MAP=/usr/share/kbd/keymaps/custom.map
LOGIN_USER=funapy

# --------------------------
# ---- Keybord -------------
# --------------------------
loadkeys jp106
dumpkeys > ${CUSTOM_KEY_MAP}
sed -i -e "s/keycode  58 = Caps_Lock/keycode  58 = Control/" ${CUSTOM_KEY_MAP}

# --------------------------
# ---- Host Name -----------
# --------------------------
cat hostname >> /etc/hostname
cat hosts >> /etc/hosts

# --------------------------
# ---- Time Zone -----------
# --------------------------
ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
locale-gen
hwclock --systohc --localtime
cat locacle.conf >> /etc/locale.conf
cat vconsole.conf >> /etc/vconsole.conf

# --------------------------
# ---- Pkg Install ---------
# --------------------------
pacman -Syyu
pacman -S - < pkg.list

# --------------------------
# ---- User ----------------
# --------------------------
groupadd ${LOGIN_USER}
groupadd sshd
useradd -m -g users -G wheel,${LOGIN_USER},docker,sshd -s /usr/bin/zsh ${LOGIN_USER}
echo please enter the password for ${LOGIN_USER}
passwd ${LOGIN_USER}
echo please enter the password for root
passwd
sed -e "/%wheel ALL=(ALL) ALL/s/^# //" /etc/sudoers | EDITOR=tee visudo > /dev/null
sed -e "/%wheel ALL=(ALL) NOPASSWORD: ALL/s/^# %wheel/funapy" /etc/sudoers | EDITOR=tee visudo > /dev/null

# ---------------------------------
# ---- GRUB And EFI Boot Manager --
# ---------------------------------
grub-install --target=${GRUB_TARGET_PLATFORM} --efi-directory=${EFI_DIRECTORY} --bootloader-id=${BOOT_ROADER}
grub-mkconfig -o ${EFI_DIRECTORY}/grub/grub.cfg

# --------------------------
# ---- Systemctl -----------
# --------------------------
systemctl start iwd
systemctl enable iwd
systemctl start docker
systemctl enable docker
systemctl enable dhcpcd
systemctl enable sshd
systemctl enable sshd
systemctl start NetworkNanager
systemctl enable NetworkManager
