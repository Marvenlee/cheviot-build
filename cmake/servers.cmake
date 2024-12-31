cmake_minimum_required(VERSION 3.5)

include(ExternalProject)

ExternalProject_Add (
	servers
	PREFIX            ${CMAKE_CURRENT_BINARY_DIR}/output
	SOURCE_DIR        ${CMAKE_CURRENT_SOURCE_DIR}/servers	
	CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/servers/configure --host=arm-none-eabi
	                    --prefix=${CMAKE_CURRENT_BINARY_DIR}/build/host	
	BUILD_ALWAYS      ON
	INSTALL_DIR       ${CMAKE_CURRENT_BINARY_DIR}/build/host
	DEPENDS           newlib hal libtask dtc libs 
	BUILD_COMMAND     make
	INSTALL_COMMAND   pseudo make install
)

add_custom_target(cleanservers
  COMMAND           rm -rf ${CMAKE_CURRENT_BINARY_DIR}/output/src/servers-build &&
                    rm -rf ${CMAKE_CURRENT_BINARY_DIR}/output/src/servers-stamp
)

