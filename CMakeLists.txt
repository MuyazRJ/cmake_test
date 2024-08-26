cmake_minimum_required(VERSION 3.29.0)
project(test LANGUAGES Fortran CXX)

set(MODULE_OUTPUT_DIR ${CMAKE_BINARY_DIR}/modules)

#add_subdirectory(fort_modules)
#add_subdirectory(src)

function(tester arg1 arg2 arg3)
    message("Argument 1: ${arg1}")
    message("Argument 2: ${arg2}")
    message("Argument 3: ${arg3}")
    
    # Split the string in arg3 into a list of source files
    separate_arguments(SOURCE_sFILES UNIX_COMMAND "${arg3}")
    message(${ARGN})

    add_executable(pro ${SOURCE_sFILES})
endfunction()

function(replace_py_with_pyc input_files output_files)
    set(${output_files})  # Initialize an empty list for the output files

    foreach(file ${input_files})
        string(REPLACE ".py" ".pyc" replaced_file ${file})
        list(APPEND ${output_files} ${replaced_file})
    endforeach()

    # Return the list of .pyc files
    set(${output_files} ${${output_files}} PARENT_SCOPE)
endfunction()

# Use the library file path
#set(LIBRARY_PATH $<TARGET_FILE:MyLibrary>)