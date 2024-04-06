cmake_minimum_required(VERSION 3.5)

include(ExternalProject)

ExternalProject_Add (
	pseudo-native
	GIT_REPOSITORY    git://git.yoctoproject.org/pseudo
	PREFIX            ${CMAKE_CURRENT_BINARY_DIR}/output
	SOURCE_DIR        ${CMAKE_CURRENT_BINARY_DIR}/cheviot-build/pseudo
	CONFIGURE_COMMAND cd ${CMAKE_CURRENT_BINARY_DIR}/cheviot-build/pseudo/ && ${CMAKE_CURRENT_BINARY_DIR}/cheviot-build/pseudo/configure --prefix=${CMAKE_CURRENT_BINARY_DIR}/build/native
	BUILD_ALWAYS      OFF
	INSTALL_DIR       ${CMAKE_CURRENT_BINARY_DIR}/build/native/
	BUILD_COMMAND     make -C ${CMAKE_CURRENT_BINARY_DIR}/cheviot-build/pseudo/
	INSTALL_COMMAND   make -C ${CMAKE_CURRENT_BINARY_DIR}/cheviot-build/pseudo/ install
)

set_target_properties( pseudo-native PROPERTIES EXCLUDE_FROM_ALL TRUE)

