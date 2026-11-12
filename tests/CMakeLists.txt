cmake_minimum_required(VERSION 3.16)
project(ofxCMakeSmoke LANGUAGES C CXX)

set(OF_DIRECTORY_BY_USER "" CACHE PATH "openFrameworks 0.12.1 installation")
set(OFX_ADDONS_ACTIVE "" CACHE STRING "Add-ons to compile and link in the smoke test")
set(APP_NAME ofxcmake_smoke)
set(ofxcmake_smoke_SOURCE_FILES "${CMAKE_CURRENT_LIST_DIR}/main.cpp")
include("${CMAKE_CURRENT_LIST_DIR}/../modules/main.cmake")
foreach(addon IN LISTS OFX_ADDONS_ACTIVE)
    target_compile_definitions(ofxcmake_smoke PRIVATE "OFX_TEST_${addon}")
endforeach()

enable_testing()
add_test(NAME core_and_data COMMAND ofxcmake_smoke)
set_tests_properties(core_and_data PROPERTIES
    WORKING_DIRECTORY "$<TARGET_FILE_DIR:ofxcmake_smoke>")
