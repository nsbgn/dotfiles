sudo cryptsetup luksFormat -v "${DISK}"
sudo cryptsetup open "${DISK}" crypt1
sudo mkfs -t ext4 /dev/mapper/crypt1
sudo cryptsetup close crypt1
