# Setup the build/host directory structure, effectively laying the keel
# of the project.  Creates the directory tree starting from the root '/'
# directory pointed to by the --prefix option.
#
# This script will be run by pseudo, so will all directories will be owned
# by "root" whenever pseudo is run.  Pseudo is also used to install files
# in other recipes so these all gain root ownership and avoids host uid/gid
# pollution.
#
#

install-data-local:
	install -o 0 -g 0 -m 0755 -d $(prefix)/bin
	install -o 0 -g 0 -m 0755 -d $(prefix)/boot
	install -o 0 -g 0 -m 0755 -d $(prefix)/dev
	install -o 0 -g 0 -m 0755 -d $(prefix)/etc
	install -o 0 -g 0 -m 0755 -d $(prefix)/etc/opt
	install -o 0 -g 0 -m 0755 -d $(prefix)/home
	install -o 0 -g 0 -m 0755 -d $(prefix)/lib
	install -o 0 -g 0 -m 0755 -d $(prefix)/lib/firmware
	install -o 0 -g 0 -m 0755 -d $(prefix)/lib/firmware/dt
	install -o 0 -g 0 -m 0755 -d $(prefix)/media
	install -o 0 -g 0 -m 0755 -d $(prefix)/media/boot
	install -o 0 -g 0 -m 0755 -d $(prefix)/media/root
	install -o 0 -g 0 -m 0755 -d $(prefix)/mnt
	install -o 0 -g 0 -m 0755 -d $(prefix)/opt
	install -o 0 -g 0 -m 0755 -d $(prefix)/opt/tests
	install -o 0 -g 0 -m 0700 -d $(prefix)/root 
	install -o 0 -g 0 -m 0755 -d $(prefix)/sbin
	install -o 0 -g 0 -m 0755 -d $(prefix)/serv
	install -o 0 -g 0 -m 0755 -d $(prefix)/sys
	install -o 0 -g 0 -m 0755 -d $(prefix)/system
	install -o 0 -g 0 -m 0755 -d $(prefix)/system/filesystems
	install -o 0 -g 0 -m 0755 -d $(prefix)/system/drivers
	install -o 0 -g 0 -m 0755 -d $(prefix)/system/servers	
	install -o 0 -g 0 -m 0755 -d $(prefix)/tmp
	install -o 0 -g 0 -m 0755 -d $(prefix)/usr
	install -o 0 -g 0 -m 0755 -d $(prefix)/usr/bin
	install -o 0 -g 0 -m 0755 -d $(prefix)/usr/lib
	install -o 0 -g 0 -m 0755 -d $(prefix)/usr/sbin
	install -o 0 -g 0 -m 0755 -d $(prefix)/var
	install -o 0 -g 0 -m 0755 -d $(prefix)/var/log
	install -o 0 -g 0 -m 0755 -d $(prefix)/etc
	install -o 0 -g 0 -m 0755 -t $(prefix)/lib/firmware/dt/ \
					$(srcdir)/root/lib/firmware/dt/rpi4.dtb
	install -o 0 -g 0 -m 0755 -t $(prefix)/etc/ \
					$(srcdir)/root/etc/profile \
					$(srcdir)/root/etc/s.startup \
					$(srcdir)/root/etc/s.shutdown \
					$(srcdir)/root/etc/termcap \
					$(srcdir)/root/etc/ttys
															



