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

# FIXME: Are these needed?
#mkdir -p build/$KERNEL_IFS_DIR/dev/sda
#mkdir -p build/$KERNEL_IFS_DIR/dev/tty

mkdir -p build/$KERNEL_IFS_DIR/home

# FIXME: Are these needed?
mkdir -p build/$KERNEL_IFS_DIR/media/root
mkdir -p build/$KERNEL_IFS_DIR/root
mkdir -p build/$KERNEL_IFS_DIR/sbin
mkdir -p build/$KERNEL_IFS_DIR/etc
mkdir -p build/$KERNEL_IFS_DIR/lib/firmware/dt

cp build/host/boot/sbin/kernel      build/$KERNEL_IFS_DIR/boot/
cp build/host/sbin/init             build/$KERNEL_IFS_DIR/sbin/
cp build/host/sbin/tty              build/$KERNEL_IFS_DIR/sbin/
cp build/host/sbin/aux              build/$KERNEL_IFS_DIR/sbin/
cp build/host/sbin/sdcard           build/$KERNEL_IFS_DIR/sbin/
cp build/host/sbin/extfs            build/$KERNEL_IFS_DIR/sbin/
cp build/host/sbin/ifs              build/$KERNEL_IFS_DIR/sbin/
cp build/host/sbin/devfs            build/$KERNEL_IFS_DIR/sbin/
cp build/host/sbin/gpio             build/$KERNEL_IFS_DIR/sbin/
cp build/host/sbin/mailbox          build/$KERNEL_IFS_DIR/sbin/
cp build/host/etc/startup.cfg       build/$KERNEL_IFS_DIR/etc/
cp build/host/lib/firmware/dt/rpi4.dtb       build/$KERNEL_IFS_DIR/lib/firmware/dt
	
arm-none-eabi-objcopy build/host/sbin/bootload -O binary output/bootload.img

./output/src/mkifs-build/mkifs build/boot_partition/kernel.img output/bootload.img build/$KERNEL_IFS_DIR


