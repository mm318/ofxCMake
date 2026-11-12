add_executable(${APP_NAME} ${${APP_NAME}_SOURCE_FILES})
target_link_libraries(${APP_NAME} PRIVATE ${OFX_ADDONS_ACTIVE} of_static)
set_target_properties(${APP_NAME} PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/lib"
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/lib"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/bin")

# Preserve the standard OF bin/data layout when building out of tree.
if(IS_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/bin/data")
    add_custom_command(TARGET ${APP_NAME} POST_BUILD
        COMMAND "${CMAKE_COMMAND}" -E copy_directory
            "${CMAKE_CURRENT_SOURCE_DIR}/bin/data" "$<TARGET_FILE_DIR:${APP_NAME}>/data"
        VERBATIM)
endif()
