file(GLOB OFX_ASSIMP_CPP CONFIGURE_DEPENDS
    "${OF_DIRECTORY_ABSOLUTE}/addons/ofxAssimpModelLoader/src/*.cpp")
pkg_check_modules(OF_ASSIMP REQUIRED IMPORTED_TARGET assimp)
add_library(ofxAssimpModelLoader STATIC ${OFX_ASSIMP_CPP})
target_link_libraries(ofxAssimpModelLoader PkgConfig::OF_ASSIMP)
include_directories("${OF_DIRECTORY_ABSOLUTE}/addons/ofxAssimpModelLoader/src")
