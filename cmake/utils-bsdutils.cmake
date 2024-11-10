cmake_minimum_required(VERSION 3.5)

include(ExternalProject)

ExternalProject_Add (
	bsdutils
	PREFIX            ${CMAKE_CURRENT_BINARY_DIR}/output
	SOURCE_DIR        ${CMAKE_CURRENT_SOURCE_DIR}/utils/bsdutils	
	CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/utils/bsdutils/configure
	                    --host=arm-none-eabi
	                    --prefix=${CMAKE_CURRENT_BINARY_DIR}/build/host	
	BUILD_ALWAYS      OFF
	INSTALL_DIR       ${CMAKE_CURRENT_BINARY_DIR}/build/host
	DEPENDS           newlib hal libs bsdlibs 
	BUILD_COMMAND     make
	INSTALL_COMMAND   pseudo make install
)


add_custom_target(cleanbsdutils
  COMMAND           rm -rf ${CMAKE_CURRENT_BINARY_DIR}/output/src/bsdutils-build &&
                    rm -rf ${CMAKE_CURRENT_BINARY_DIR}/output/src/bsdutils-stamp
)

