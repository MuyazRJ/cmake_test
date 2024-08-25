# Step 1: Specify C and Fortran source files
set(C_SOURCES
    ${CMAKE_SOURCE_DIR}/src/p.cpp
)

set(FORTRAN_SOURCES
    ${CMAKE_SOURCE_DIR}/src/main.f90
    ${CMAKE_SOURCE_DIR}/src/ma.f90
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

add_executable(module_use ${CMAKE_CURRENT_SOURCE_DIR}/module_use.f90)
target_link_libraries(module_use PRIVATE modules)