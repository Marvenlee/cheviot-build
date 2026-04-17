
cmake_minimum_required(VERSION 3.5)

include(ExternalProject)

ExternalProject_Add (
	createrpikernelimg
	PREFIX            ${CMAKE_CURRENT_BINARY_DIR}/output
	SOURCE_DIR        ${CMAKE_CURRENT_SOURCE_DIR}/cheviot-build/createrpikernelimg	
	CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/cheviot-build/createrpikernelimg/configure
	                    --prefix=${CMAKE_CURRENT_BINARY_DIR}/build/native
	BUILD_ALWAYS      OFF
	INSTALL_DIR       ${CMAKE_CURRENT_BINARY_DIR}/build/native
	BUILD_COMMAND     make
)

