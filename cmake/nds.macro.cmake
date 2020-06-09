# Sets up an ARM7 target
# Adds the definition for the libnds headers
function(setup_arm7_target libnds_libs target_files)

    if(NOT ARM7_TARGET_NAME)
        message(FATAL_ERROR "Please set ARM7_TARGET_NAME")
    endif()

    if(NOT SHARED_TARGET_NAME)
        message(FATAL_ERROR "Please set SHARED_TARGET_NAME")
    endif()

    add_definitions(-DARM7)
    add_executable(${ARM7_TARGET_NAME} $<TARGET_OBJECTS:${SHARED_TARGET_NAME}> ${target_files})
    setup_libnds("${ARM7_TARGET_NAME}" "${libnds_libs}")

    # Setup linker and arch flags
    set_target_properties(${ARM7_TARGET_NAME} PROPERTIES
                          LINK_FLAGS "-specs=ds_arm7.specs -mthumb -mthumb-interwork"
                          COMPILE_FLAGS "-mcpu=arm7tdmi -mtune=arm7tdmi -mthumb -mthumb-interwork")
  
    add_dependencies(${ARM7_TARGET_NAME} 
                     ${SHARED_TARGET_NAME})

endfunction(setup_arm7_target)

# Sets up an ARM9 target
# Adds the definition for the libnds headers
function(setup_arm9_target libnds_libs target_files)

    if(NOT ARM9_TARGET_NAME)
        message(FATAL_ERROR "Please set ARM9_TARGET_NAME")
    endif()

    if(NOT SHARED_TARGET_NAME)
        message(FATAL_ERROR "Please set SHARED_TARGET_NAME")
    endif()

    if(NOT GRIT_TARGET_NAME)
        message(FATAL_ERROR "Please set GRIT_TARGET_NAME")
    endif()

    add_definitions(-DARM9)
    add_executable(${ARM9_TARGET_NAME} $<TARGET_OBJECTS:${SHARED_TARGET_NAME}> $<TARGET_OBJECTS:${GRIT_TARGET_NAME}> ${target_files})
    setup_libnds("${ARM9_TARGET_NAME}" "${libnds_libs}")

    # Setup linker and arch flags
    set_target_properties(${ARM9_TARGET_NAME} PROPERTIES
                          LINK_FLAGS "-specs=ds_arm9.specs -mthumb -mthumb-interwork"
                          COMPILE_FLAGS "-march=armv5te -mtune=arm946e-s -mthumb -mthumb-interwork")

    add_dependencies(${ARM9_TARGET_NAME} 
                     ${GRIT_TARGET_NAME} 
                     ${SHARED_TARGET_NAME})
  
endfunction(setup_arm9_target)

# Used to set informations for ARM7 and ARM9 targets
function(setup_libnds target_name libnds_libs)

    if(NOT LIBNDS)
        message(FATAL_ERROR "Please set LIBNDS")
    endif()

    # Uncomment the following line for debugging find_library
    # set(CMAKE_FIND_DEBUG_MODE 1)

    # Link all libnds libraries
    set(CMAKE_FIND_LIBRARY_PREFIXES lib)
    set(CMAKE_FIND_LIBRARY_SUFFIXES .a)
    foreach(libnds_lib ${libnds_libs})
        if(NOT DEFINED LIBNDS_${libnds_lib})
            message(STATUS "Looking for libnds's ${libnds_lib} in ${LIBNDS}/lib")
            find_library(LIBNDS_${libnds_lib} ${libnds_lib} ${LIBNDS}/lib NO_DEFAULT_PATH)
            if(LIBNDS_${libnds_lib})
                message(STATUS "    Found -- ${LIBNDS_${libnds_lib}}")
            else()
                message(FATAL_ERROR "    Could not find library")
            endif()
        endif()

        target_link_libraries(${target_name} ${LIBNDS_${libnds_lib}})
    endforeach(libnds_lib)

endfunction(setup_libnds)
