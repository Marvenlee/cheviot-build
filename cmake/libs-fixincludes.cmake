cmake_minimum_required(VERSION 3.5)

include(ExternalProject)


ExternalProject_Add (
	fixincludes
	PREFIX            ${CMAKE_CURRENT_BINARY_DIR}/output
	SOURCE_DIR        ${CMAKE_CURRENT_SOURCE_DIR}/libs/fixincludes
	CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/libs/fixincludes/configure --host=arm-none-eabi
	                    --prefix=${CMAKE_CURRENT_BINARY_DIR}/build/native/
	                    --includedir=${CMAKE_CURRENT_BINARY_DIR}/build/native/arm-none-eabi/include/
	                    --libdir=${CMAKE_CURRENT_BINARY_DIR}/build/native/arm-none-eabi/lib/
	BUILD_ALWAYS      OFF
  DEPENDS           
  INSTALL_DIR       ${CMAKE_CURRENT_BINARY_DIR}/build/native/
	BUILD_COMMAND     make
  INSTALL_COMMAND   make install
)


add_custom_target(cleanfixincludes
  COMMAND           rm -rf ${CMAKE_CURRENT_BINARY_DIR}/output/src/fixincludes-build &&
                    rm -rf ${CMAKE_CURRENT_BINARY_DIR}/output/src/fixincludes-stamp
)


