# --------------------------
# ---- Pkg Install ---------
# --------------------------
pacman -Syyu
pacman -S - < pkg.list

# --------------------------
# ---- yay Install ---------
# --------------------------
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

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
sed -e "/%wheel ALL=(ALL) NOPASSWORD: ALL/s/^# %wheel/funapy/" /etc/sudoers | EDITOR=tee visudo > /dev/null

systemctl enable docker
systemctl enable dhcpcd
systemctl enable sshd
systemctl enable sshd
