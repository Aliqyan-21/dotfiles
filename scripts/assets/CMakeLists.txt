# Specify the minimum CMake version required
cmake_minimum_required(VERSION 3.30.8)

# Export compile commands (useful for tools like clangd)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Project information
project(MyCppProject VERSION 1.0 LANGUAGES CXX)

# Set the C++ standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Set default build type if not specified
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type (Debug or Release)" FORCE)
    message(STATUS "Build type not specified, defaulting to Release")
endif()

message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

# source files
set(SOURCES
    src/main.cpp
    src/example.cpp
)

# header files
set(HEADERS
    include/example.h
)

# compile flags for different build types
set(COMPILE_FLAGS_DEBUG -Wall -ggdb3 -O0)
set(COMPILE_FLAGS_RELEASE -Wall -O3)

# List libraries to link (if any)
set(LINK_LIBRARIES
    # library1
    # library2
)

# Function to simplify target creation
function(add_project_target TARGET_NAME SOURCES HEADERS LIBS)
    add_executable(${TARGET_NAME} ${SOURCES} ${HEADERS})
    target_include_directories(${TARGET_NAME} PRIVATE include)

    # Apply build-type specific flags
    target_compile_options(${TARGET_NAME} PRIVATE
        $<$<CONFIG:Debug>:${COMPILE_FLAGS_DEBUG}>
        $<$<CONFIG:Release>:${COMPILE_FLAGS_RELEASE}>
    )

    target_link_libraries(${TARGET_NAME} PRIVATE ${LIBS})

    # Specify the output directory for the binary (separate by build type)
    set_target_properties(${TARGET_NAME} PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/build/bin/${CMAKE_BUILD_TYPE}"
    )
endfunction()

# Add the main project target
add_project_target(${PROJECT_NAME} "${SOURCES}" "${HEADERS}" "${LINK_LIBRARIES}")

# Installation target
install(TARGETS ${PROJECT_NAME} DESTINATION bin)

# Additional configurations based on compiler
if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU" OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    message(STATUS "Using GCC or Clang")
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    message(STATUS "Using MSVC")
    # MSVC-specific flags
    target_compile_options(${PROJECT_NAME} PRIVATE
        $<$<CONFIG:Debug>:/Od /Zi>
        $<$<CONFIG:Release>:/O2>
    )
endif()
