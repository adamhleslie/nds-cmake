set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_VERSION r54-3)
set(CMAKE_SYSTEM_PROCESSOR arm-eabi)

if(NOT DEFINED ENV{DEVKITPRO})
    message(FATAL_ERROR "Please set DEVKITPRO in your environment")
endif()
set(DEVKITPRO $ENV{DEVKITPRO})

if(NOT DEFINED ENV{DEVKITARM})
    message(FATAL_ERROR "Please set DEVKITARM in your environment")
endif()
set(DEVKITARM $ENV{DEVKITARM})

set(LIBNDS ${DEVKITPRO}/libnds)

message(STATUS "DEVKITPRO: ${DEVKITPRO}")
message(STATUS "DEVKITARM: ${DEVKITARM}")
message(STATUS "LIBNDS: ${LIBNDS}")

set(PREFIX arm-none-eabi)

find_program(CMAKE_C_COMPILER NAMES ${PREFIX}-gcc PATHS ${DEVKITARM}/bin NO_DEFAULT_PATH)
find_program(CMAKE_CXX_COMPILER NAMES ${PREFIX}-g++ PATHS ${DEVKITARM}/bin NO_DEFAULT_PATH)
find_program(CMAKE_OBJCOPY NAMES ${PREFIX}-objcopy PATHS ${DEVKITARM}/bin NO_DEFAULT_PATH)
find_program(CMAKE_OBJDUMP NAMES ${PREFIX}-objdump PATHS ${DEVKITARM}/bin NO_DEFAULT_PATH)
find_program(CMAKE_LINKER NAMES ${PREFIX}-ld PATHS ${DEVKITARM}/bin NO_DEFAULT_PATH)
find_program(CMAKE_STRIP NAMES ${PREFIX}-strip PATHS ${DEVKITARM}/bin NO_DEFAULT_PATH)

# TODO: Update toolchain file and all find_X calls to work through CMAKE_FIND_ROOT_PATH instead of direct references to DEVKITPRO, DEVKITARM, and LIBNDS
# set(CMAKE_FIND_ROOT_PATH ${DEVKITARM})
# set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
# set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY NEVER)
# set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

include_directories(${LIBNDS}/include)
