file(GLOB OFX_OPENCV_CPP CONFIGURE_DEPENDS
    "${OF_DIRECTORY_ABSOLUTE}/addons/ofxOpenCv/src/*.cpp")
pkg_check_modules(OF_OPENCV REQUIRED IMPORTED_TARGET opencv4 harfbuzz)
add_library(ofxOpenCv STATIC ${OFX_OPENCV_CPP})
target_link_libraries(ofxOpenCv PkgConfig::OF_OPENCV)
include_directories("${OF_DIRECTORY_ABSOLUTE}/addons/ofxOpenCv/src")
