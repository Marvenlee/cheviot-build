# Setup the build/host directory structure, effectively laying the keel
# of the project.  Creates the directory tree starting from the root '/'
# directory pointed to by the --prefix option.
#
# The BSD makefs utility and root.mtree spec file will set the correct
# mode, user and group ID bits for each file in the generated image.
# These specified here are ignored.
#
#

install-data-local:
	install -d $(prefix)/bin
	install -d $(prefix)/boot
	install -d $(prefix)/dev
	install -d $(prefix)/etc
	install -d $(prefix)/etc/opt
	install -d $(prefix)/home
	install -d $(prefix)/lib
	install -d $(prefix)/lib/firmware
	install -d $(prefix)/lib/firmware/dt
	install -d $(prefix)/media
	install -d $(prefix)/media/boot
	install -d $(prefix)/media/root
	install -d $(prefix)/mnt
	install -d $(prefix)/opt
	install -d $(prefix)/opt/tests
	install -d $(prefix)/root 
	install -d $(prefix)/sbin
	install -d $(prefix)/serv
	install -d $(prefix)/sys
	install -d $(prefix)/system
	install -d $(prefix)/system/filesystems
	install -d $(prefix)/system/drivers
	install -d $(prefix)/system/servers	
	install -d $(prefix)/tmp
	install -d $(prefix)/usr
	install -d $(prefix)/usr/bin
	install -d $(prefix)/usr/lib
	install -d $(prefix)/usr/sbin
	install -d $(prefix)/var
	install -d $(prefix)/var/log
	install -d $(prefix)/etc
	install -t $(prefix)/lib/firmware/dt/ \
					$(srcdir)/root/lib/firmware/dt/rpi4.dtb
	install -t $(prefix)/etc/ \
					$(srcdir)/root/etc/profile \
					$(srcdir)/root/etc/s.startup \
					$(srcdir)/root/etc/s.shutdown \
					$(srcdir)/root/etc/termcap \
					$(srcdir)/root/etc/ttys
															



