# Set up an ARM7 target
# Add the definition for the libnds headers
function(setup_arm7_target target_name shared_target_name libnds_libs target_files)

    add_definitions(-DARM7)
    add_executable(${target_name} $<TARGET_OBJECTS:${shared_target_name}> ${target_files})
    setup_libnds("${target_name}" "${libnds_libs}")

    # Setup linker and arch flags
    set_target_properties(${target_name} PROPERTIES
                          LINK_FLAGS "-specs=ds_arm7.specs -mthumb -mthumb-interwork"
                          COMPILE_FLAGS "-mcpu=arm7tdmi -mtune=arm7tdmi -mthumb -mthumb-interwork")
  
    add_dependencies(${target_name}
                     ${shared_target_name})

endfunction(setup_arm7_target)

# Set up an ARM9 target
# Add the definition for the libnds headers
function(setup_arm9_target target_name shared_target_name grit_target_name libnds_libs target_files)

    add_definitions(-DARM9)
    add_executable(${target_name} $<TARGET_OBJECTS:${shared_target_name}> $<TARGET_OBJECTS:${grit_target_name}> ${target_files})
    setup_libnds("${target_name}" "${libnds_libs}")

    # Setup linker and arch flags
    set_target_properties(${target_name} PROPERTIES
                          LINK_FLAGS "-specs=ds_arm9.specs -mthumb -mthumb-interwork"
                          COMPILE_FLAGS "-march=armv5te -mtune=arm946e-s -mthumb -mthumb-interwork")

    add_dependencies(${target_name}
                     ${grit_target_name}
                     ${shared_target_name})
  
endfunction(setup_arm9_target)

# Used to set information for ARM7 and ARM9 targets
function(setup_libnds target_name libnds_libs)

    # Uncomment the following line for debugging find_library
    # set(CMAKE_FIND_DEBUG_MODE 1)

    # Link all libnds libraries
    set(CMAKE_FIND_LIBRARY_PREFIXES lib)
    set(CMAKE_FIND_LIBRARY_SUFFIXES .a)
    foreach(libnds_lib ${libnds_libs})
        if(NOT DEFINED LIBNDS_${libnds_lib})
            message(STATUS "Looking for libnds's ${libnds_lib}")
            find_library(LIBNDS_${libnds_lib} ${libnds_lib})
            if(LIBNDS_${libnds_lib})
                message(STATUS "    Found -- ${LIBNDS_${libnds_lib}}")
            else()
                message(FATAL_ERROR "    Could not find ${libnds_lib}")
            endif()
        endif()

        target_link_libraries(${target_name} ${LIBNDS_${libnds_lib}})
    endforeach(libnds_lib)

endfunction(setup_libnds)
