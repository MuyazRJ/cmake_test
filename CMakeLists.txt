cmake_minimum_required(VERSION 3.29.0)
project(test LANGUAGES Fortran CXX)

set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/install)
set(MODULE_OUTPUT_DIR ${CMAKE_BINARY_DIR}/modules)

function(install_py_files directory)
    # Check if the provided directory is the root directory
    if(${directory} STREQUAL ${CMAKE_SOURCE_DIR})
        set(relative_path ".")  # Set relative path to empty string for the root directory
    else()
        string(REPLACE "${CMAKE_SOURCE_DIR}/" "" relative_path ${directory})
    endif()

    # Find Python files in the specified directory
    file(GLOB PY_FILES "${directory}/*.py")

    # Install the files to the destination path relative to the source directory
    install(FILES ${PY_FILES} DESTINATION ${relative_path})
endfunction()

install_py_files(${CMAKE_SOURCE_DIR})
install_py_files(${CMAKE_SOURCE_DIR}/tools)
install_py_files(${CMAKE_SOURCE_DIR}/tools/temps)

function(install_py_files)
    foreach(directory IN LISTS ARGV)  # Iterate over all passed directories
        # Check if the provided directory is the root directory
        if(${directory} STREQUAL ${CMAKE_SOURCE_DIR})
            set(relative_path ".")  # Set relative path to empty string for the root directory
        else()
            string(REPLACE "${CMAKE_SOURCE_DIR}/" "" relative_path ${directory})
        endif()

        # Find Python files in the specified directory
        file(GLOB PY_FILES "${directory}/*.py")

        # Install the files to the destination path relative to the source directory
        install(FILES ${PY_FILES} DESTINATION ${relative_path})
    endforeach()
endfunction()
