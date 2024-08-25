cmake_minimum_required(VERSION 3.29.0)
project(test LANGUAGES Fortran CXX)

set(MODULE_OUTPUT_DIR ${CMAKE_BINARY_DIR}/modules)

add_subdirectory(fort_modules)
add_subdirectory(src)