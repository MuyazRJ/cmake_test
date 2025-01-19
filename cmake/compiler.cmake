message("${CMAKE_CXX_COMPILER}")
message("${CMAKE_CXX_COMPILER_ID} SKDMFKLM")
string(TOLOWER "${CMAKE_CXX_COMPILER_ID}" CXX_COMPILER_ID_LOWER)
message("${COMPILER}")
# Use string matching to detect the compiler
if("${CXX_COMPILER_ID_LOWER}" MATCHES ".*gnu.*" OR "${CXX_COMPILER_ID_LOWER}" MATCHES ".*gcc.*")
    message(STATUS "Detected GNU Compiler")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -Wall -Wextra")
elseif("${CXX_COMPILER_ID_LOWER}" MATCHES ".*intel.*")
    message(STATUS "Detected Intel Compiler")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -xHost -diag-disable:remark")
elseif("${CXX_COMPILER_ID_LOWER}" MATCHES ".*apple.*")
    message(STATUS "Detected Apple Compiler")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O3 -xHost -diag-disable:remark")
else()
    message(WARNING "Unknown or unsupported compiler: ${CMAKE_CXX_COMPILER}")
endif()

message("SNDJKAN ${COMPILER}")

#Compile your code with -fsanitize=memory or -fsanitize=address