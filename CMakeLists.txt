cmake_minimum_required(VERSION 3.29.0)
project(test LANGUAGES Fortran CXX)

# Define the base directory
set(PLUGIN_DIR "${CMAKE_SOURCE_DIR}/plugin")


add_subdirectory(${CMAKE_SOURCE_DIR}/plugin)


