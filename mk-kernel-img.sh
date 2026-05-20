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
cp build/host/system/filesystems/ufs        build/$KERNEL_IFS_DIR/system/filesystems/
cp build/host/system/filesystems/extfs        build/$KERNEL_IFS_DIR/system/filesystems/
cp build/host/system/filesystems/ifs          build/$KERNEL_IFS_DIR/system/filesystems/
cp build/host/system/filesystems/devfs        build/$KERNEL_IFS_DIR/system/filesystems/
cp build/host/etc/s.startup                   build/$KERNEL_IFS_DIR/etc/
cp build/host/etc/s.shutdown                  build/$KERNEL_IFS_DIR/etc/
cp build/host/lib/firmware/dt/rpi4.dtb        build/$KERNEL_IFS_DIR/lib/firmware/dt/
	
arm-none-eabi-objcopy build/host/sbin/bootloader -O binary output/bootloader.img


echo "creating ifs.mtree."

# TODO: ifs.mtree handling currently not supported by mkifs

cat >ifs.mtree <<EOF
/set type=file uid=0 gid=0 mode=0644
. type=dir mode=0755
./bin type=dir mode=0755
./boot type=dir mode=0755
./boot/sbin type=dir mode=0755
./boot/sbin/kernel type=file
./dev type=dir mode=0755
./etc type=dir mode=0755
./etc/s.startup type=file
./etc/s.shutdown type=file
./home type=dir mode=0755
./lib type=dir mode=0755
./lib/firmware type=dir mode=0755
./lib/firmware/dt type=dir mode=0755
./lib/firmware/dt/rpi4.dtb type=file
./media type=dir mode=0755
./media/root type=dir mode=0755
./root type=dir mode=0755
./sbin type=dir mode=0755
./serv type=dir mode=0755
./system type=dir mode=0755
./system/drivers type=dir mode=0755
./system/drivers/tty type=file
./system/drivers/aux type=file
./system/drivers/sdcard type=file
./system/drivers/gpio type=file
./system/drivers/mailbox type=file
./system/filesystems type=dir mode=0755
./system/filesystems/ufs type=file
./system/filesystems/extfs type=file
./system/filesystems/ifs type=file
./system/filesystems/devfs type=file
./system/servers type=dir mode=0755
./system/servers/sysinit type=file
EOF

./output/src/mkifs-build/mkifs build/boot_partition/kernel.img output/bootloader.img ifs.mtree build/$KERNEL_IFS_DIR


