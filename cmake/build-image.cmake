# Build an SD-Card image containing boot and root partitions
# This image can be written to an SD-Card using 'dd', BalenaEtcher
# or bmaptool.

add_custom_target ( image                
                     COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/cheviot-build/mk-kernel-img.sh 
                     COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/cheviot-build/mk-sdcard-image-ufs.sh 
                     WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/)
                     
set_target_properties(image PROPERTIES EXCLUDE_FROM_ALL TRUE)

