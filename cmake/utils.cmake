cmake_minimum_required(VERSION 3.5)

include(ExternalProject)

ExternalProject_Add (
	utils
	PREFIX            ${CMAKE_CURRENT_BINARY_DIR}/output
	SOURCE_DIR        ${CMAKE_CURRENT_SOURCE_DIR}/utils/utils	
	CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/utils/utils/configure --host=arm-none-eabi
	                    --prefix=${CMAKE_CURRENT_BINARY_DIR}/build/host	
	BUILD_ALWAYS      ON
	INSTALL_DIR       ${CMAKE_CURRENT_BINARY_DIR}/build/host
	DEPENDS           newlib hal libtask libs 
	BUILD_COMMAND     make
	INSTALL_COMMAND   pseudo make install
)



