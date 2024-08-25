set(MODULE_SOURCES
    ${CMAKE_SOURCE_DIR}/fort_modules/module1.f90
    ${CMAKE_SOURCE_DIR}/fort_modules/module2.f90
)

add_library(modules STATIC ${MODULE_SOURCES})
set_target_properties(modules PROPERTIES Fortran_MODULE_DIRECTORY ${MODULE_OUTPUT_DIR})

# Set search dir for every target that links to it
target_include_directories(modules PUBLIC ${MODULE_OUTPUT_DIR})