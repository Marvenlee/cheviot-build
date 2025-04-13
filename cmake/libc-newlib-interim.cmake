cmake_minimum_required(VERSION 3.5)

include(ExternalProject)

if(DEFINED ENV{BOARD})
  if("$ENV{BOARD}" STREQUAL "raspberrypi4")
    set(CFLAGS_FOR_RPI  "-mcpu=cortex-a72 -mfpu=vfpv3-d16")
  elseif("$ENV{BOARD}" STREQUAL "raspberrypi1")
    set(CFLAGS_FOR_RPI "-mcpu=arm1176jzf-s")
  else()
    message( FATAL_ERROR "CFLAGS_FOR_RPI unknown value" )
  endif()
else()
  message( FATAL_ERROR "CFLAGS_FOR_RPI undefined" )
endif()

ExternalProject_Add (
  newlib-interim
  PREFIX            ${CMAKE_CURRENT_BINARY_DIR}/output
  SOURCE_DIR        ${CMAKE_CURRENT_SOURCE_DIR}/libc/newlib/	
  CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/libc/newlib/configure
	                    --prefix=${CMAKE_CURRENT_BINARY_DIR}/build/native/
	                    --target=arm-none-eabi --disable-newlib-supplied-syscalls
	                    --enable-interwork --enable-multilib
	                    CFLAGS_FOR_TARGET=${CFLAGS_FOR_RPI}
  BUILD_ALWAYS      ON
  DEPENDS           fixincludes gcc-native-install binutils-native skeleton-root
  INSTALL_DIR       ${CMAKE_CURRENT_BINARY_DIR}/build/native/
  BUILD_COMMAND     make
  INSTALL_COMMAND   make install
)

