# Step 1: Specify C and Fortran source files
set(C_SOURCES
    ${CMAKE_SOURCE_DIR}/src/p.cpp
)

set(FORTRAN_SOURCES
    ${CMAKE_SOURCE_DIR}/src/main.f90
    ${CMAKE_SOURCE_DIR}/src/ma.f90
)

set(MODULE_USE_SRC
    ${CMAKE_SOURCE_DIR}/src/module_use.f90
)

set(PY_OUTPUT
    ${CMAKE_CURRENT_BINARY_DIR}/examples.cpython-312-darwin.so
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

add_custom_command(
    OUTPUT ${PY_OUTPUT}
    COMMAND f2py -I${CMAKE_BINARY_DIR}/modules -m examples -c ${MODULE_USE_SRC} -L${CMAKE_BINARY_DIR}/fort_modules -lmodules
    COMMENT "Compiling f2py"
)

add_custom_target(
    f2py_compile 
    DEPENDS ${PY_OUTPUT}
)

add_custom_target(
    compile_py ALL
    COMMAND python3 ${CMAKE_CURRENT_SOURCE_DIR}/test.py
    DEPENDS f2py_compile
    COMMENT "Compiling test.py"
)

