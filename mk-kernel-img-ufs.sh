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



#
# Required variables:
#	RELEASEDIR
#		Should be defined in nbmake-${MACHINE}
#	IMGBASE
#		Basename of the image
#
# Optional variables:
#	BOOTDISK
#		device name of target bootable disk specified in /etc/fstab
#		(default: sd0)
#	USE_MBR
#		set yes if target disk image requires MBR partition
#		(default: no)
#	MBR_BOOTCODE
#		optional MBR bootcode which should be installed by fdisk(8)
#		(default: empty)
#		- specified MBR_BOOTCODE must exist in ${DESTDIR}/usr/mdec
#		- if MBR_BOOTCODE is not specified,
#		  MBR_DEFAULT_BOOTCODE (default: mbr) will be used
#		  if the target ${MACHINE} has the one in /usr/mdec
#	USE_SUNLABEL
#		set yes if target disk image requires Sun's label
#		(default: no)
#	INSTALLBOOT_AFTER_DISKLABEL (untested)
#		set yes if the target ${MACHINE} requires disklabel
#		to run installboot(8), like hp300
#		(default: empty)
#	IMAGEMB
#		target image size in MB
#		(default: 2048)
#	SWAPMB
#		swap size in target image in MB
#		(default: 128)
#	KERN_SET
#		kernel set name which should be extracted into image
#		(default: kern-GENERIC)
#	SETS
#		binary sets that should be extracted into image
#		(default: modules base etc comp games man misc tests text
#			  xbase xcomp xetc xfont xserver)
#	SETS_DIR
#		directory path where binary sets are stored
#		(default: ${RELEASEDIR}/${RELEASEMACHINEDIR}/binary/sets)
#	IMGFILE_EXTRA
#		list of additional files to be copied into images,
#		containing one or more tuples of the form:
#			FILE	TARGETPATH
#		for installation image etc.
#		(default: empty)
#	IMGDIR_EXTRA
#		list of additional directories to be copied into images,
#		containing one or more tuples of the form:
#			DIR	TARGETPATH
#		for installation image etc.
#		(default: empty)
#		XXX: currently permissions in IMGDIR_EXTRA are not handled
#	IMGDIR_EXCLUDE
#		pax(1) options to exclude files which should not copied
#		into TARGETPATH in IMGDIR_EXTRA
#		(default: empty)
#	FSTAB_IN
#		template file of /etc/fstab
#		(default: ${DISTRIBDIR}/common/bootimage/fstab.in)
#	SPEC_IN
#		default files of spec file for makefs(8)
#		(default: ${DISTRIBDIR}/common/bootimage/spec.in)
#	SPEC_EXTRA
#		additional files of spec file for makefs(8)
#		(default: empty)
#	IMGMAKEFSOPTIONS
#		options passed to makefs(8) to create root file system
#		(default: -o bsize=16384,fsize=2048,density=8192)
#	INSTALLBOOTOPTIONS
#		options passed to installboot(8), e.g., -o console=com0
#		(default: empty)
#	PRIMARY_BOOT
#		primary boot loader that should be installed into
#		the target image via installboot(8)
#		(default: empty)
#	SECONDARY_BOOT
#		secondary bootloader that should be put into the target image
#		(default: empty)
#	SECONDARY_BOOT_ARG
#		extra arguments that should be passed to installboot(8)
#		to specify the secondary bootloader
#		(default: empty)
#	DISKPROTO_IN
#		template file of disklabel -R
#		(default: ${DISTRIBDIR}/common/bootimage/diskproto.in
#		       or ${DISTRIBDIR}/common/bootimage/diskproto.mbr.in)
#	OMIT_SWAPIMG
#		no need to put swap partition into image (for USB stick)
#		(default: no)
#

echo "mk-kernel-img-ufs.sh starting."
  
KERNEL_IFS_DIR=build/kernel_ifs_dir

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

echo "copying files to kernel_ifs_dir."

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
cp build/host/etc/s.startup                   build/$KERNEL_IFS_DIR/etc/
cp build/host/etc/s.shutdown                  build/$KERNEL_IFS_DIR/etc/
cp build/host/lib/firmware/dt/rpi4.dtb        build/$KERNEL_IFS_DIR/lib/firmware/dt/

echo "creating ifs.mtree."

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
./system/filesystems/extfs type=file
./system/filesystems/ifs type=file
./system/filesystems/devfs type=file
./system/servers type=dir mode=0755
./system/servers/sysinit type=file
EOF




# Create the Initial Filesystem UFS image that is to be appended to the bootloader

echo "calling makefs to create a FFS-based IFS image."

makefs -t ffs -B little -F ifs.mtree \
	    -o bsize=4096,fsize=512 \
	    -o optimization=space,minfree=0 \
	    ifs_ufs.img ${KERNEL_IFS_DIR}

# Combine the bootloader and UFS-based Initial Filesystem image
# Update the magic fields containing the IFS image's offset and size.

echo "creating bootloader.bin binary."

arm-none-eabi-objcopy build/host/sbin/bootloader -O binary output/bootloader.bin

echo "concatenating bootloader.bin with ifs_ufs.img."

./output/src/createrpikernelimg-build/createrpikernelimg build/boot_partition/kernel.img output/bootloader.bin ifs_ufs.img


