cmake_minimum_required(VERSION 3.29.0)
project(test LANGUAGES Fortran CXX)

# Step 1: Specify C and Fortran source files
set(C_SOURCES
    ${CMAKE_SOURCE_DIR}/p.cpp
)

set(FORTRAN_SOURCES
    ${CMAKE_SOURCE_DIR}/main.f90
    ${CMAKE_SOURCE_DIR}/ma.f90
)

# Step 2: Create a static library target with both C and Fortran sources
add_library(my_static_lib STATIC ${C_SOURCES} ${FORTRAN_SOURCES})

# Step 3: Apply compiler flags specific to C files
target_compile_options(my_static_lib PRIVATE
    $<$<COMPILE_LANGUAGE:CXX>:-O2 -Wall>         # C-specific flags
)

# Step 4: Apply compiler flags specific to Fortran files
target_compile_options(my_static_lib PRIVATE
    $<$<COMPILE_LANGUAGE:Fortran>:-fPIC -ffree-form>  # Fortran-specific flags
)
