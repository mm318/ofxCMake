# Desktop Linux backend, following OF 0.12.1's config.linux.common.mk.
list(FILTER OF_SOURCE_FILES EXCLUDE REGEX
    "/(ofAppEGLWindow|ofAppGlutWindow|ofDirectShowGrabber|ofDirectShowPlayer|ofMediaFoundationPlayer|ofMediaFoundationSoundPlayer|ofFmodSoundPlayer)\\.cpp$")

# Select bundled archives using the target architecture, never the host's.
if(NOT OF_PLATFORM)
    if(CMAKE_SYSTEM_PROCESSOR MATCHES "^(x86_64|amd64|AMD64)$")
        set(OF_PLATFORM linux64)
    elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(aarch64|arm64)$")
        set(OF_PLATFORM linuxaarch64)
    elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(i[3-6]86|x86)$")
        set(OF_PLATFORM linux)
    else()
        message(FATAL_ERROR
            "Unsupported desktop Linux architecture: ${CMAKE_SYSTEM_PROCESSOR}")
    endif()
endif()

set(OF_CORE_LIBS "")
foreach(dependency IN ITEMS kiss tess2)
    set(archive "${OF_DIRECTORY_ABSOLUTE}/libs/${dependency}/lib/${OF_PLATFORM}/lib${dependency}.a")
    if(NOT EXISTS "${archive}")
        message(FATAL_ERROR "Missing openFrameworks library: ${archive}. Download the libraries for ${OF_PLATFORM}.")
    endif()
    list(APPEND OF_CORE_LIBS "${archive}")
endforeach()

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}")
find_package(PkgConfig REQUIRED)
find_package(Threads REQUIRED)
find_package(FreeImage REQUIRED)
find_package(PugiXML REQUIRED)

# Imported pkg-config targets preserve include paths, library search paths and
# compiler/linker flags, including dependencies installed outside /usr.
pkg_check_modules(OF_SYSTEM REQUIRED IMPORTED_TARGET
    cairo zlib gstreamer-app-1.0 gstreamer-video-1.0 gstreamer-base-1.0
    gstreamer-1.0 libudev freetype2 fontconfig sndfile openal
    libpulse-simple alsa gl glu glew glfw3 openssl
    x11 xrandr xxf86vm xi xcursor)
pkg_search_module(OF_CURL REQUIRED IMPORTED_TARGET libcurl libcurl4)
pkg_search_module(OF_URI REQUIRED IMPORTED_TARGET liburiparser uriparser)
pkg_search_module(RTAUDIO QUIET IMPORTED_TARGET rtaudio librtaudio)
if(RTAUDIO_FOUND)
    list(APPEND OF_CORE_LIBS PkgConfig::RTAUDIO)
else()
    find_package(RtAudio REQUIRED)
    list(APPEND OF_CORE_HEADERS "${RTAUDIO_INCLUDE_DIR}")
    list(APPEND OF_CORE_LIBS ${RTAUDIO_LIBRARIES})
endif()

list(APPEND OF_CORE_HEADERS "${FREEIMAGE_INCLUDE_PATH}" "${PUGIXML_INCLUDE_DIR}")
list(APPEND OF_CORE_LIBS
    PkgConfig::OF_SYSTEM PkgConfig::OF_CURL PkgConfig::OF_URI
    ${FREEIMAGE_LIBRARIES} ${PUGIXML_LIBRARIES} Threads::Threads ${CMAKE_DL_LIBS})
set(OF_CORE_DEFINITIONS GCC_HAS_REGEX FMT_HEADER_ONLY)

# Optional features use the same detection and defines as upstream OF.
pkg_search_module(OF_GTK QUIET IMPORTED_TARGET gtk+-3.0 gtk+-2.0)
if(OF_GTK_FOUND)
    list(APPEND OF_CORE_LIBS PkgConfig::OF_GTK)
    list(APPEND OF_CORE_DEFINITIONS OF_USING_GTK)
endif()
pkg_check_modules(OF_MPG123 QUIET IMPORTED_TARGET libmpg123)
if(OF_MPG123_FOUND)
    list(APPEND OF_CORE_LIBS PkgConfig::OF_MPG123)
    list(APPEND OF_CORE_DEFINITIONS OF_USING_MPG123)
endif()

# GCC 8's implementation of std::filesystem needs a separate library.
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" AND CMAKE_CXX_COMPILER_VERSION VERSION_LESS 9)
    list(APPEND OF_CORE_LIBS stdc++fs)
endif()
