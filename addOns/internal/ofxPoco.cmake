# -----------------------------------------------------------------
# --- Script to search for all the .cpp files in the chosen folder
# -----------------------------------------------------------------

file( GLOB_RECURSE
      OFX_POCO_CPP
      "${OF_DIRECTORY_ABSOLUTE}/addons/ofxPoco/*.cpp" )

# -----------------------------------------------------------------
# --- Set ALL directories of the addOn, which contain .h files
# -----------------------------------------------------------------

include_directories("${OF_DIRECTORY_ABSOLUTE}/addons/ofxPoco/src"
                    "${OF_DIRECTORY_ABSOLUTE}/addons/ofxPoco/libs/poco/include")

# -----------------------------------------------------------------
# --- Set the keyword, so you can simply include the addOn
# -----------------------------------------------------------------

set_source_files_properties( ${OFX_POCO_CPP} PROPERTIES COMPILE_FLAGS "-std=c++11 -Wall" )

add_library( ofxPoco
             STATIC
             ${OFX_POCO_CPP} )

# -----------------------------------------------------------------
# --- Setting a compiled lib
# -----------------------------------------------------------------

set( EXTRA_LIBS_POCO
     ${OF_DIRECTORY_ABSOLUTE}/addons/ofxPoco/libs/poco/lib/linux64/libPocoUtil.a
     ${OF_DIRECTORY_ABSOLUTE}/addons/ofxPoco/libs/poco/lib/linux64/libPocoCrypto.a
     ${OF_DIRECTORY_ABSOLUTE}/addons/ofxPoco/libs/poco/lib/linux64/libPocoEncodings.a
     ${OF_DIRECTORY_ABSOLUTE}/addons/ofxPoco/libs/poco/lib/linux64/libPocoJSON.a
     ${OF_DIRECTORY_ABSOLUTE}/addons/ofxPoco/libs/poco/lib/linux64/libPocoNet.a
     ${OF_DIRECTORY_ABSOLUTE}/addons/ofxPoco/libs/poco/lib/linux64/libPocoNetSSL.a
     ${OF_DIRECTORY_ABSOLUTE}/addons/ofxPoco/libs/poco/lib/linux64/libPocoRedis.a
     ${OF_DIRECTORY_ABSOLUTE}/addons/ofxPoco/libs/poco/lib/linux64/libPocoXML.a
     ${OF_DIRECTORY_ABSOLUTE}/addons/ofxPoco/libs/poco/lib/linux64/libPocoZip.a
     ${OF_DIRECTORY_ABSOLUTE}/addons/ofxPoco/libs/poco/lib/linux64/libPocoFoundation.a
     )

target_link_libraries( ofxPoco ${EXTRA_LIBS_POCO} )
