cmake_minimum_required(VERSION 3.29.0)
project(test LANGUAGES Fortran CXX)

set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/install)
set(MODULE_OUTPUT_DIR ${CMAKE_BINARY_DIR}/modules)

add_subdirectory(fort_modules)
add_subdirectory(src)

message(GELO)

function(replace_py_with_pyc input_files output_files)
    set(${output_files})  # Initialize an empty list for the output files

    foreach(file ${input_files})
        string(REPLACE ".py" ".pyc" replaced_file ${file})
        list(APPEND ${output_files} ${replaced_file})
    endforeach()

    # Return the list of .pyc files
    set(${output_files} ${${output_files}} PARENT_SCOPE)
endfunction()
