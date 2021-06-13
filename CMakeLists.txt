cmake_minimum_required(VERSION 3.18)

# Enable new optimized variable evaluation
cmake_policy(SET CMP0053 NEW)

# Enable the next line to see the actual commands run when building etc.
set(CMAKE_VERBOSE_MAKEFILE ON)

# Log active toolchain
message(STATUS "Using toolchain file: ${CMAKE_TOOLCHAIN_FILE}")

# Set the default search path for modules when using include / find_package
set(CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")
message(STATUS "Using C compiler: " ${CMAKE_C_COMPILER})
message(STATUS "Using C++ compiler: " ${CMAKE_CXX_COMPILER})

# PROJECT #
if(NOT DEFINED ENV{PROJECT})
    message(FATAL_ERROR "Please set PROJECT in your environment")
endif()
project("$ENV{PROJECT}")

# Compiler Flags
set(warning_flags "-Winline -Wall -Wextra")
set(cpp_flags "-fno-rtti -fno-exceptions")
set(debug_flags "-O0 -g -DDEBUG")
set(release_flags "-O3 -fomit-frame-pointer -ffast-math")
set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS} ${warning_flags} ${debug_flags}")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS} ${warning_flags} ${cpp_flags} ${debug_flags}")
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS} ${warning_flags} ${release_flags}")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} ${warning_flags} ${cpp_flags} ${release_flags}")

# PROJECT - ASSETS #
set(ASSETS_PATH "${CMAKE_SOURCE_DIR}/assets")
set(ASSETS_GEN  "${ASSETS_PATH}/gen")
include_directories(${ASSETS_GEN})

# grit - Images
include(nds.grit)
set(GRIT_TARGET_NAME "assets_images")
add_grit_target(${GRIT_TARGET_NAME} "${ASSETS_PATH}/images" ${ASSETS_GEN})

# PROJECT - CODE #
set(ARM7_TARGET_NAME "arm7.elf")
set(ARM9_TARGET_NAME "arm9.elf")
set(SHARED_TARGET_NAME "shared")
include_directories(${CMAKE_SOURCE_DIR}/shared)

include(nds.macro)
add_subdirectory(shared)
add_subdirectory(arm7)
add_subdirectory(arm9)

# ndstool - .nds executable
include(nds.ndstool)
set(NDS_TARGET_NAME "${PROJECT_NAME}")
add_nds_target(${NDS_TARGET_NAME} ${ARM7_TARGET_NAME} ${ARM9_TARGET_NAME} "FALSE" "arm7/${ARM7_TARGET_NAME}" "arm9/${ARM9_TARGET_NAME}" ${PROJECT_NAME})
