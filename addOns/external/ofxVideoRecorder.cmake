# -----------------------------------------------------------------
# --- Script to search for all the .cpp files in the chosen folder
# -----------------------------------------------------------------

file( GLOB_RECURSE
      OFX_VIDEORECORDER_CPP
      "${OF_DIRECTORY_ABSOLUTE}/addons/ofxVideoRecorder/src/*.cpp" )

# -----------------------------------------------------------------
# --- Set ALL directories of the addOn, which contain .h files
# -----------------------------------------------------------------

include_directories("${OF_DIRECTORY_ABSOLUTE}/addons/ofxVideoRecorder/src")

# -----------------------------------------------------------------
# --- Set the keyword, so you can simply include the addOn
# -----------------------------------------------------------------

set_source_files_properties( ${OFX_VIDEORECORDER_CPP} PROPERTIES COMPILE_FLAGS "-std=c++11 -Wall" )

add_library( ofxVideoRecorder
             STATIC
             ${OFX_VIDEORECORDER_CPP} )

# -----------------------------------------------------------------
# --- Setting a compiled lib
# -----------------------------------------------------------------

set( EXTRA_LIBS_VIDEORECORDER )

target_link_libraries( ofxVideoRecorder ${EXTRA_LIBS_VIDEORECORDER} )
