
# ============================================================================
# ------------------------------ Compiler Flags ------------------------------
set_source_files_properties( ${OF_SOURCE_FILES} ${${APP_NAME}_SOURCE_FILES} 
                             PROPERTIES COMPILE_FLAGS "-std=c++11 -Wall" )

# ============================================================================
# ------------------------------ Compile and Link ----------------------------
add_executable( ${APP_NAME} ${${APP_NAME}_SOURCE_FILES} )

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -no-pie")

target_link_libraries( ${APP_NAME}
                       of_static
                       ${OFX_ADDONS_ACTIVE}
                       )
