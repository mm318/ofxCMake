# Discover the core shipped with the selected OF release. Platform-specific
# sources are filtered in openFrameworksLinux.cmake.
set(OF_CORE_SOURCE_DIR "${OF_DIRECTORY_ABSOLUTE}/libs/openFrameworks")
file(GLOB_RECURSE OF_SOURCE_FILES CONFIGURE_DEPENDS
    "${OF_CORE_SOURCE_DIR}/*.cpp")

set(OF_CORE_HEADERS "${OF_CORE_SOURCE_DIR}")
file(GLOB OF_CORE_DIRECTORIES LIST_DIRECTORIES true "${OF_CORE_SOURCE_DIR}/*")
foreach(directory IN LISTS OF_CORE_DIRECTORIES)
    if(IS_DIRECTORY "${directory}")
        list(APPEND OF_CORE_HEADERS "${directory}")
    endif()
endforeach()

# These dependencies are provided by the official openFrameworks package.
# fmt is header-only in OF; its configuration must also reach application code.
foreach(dependency IN ITEMS glm json kiss tess2 utf8 fmt)
    set(include_dir "${OF_DIRECTORY_ABSOLUTE}/libs/${dependency}/include")
    if(NOT IS_DIRECTORY "${include_dir}")
        message(FATAL_ERROR
            "Missing openFrameworks dependency: ${include_dir}. "
            "Use the official 0.12.1 Linux package, or download its libraries first.")
    endif()
    list(APPEND OF_CORE_HEADERS "${include_dir}")
endforeach()
