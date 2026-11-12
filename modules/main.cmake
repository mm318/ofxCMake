if(CMAKE_VERSION VERSION_LESS 3.16)
    message(FATAL_ERROR "ofxCMake requires CMake 3.16 or newer.")
endif()
cmake_policy(SET CMP0057 NEW)

if(NOT CMAKE_SYSTEM_NAME STREQUAL "Linux" OR ANDROID)
    message(FATAL_ERROR "ofxCMake currently supports desktop Linux only.")
endif()

get_filename_component(OF_DIRECTORY_ABSOLUTE "${OF_DIRECTORY_BY_USER}" ABSOLUTE
    BASE_DIR "${CMAKE_CURRENT_SOURCE_DIR}")
if(NOT EXISTS "${OF_DIRECTORY_ABSOLUTE}/libs/openFrameworks/utils/ofConstants.h")
    message(FATAL_ERROR "OF_DIRECTORY_BY_USER must point to an openFrameworks 0.12.1 installation.")
endif()
# Resolve modules relative to this file, so ofxCMake can also live outside OF.
set(OF_CMAKE_MODULES "${CMAKE_CURRENT_LIST_DIR}")
get_filename_component(OF_CMAKE_ROOT "${OF_CMAKE_MODULES}/.." ABSOLUTE)
set(OF_CMAKE_ADDONS "${OF_CMAKE_ROOT}/addOns")
set(OF_CMAKE_LIBS "${CMAKE_CURRENT_BINARY_DIR}/lib")

# One C++ standard for the core, bundled C++ sources, add-ons and application.
# Follow upstream's C++20 default with GCC >= 10; C++17 is the minimum.
if(NOT DEFINED CMAKE_CXX_STANDARD)
    if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" AND CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 10)
        set(CMAKE_CXX_STANDARD 20)
    else()
        set(CMAKE_CXX_STANDARD 17)
    endif()
elseif(CMAKE_CXX_STANDARD LESS 17)
    message(FATAL_ERROR "openFrameworks 0.12.1 requires C++17 or newer.")
endif()
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include("${OF_CMAKE_MODULES}/openFrameworks.cmake")
include("${OF_CMAKE_MODULES}/openFrameworksLinux.cmake")
include("${OF_CMAKE_MODULES}/config.cmake")
include("${OF_CMAKE_MODULES}/addOns.cmake")
include("${OF_CMAKE_MODULES}/configLinux.cmake")
