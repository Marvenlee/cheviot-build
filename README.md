# cheviot-build

A repository containing scripts and makefiles to build CheviotOS.

This repository is brought in to the cheviot-project base repository as a
git submodule.

# Overview

See the top-level cheviot-project repository for build instructions.

## bootloader

A bootloader that bootstraps the kernel on the Raspberry Pi. This is
linked with the Initial File System (IFS) image which contains the
files such as kernel and driver that are necessary to bootstrap the OS.

## cmake

Cmake is used as a "meta" build system, invoking configure scripts
and makefiles in order to build the executables and generate the final
image. The files in this folder are included from the top-level
CMakeLists.txt in the cheviot-project repository.

## mkifs

A tool running on the development platform that copies the contents
of a directory into an IFS image.  The IFS contains the generated
binary files for the kernel, drivers, filesystem and init process
needed to bootstrap the OS.

## skeleton-boot

Files needed on the FAT partition of the Raspberry Pi SD-Card in
order to boot.  These are mainly binary blobs from Broadcom.

## skeleton-root

A skeleton of the root file system to put on the SD-Card's root
partition. This directory contains files that are not part of the
install steps of other projects that make up the OS.  For example,
certain config files in /etc are placed here.

## mk-kernel-img.sh

A script to make a combined image of the bootloader binary and
the Initial File System containing the kernel and drivers.
This is called by the final "make image" step of the build.

## mk-sd-card-image.sh

This is a script to create the SD Card image containing a FAT
boot partition and ext2 formatted root file system containing
all the files built by the project.  This is called by the final
"make image" step of the build.

The resulting image can then be copied onto and SD-Card with the
"dd" command or tools such as Balena Etcher.

# Licenses and Acknowledgements

The binary blobs, fixup4.dat start4.elf, bootcode.bin and start.elf in
skeleton-boot are copyright of Broadcom. See the file *LICENSE.broadcom*
in the skeleton-boot directory.

