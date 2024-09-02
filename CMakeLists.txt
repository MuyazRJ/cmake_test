cmake_minimum_required(VERSION 3.29.0)
project(test LANGUAGES Fortran CXX)

set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/install)
set(MODULE_OUTPUT_DIR ${CMAKE_BINARY_DIR}/modules)

function(install_py_files)
    if(${CMAKE_CURRENT_SOURCE_DIR} STREQUAL ${CMAKE_SOURCE_DIR})
        set(relative_path ".")  # Set relative path to empty string for the root directory
    else()
        string(REPLACE "${CMAKE_SOURCE_DIR}/" "" relative_path ${CMAKE_CURRENT_SOURCE_DIR})
    endif()

    file(GLOB PY_FILES "*.py")
    install(FILES ${PY_FILES} DESTINATION ${relative_path})
endfunction()

install_py_files()

add_subdirectory(tools)