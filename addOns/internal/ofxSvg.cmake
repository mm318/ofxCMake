set(OFX_SVG_DIR "${OF_DIRECTORY_ABSOLUTE}/addons/ofxSvg")
file(GLOB OFX_SVG_CPP CONFIGURE_DEPENDS "${OFX_SVG_DIR}/src/*.cpp")
add_library(ofxSvg STATIC ${OFX_SVG_CPP})
include_directories(
    "${OFX_SVG_DIR}/src"
    "${OFX_SVG_DIR}/libs/svgtiny/include")

set(OFX_SVG_LIBRARIES "")
foreach(dependency IN ITEMS svgtiny xml2)
    if(dependency STREQUAL "xml2")
        set(library_dir libxml2)
    else()
        set(library_dir svgtiny)
    endif()
    set(archive "${OFX_SVG_DIR}/libs/${library_dir}/lib/${OF_PLATFORM}/lib${dependency}.a")
    if(NOT EXISTS "${archive}")
        message(FATAL_ERROR "Missing ofxSvg library: ${archive}. Download the openFrameworks libraries first.")
    endif()
    list(APPEND OFX_SVG_LIBRARIES "${archive}")
endforeach()
# libxml2's static archive uses zlib, lzma and libm on Linux.
pkg_check_modules(OF_SVG_SYSTEM REQUIRED IMPORTED_TARGET zlib liblzma)
target_link_libraries(ofxSvg ${OFX_SVG_LIBRARIES} PkgConfig::OF_SVG_SYSTEM m)
