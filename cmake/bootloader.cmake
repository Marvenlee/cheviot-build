cmake_minimum_required(VERSION 3.5)

include(ExternalProject)

ExternalProject_Add (
	bootloader
	PREFIX            ${CMAKE_CURRENT_BINARY_DIR}/output
	SOURCE_DIR        ${CMAKE_CURRENT_SOURCE_DIR}/cheviot-build/bootloader	
	CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/cheviot-build/bootloader/configure --host=arm-none-eabi
	                    --prefix=${CMAKE_CURRENT_BINARY_DIR}/build/host	
	BUILD_ALWAYS      ON
	INSTALL_DIR       ${CMAKE_CURRENT_BINARY_DIR}/build/host
	DEPENDS           skeleton-root newlib hal libs 
	BUILD_COMMAND     make
	INSTALL_COMMAND   pseudo make install
)

