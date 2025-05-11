cmake_minimum_required(VERSION 3.20)
project(fortran_python LANGUAGES Fortran C)

# 1. Ask CMake for a Python interpreter (and where to install the module)
find_package(Python3 REQUIRED COMPONENTS Interpreter)

# 2. Base name of the extension module
set(MODNAME _mycode)

# 3. Build the final file name:  _mycode${Python3_SOABI}
set(EXT_FILE "${CMAKE_CURRENT_BINARY_DIR}/${MODNAME}${Python3_SOABI}")
