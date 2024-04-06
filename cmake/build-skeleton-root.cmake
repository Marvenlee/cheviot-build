# Setup the build/host directory structure, effectively laying the keel
# of the project. See skeleton/Makefile.am for the directory creation
# and root subdirectory for contents to be copied.

ExternalProject_Add (
	skeleton-root
	PREFIX            ${CMAKE_CURRENT_BINARY_DIR}/output
	SOURCE_DIR        ${CMAKE_CURRENT_SOURCE_DIR}/cheviot-build/skeleton-root	
	CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/cheviot-build/skeleton-root/configure
	                   --prefix=${CMAKE_CURRENT_BINARY_DIR}/build/host/
	BUILD_ALWAYS      OFF
	INSTALL_DIR       ${CMAKE_CURRENT_BINARY_DIR}/build/host/
	DEPENDS           
	INSTALL_COMMAND   pseudo make install
)

