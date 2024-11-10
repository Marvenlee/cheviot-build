cmake_minimum_required(VERSION 3.5)

include(ExternalProject)

ExternalProject_Add (
	filesystems
	PREFIX            ${CMAKE_CURRENT_BINARY_DIR}/output
	SOURCE_DIR        ${CMAKE_CURRENT_SOURCE_DIR}/filesystems	
	CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/filesystems/configure --host=arm-none-eabi
	                    --prefix=${CMAKE_CURRENT_BINARY_DIR}/build/host	
	BUILD_ALWAYS      ON
	INSTALL_DIR       ${CMAKE_CURRENT_BINARY_DIR}/build/host
	DEPENDS           newlib hal libs 
	BUILD_COMMAND     make
	INSTALL_COMMAND   pseudo make install
)


add_custom_target(cleanfilesystems
  COMMAND           rm -rf ${CMAKE_CURRENT_BINARY_DIR}/output/src/filesystems-build &&
                    rm -rf ${CMAKE_CURRENT_BINARY_DIR}/output/src/filesystems-stamp
)

