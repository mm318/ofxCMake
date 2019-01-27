# ============================================================================
# ---------------------------- Source Files ----------------------------------
list( APPEND OF_SOURCE_FILES
        ${OF_DIRECTORY_ABSOLUTE}/libs/openFrameworks/video/ofGstUtils.cpp
        ${OF_DIRECTORY_ABSOLUTE}/libs/openFrameworks/video/ofGstVideoGrabber.cpp
        ${OF_DIRECTORY_ABSOLUTE}/libs/openFrameworks/video/ofGstVideoPlayer.cpp
        )

# ============================================================================
# --------------------------- Include Folders --------------------------------

# ------------------ Putting the includes into one list ----------------------
list( APPEND OF_CORE_HEADERS ${OF_DIRECTORY_ABSOLUTE}/libs/kiss/include)

# ============================================================================
# ------------------------------ Libraries -----------------------------------

# ---- shared
set( LIB_FMODEX ${OF_DIRECTORY_ABSOLUTE}/libs/fmodex/lib/linux64/libfmodex.so )

set( OF_CORE_LIBS
        ${OF_DIRECTORY_ABSOLUTE}/libs/kiss/lib/linux64/libkiss.a
        ${OF_DIRECTORY_ABSOLUTE}/libs/tess2/lib/linux64/libtess2.a
        )

# ============================================================================
# ----------------------------- System Frameworks ----------------------------
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${CMAKE_CURRENT_LIST_DIR})

find_package(PkgConfig REQUIRED)
pkg_search_module(CAIRO REQUIRED cairo)
pkg_search_module(GLFW REQUIRED glfw3)
pkg_search_module(URIPARSER REQUIRED uriparser liburiparser)
pkg_search_module(SNDFILE REQUIRED sndfile)
pkg_search_module(UDEV REQUIRED udev libudev)
pkg_search_module(RTAUDIO QUIET rtaudio)

find_package(ALSA REQUIRED)
find_package(GLEW REQUIRED)
find_package(GLUT REQUIRED)
find_package(OpenAL REQUIRED)
find_package(FreeImage REQUIRED)
find_package(GStreamer REQUIRED)
find_package(CURL REQUIRED)
find_package(PugiXML REQUIRED)
if(NOT RTAUDIO_FOUND)
    find_package(RtAudio REQUIRED)
endif()

include_directories( ${CAIRO_INCLUDE_DIRS} )
include_directories( ${GLFW_INCLUDE_DIRS} )
include_directories( ${URIPARSER_INCLUDE_DIRS} )
include_directories( ${SNDFILE_INCLUDE_DIRS} )
include_directories( ${RTAUDIO_INCLUDE_DIRS} )
include_directories( ${PUGIXML_INCLUDE_DIRS} )
include_directories( ${UDEV_INCLUDE_DIRS} )
include_directories( ${ALSA_INCLUDE_DIRS} )
include_directories( ${GLEW_INCLUDE_DIRS} )
include_directories( ${GLUT_INCLUDE_DIRS} )
include_directories( ${OPENAL_INCLUDE_DIRS} )
include_directories( ${FREEIMAGE_INCLUDE_DIRS} )
include_directories( ${GSTREAMER_INCLUDE_DIRS} )
include_directories( ${GSTREAMER_APP_INCLUDE_DIRS} )
include_directories( ${GSTREAMER_BASE_INCLUDE_DIRS} )
include_directories( ${GSTREAMER_VIDEO_INCLUDE_DIRS} )
include_directories( ${CURL_INCLUDE_DIRS} )

set( OF_CORE_FRAMEWORKS
        z
        gstapp-1.0
        gstvideo-1.0
        gstbase-1.0
        gstreamer-1.0
        udev
        fontconfig
        freetype
        sndfile
        openal
        # ssl
        # crypto
        curl
        pulse-simple
        pulse
        asound
        GLEW
        GLU
        GL
        # pangocairo-1.0
        # gdk_pixbuf-2.0
        cairo-gobject
        # pango-1.0
        cairo
        # gtk-3
        # gdk-3
        # atk-1.0
        gio-2.0
        gobject-2.0
        glib-2.0
        # mpg123
        glut
        glfw
        X11
        Xrandr
        Xxf86vm
        dl
        # Xinerama
        # Xcursor
        # Xi
        dl
        pthread
        freeimage
        boost_filesystem
        boost_system
        uriparser
        ${LIB_FMODEX}   # SHARED
        )
