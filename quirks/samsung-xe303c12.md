Chromebook
===============================================================================

Switch to developer mode
-------------------------------------------------------------------------------

    1. Turn off the laptop.
    2. To invoke Recovery mode, you hold down the ESC and Refresh keys and poke the Power button.
    3. At the Recovery screen press Ctrl-D (there's no prompt - you have to know to do it).
    4. Confirm switching to developer mode by pressing enter, and the laptop will reboot and reset the system. This takes about 15-20 minutes.
Note: After enabling developer mode, you will need to press Ctrl-D each time you boot, or wait 30 seconds to continue booting.

Enable booting from external storage
-------------------------------------------------------------------------------

    1. After booting into developer mode, hold Ctrl and Alt and poke the T key. This will open up the crosh shell.
    2. Type shell to get into a bash shell.
    3. Type sudo su to become root.
    4. Then type this to enable USB booting:crossystem dev_boot_usb=1 dev_boot_signed_only=0
    5. Reboot the system to allow the change to take effect.

Create a root USB or SD for dual booting
-------------------------------------------------------------------------------

These instructions are written for installing to a USB drive with the sda device, assuming no other USB drives are plugged in. For an SD card, adjust the instructions for the mmcblk1 device that an SD card will register as.  To install to eMMC, install to one of the prior medias, then install to /dev/mmcblk0, a simple edit from the install instructions from SD. You must boot onto a different media prior to this however.
    1. Get a root shell as described in the previous section.
    2. Since ChromeOS will automatically mount any partitions it finds, unmount everything now:
umount /dev/sda*
    3. Start fdisk to create a GPT partition table:
fdisk /dev/sda
    4. At the fdisk prompt:
        1. Type g. This will create a new empty GPT partition table.
        2. Write the partition table and exit by typing w.
    5. Partition the micro SD card:
cgpt create /dev/sda
       cgpt add -i 1 -t kernel -b 8192 -s 32768 -l Kernel -S 1 -T 5 -P 10 /dev/sda
    6. To create the rootfs partition, we first need to calculate how big to make the partition using information from cgpt show. Look for the number under the start column for Sec GPT table which is 15633375 in this example:
localhost / # cgpt show /dev/sda
start size part contents
0 1 PMBR 1 1 Pri GPT header 8192 32768 1 Label: "Kernel"
Type: ChromeOS kernel
UUID: E3DA8325-83E1-2C43-BA9D-8B29EFFA5BC4
Attr: priority=10 tries=5 successful=1
15633375 32 Sec GPT table
15633407 1 Sec GPT header
    7. Replace the xxxxx string in the following command with that number to create the root partition:
cgpt add -i 2 -t data -b 40960 -s `expr xxxxx - 40960` -l Root /dev/sda
    8. Tell the system to refresh what it knows about the disk partitions:
sfdisk -R /dev/sda
    9. Format the root partition:
mkfs.ext4 /dev/sda2
    10. Download and extract rootfs tarball:
cd /tmp
wget http://archlinuxarm.org/os/ArchLinuxARM-peach-latest.tar.gz
mkdir root
mount /dev/sda2 root
tar -xf ArchLinuxARM-peach-latest.tar.gz -C root
    11. Flash the kernel to the kernel partition:
dd if=root/boot/vmlinux.kpart of=/dev/sda1
    12. Unmount the root partition:
umount root
sync
    13. Reboot the computer.
    14. At the splash screen, instead of pressing Ctrl-D to go to CromeOS, press Ctrl-U to boot to the external drive.
    15. After logging in as root (password is "root"), you can connect to a wireless network by running:wifi-menu



Better touchpad responsiveness
-------------------------------------------------------------------------------

Create the file /etc/X11/xorg.conf.d/50-touchpad.conf and add the following to it:
Section "InputClass"
	Identifier "touchpad"
	MatchIsTouchpad "on"
	Option "FingerHigh" "5"
	Option "FingerLow" "5"
EndSection

Enable audio
-------------------------------------------------------------------------------

    1. Install alsa-utils:pacman -S alsa-utils
    2. Run alsamixer as root.
    3. Arrow right until you see four items starting with Left Speaker Mixer, and press M on all four channels to un-mute them.
    4. Arrow right some more until you find four more starting with Right Speaker Mixer and un-mute them as well.
    5. Arrow all the way back left to the Speaker channel and raise the volume a little. Keep it low (< 50ish), since alsa will let you get dangerously high for these speakers.

Suspend when closing the lid
-------------------------------------------------------------------------------

    1. Install acpid and pm-utils:pacman -S acpid pm-utils
    2. Edit /etc/acpi/handler.sh and near the bottom you'll see the button/lid section. Add pm-suspend to the close section to look like:
	button/lid)
		case "$3" in
		close)
			logger 'LID closed'
			pm-suspend
			;;
    3. Enable and start acpid:
systemctl enable acpid
systemctl start acpid
    4. Closing the lid will now trigger a suspend, and opening it will wake the system.

User permissions for backlight control
-------------------------------------------------------------------------------

    1. To allow all users to modify the backlight control at /sys/class/backlight/pwm-backlight.0/brightness, create and edit the file /etc/tmpfiles.d/brightness.conf with these contents:
f /sys/class/backlight/pwm-backlight.0/brightness 0666 - - - 800
    2. On boot, systemd will now set the permissions of that control file to be world writable. Acceptable values are 0-2800.

