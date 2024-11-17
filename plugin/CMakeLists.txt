# Define base directory
set(PLUGIN_DIR "${CMAKE_SOURCE_DIR}/plugin")

# Allow the user to specify files to include
set(MODELS_FILES_INPUT "" CACHE STRING "Comma-separated list of model files to include")
set(TOOLS_FILES_INPUT "" CACHE STRING "Comma-separated list of tool files to include")
set(INTEGRATORS_FILES_INPUT "" CACHE STRING "Comma-separated list of integrator files to include")

# Function to validate files
function(validate_files input_files directory output_variable)
    set(validated_files "")
    foreach(file ${input_files})
        set(file_path "${directory}/${file}")
        if(EXISTS ${file_path})
            list(APPEND validated_files ${file_path})
        else()
            message(FATAL_ERROR "File ${file_path} does not exist.")
        endif()
    endforeach()
    set(${output_variable} ${validated_files} PARENT_SCOPE)
endfunction()

# Process user input and validate files for models
if(MODELS_FILES_INPUT)
    string(REPLACE "," ";" MODELS_FILES_LIST ${MODELS_FILES_INPUT})
    validate_files("${MODELS_FILES_LIST}" "${PLUGIN_DIR}/models" VALIDATED_MODELS_FILES)
endif()

# Process user input and validate files for tools
if(TOOLS_FILES_INPUT)
    string(REPLACE "," ";" TOOLS_FILES_LIST ${TOOLS_FILES_INPUT})
    validate_files("${TOOLS_FILES_LIST}" "${PLUGIN_DIR}/tools" VALIDATED_TOOLS_FILES)
endif()

# Process user input and validate files for integrators
if(INTEGRATORS_FILES_INPUT)
    string(REPLACE "," ";" INTEGRATORS_FILES_LIST ${INTEGRATORS_FILES_INPUT})
    validate_files("${INTEGRATORS_FILES_LIST}" "${PLUGIN_DIR}/integrators" VALIDATED_INTEGRATORS_FILES)
endif()

# Debug output
if(${CMAKE_BUILD_TYPE} STREQUAL "Debug")
    message(STATUS "\n")
    message(STATUS "Validated model files: ${VALIDATED_MODELS_FILES}")
    message(STATUS "Validated tool files: ${VALIDATED_TOOLS_FILES}")
    message(STATUS "Validated integrator files: ${VALIDATED_INTEGRATORS_FILES}\n")
endif()
