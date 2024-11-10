cmake_minimum_required(VERSION 3.5)

include(ExternalProject)

ExternalProject_Add (
	utils-tests
	PREFIX            ${CMAKE_CURRENT_BINARY_DIR}/output
	SOURCE_DIR        ${CMAKE_CURRENT_SOURCE_DIR}/utils/tests
	CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/utils/tests/configure --host=arm-none-eabi
	                    --prefix=${CMAKE_CURRENT_BINARY_DIR}/build/host	
	BUILD_ALWAYS      ON
	INSTALL_DIR       ${CMAKE_CURRENT_BINARY_DIR}/build/host
	DEPENDS           newlib hal libtask libs
	BUILD_COMMAND     make
	INSTALL_COMMAND   pseudo make install
)


add_custom_target(cleantests
  COMMAND           rm -rf ${CMAKE_CURRENT_BINARY_DIR}/output/src/tests-build &&
                    rm -rf ${CMAKE_CURRENT_BINARY_DIR}/output/src/tests-stamp
)

