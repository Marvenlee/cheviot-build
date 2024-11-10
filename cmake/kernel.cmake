set(CFLAGS "--march=armv6")
set(CMAKE_C_FLAGS "--march=armv6")

ExternalProject_Add (
	kernel
	PREFIX            ${CMAKE_CURRENT_BINARY_DIR}/output
	SOURCE_DIR        ${CMAKE_CURRENT_SOURCE_DIR}/kernel	
	CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/kernel/configure --host=arm-none-eabi
	                  --prefix=${CMAKE_CURRENT_BINARY_DIR}/build/host/boot
	BUILD_ALWAYS      ON
	INSTALL_DIR       ${CMAKE_CURRENT_BINARY_DIR}/build/host/boot
	DEPENDS           newlib hal
	BUILD_COMMAND     make
	INSTALL_COMMAND   pseudo make install
)


add_custom_target(cleankernel
  COMMAND           rm -rf ${CMAKE_CURRENT_BINARY_DIR}/output/src/kernel-build &&
                    rm -rf ${CMAKE_CURRENT_BINARY_DIR}/output/src/kernel-stamp
)

