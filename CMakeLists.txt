cmake_minimum_required(VERSION 3.29.0)
project(test LANGUAGES Fortran CXX)

set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/install)
set(MODULE_OUTPUT_DIR ${CMAKE_BINARY_DIR}/modules)

add_subdirectory(tools)

file(GLOB PY_FILES "*.py")
install(FILES ${PY_FILES} DESTINATION .)

