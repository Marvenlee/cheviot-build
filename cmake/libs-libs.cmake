cmake_minimum_required(VERSION 3.5)

include(ExternalProject)


ExternalProject_Add (
	libs
	PREFIX            ${CMAKE_CURRENT_BINARY_DIR}/output
	SOURCE_DIR        ${CMAKE_CURRENT_SOURCE_DIR}/libs/libs
	CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/libs/libs/configure --host=arm-none-eabi
	                    --prefix=${CMAKE_CURRENT_BINARY_DIR}/build/native/
	                    --includedir=${CMAKE_CURRENT_BINARY_DIR}/build/native/arm-none-eabi/include/
	                    --libdir=${CMAKE_CURRENT_BINARY_DIR}/build/native/arm-none-eabi/lib/
	BUILD_ALWAYS      ON
  DEPENDS           gcc-native binutils-native newlib dtc
  INSTALL_DIR       ${CMAKE_CURRENT_BINARY_DIR}/build/native/
	BUILD_COMMAND     make
  INSTALL_COMMAND   make install
)


add_custom_target(cleanlibs
  COMMAND           rm -rf ${CMAKE_CURRENT_BINARY_DIR}/output/src/libs-build &&
                    rm -rf ${CMAKE_CURRENT_BINARY_DIR}/output/src/libs-stamp
)


