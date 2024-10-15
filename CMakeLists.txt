cmake_minimum_required(VERSION 3.29.0)
project(test LANGUAGES Fortran CXX)

set(CMAKE_INSTALL_PREFIX ${CMAKE_SOURCE_DIR}/install)
set(MODULE_OUTPUT_DIR ${CMAKE_BINARY_DIR}/modules)

execute_process(
    COMMAND git config --get remote.origin.url
    OUTPUT_VARIABLE GITLAB_URL
    OUTPUT_STRIP_TRAILING_WHITESPACE
)

message(STATUS "GitLab repository URL: ${GITLAB_URL}")

# Retrieve the current git commit hash
execute_process(
    COMMAND git rev-parse HEAD
    OUTPUT_VARIABLE GIT_COMMIT_HASH
)

# Print the commit hash
message(STATUS "Git commit hash: ${GIT_COMMIT_HASH}")# CMakeLists.txt

# Function to extract submodule URLs
function(print_submodule_urls)
    file(READ "${CMAKE_SOURCE_DIR}/.gitmodules" GITMODULES_CONTENT)
    
    # Regular expression to find URLs in the .gitmodules file
    string(REGEX MATCHALL "url = ([^\n]*)" MATCHED_URLS "${GITMODULES_CONTENT}")
    
    foreach(URL ${MATCHED_URLS})
        # Strip out the "url = " part and get just the URL
        string(REGEX REPLACE "url = " "" SUBMODULE_URL "${URL}")
        
        # Print the URL
        message(STATUS "Submodule URL: ${SUBMODULE_URL}")
    endforeach()
endfunction()

# Call the function
print_submodule_urls()
