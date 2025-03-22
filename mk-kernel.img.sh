#! /bin/sh
#
# mk-kernel-img.sh
#
# Script to generate kernel.img image for Raspberry Pi devices.
# This contains the Cheviot bootloader and IFS image file concatenated
# into a single kernel.img file.  The IFS image is a simple filesystem
# containing the kernel, init command and drivers to bootstrap the
# system.
# 
# This kernel.img should be placed on the FAT boot partition along with
# the Broadcom start.elf and bootcode.bin files (dependent on Pi version).
#

KERNEL_IFS_DIR=kernel_ifs_dir

mkdir -p build/$KERNEL_IFS_DIR
mkdir -p build/$KERNEL_IFS_DIR/bin
mkdir -p build/$KERNEL_IFS_DIR/boot
mkdir -p build/$KERNEL_IFS_DIR/dev
mkdir -p build/$KERNEL_IFS_DIR/etc
mkdir -p build/$KERNEL_IFS_DIR/home
mkdir -p build/$KERNEL_IFS_DIR/lib/firmware/dt
mkdir -p build/$KERNEL_IFS_DIR/media/root
mkdir -p build/$KERNEL_IFS_DIR/root
mkdir -p build/$KERNEL_IFS_DIR/sbin
mkdir -p build/$KERNEL_IFS_DIR/serv
mkdir -p build/$KERNEL_IFS_DIR/system
mkdir -p build/$KERNEL_IFS_DIR/system/drivers
mkdir -p build/$KERNEL_IFS_DIR/system/filesystems
mkdir -p build/$KERNEL_IFS_DIR/system/servers

cp build/host/boot/sbin/kernel                build/$KERNEL_IFS_DIR/boot/
cp build/host/system/servers/sysinit          build/$KERNEL_IFS_DIR/system/servers/
cp build/host/system/drivers/tty              build/$KERNEL_IFS_DIR/system/drivers/
cp build/host/system/drivers/aux              build/$KERNEL_IFS_DIR/system/drivers/
cp build/host/system/drivers/sdcard           build/$KERNEL_IFS_DIR/system/drivers/
cp build/host/system/drivers/gpio             build/$KERNEL_IFS_DIR/system/drivers/
cp build/host/system/drivers/mailbox          build/$KERNEL_IFS_DIR/system/drivers/
cp build/host/system/filesystems/extfs        build/$KERNEL_IFS_DIR/system/filesystems/
cp build/host/system/filesystems/ifs          build/$KERNEL_IFS_DIR/system/filesystems/
cp build/host/system/filesystems/devfs        build/$KERNEL_IFS_DIR/system/filesystems/
cp build/host/etc/startup.cfg                 build/$KERNEL_IFS_DIR/etc/
cp build/host/lib/firmware/dt/rpi4.dtb        build/$KERNEL_IFS_DIR/lib/firmware/dt/
	
arm-none-eabi-objcopy build/host/sbin/bootload -O binary output/bootload.img

./output/src/mkifs-build/mkifs build/boot_partition/kernel.img output/bootload.img build/$KERNEL_IFS_DIR


