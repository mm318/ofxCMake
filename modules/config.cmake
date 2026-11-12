# Shared usage requirements keep core, add-ons and applications ABI-compatible.
add_library(of_dependencies INTERFACE)
target_include_directories(of_dependencies INTERFACE ${OF_CORE_HEADERS})
target_compile_features(of_dependencies INTERFACE cxx_std_17)
target_compile_definitions(of_dependencies INTERFACE ${OF_CORE_DEFINITIONS})
target_link_libraries(of_dependencies INTERFACE ${OF_CORE_LIBS})

add_library(core OBJECT ${OF_SOURCE_FILES})
target_link_libraries(core PUBLIC of_dependencies)
set_target_properties(core PROPERTIES POSITION_INDEPENDENT_CODE ON)

add_library(of_static STATIC $<TARGET_OBJECTS:core>)
target_link_libraries(of_static PUBLIC of_dependencies)
set_target_properties(of_static PROPERTIES
    OUTPUT_NAME openFrameworksStatic
    ARCHIVE_OUTPUT_DIRECTORY "${OF_CMAKE_LIBS}")
