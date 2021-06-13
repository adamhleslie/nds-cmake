# OUT: Defines add_nds_target function for creating an executable

if(NOT NDSTOOL_EXE)
    message(STATUS "Looking for ndstool")
    find_program(NDSTOOL_EXE ndstool)
    if(NDSTOOL_EXE)
        message(STATUS "    Found -- ${NDSTOOL_EXE}")
    else()
        message(FATAL_ERROR "    Could not find ndstool")
    endif()
endif()

if(NDSTOOL_EXE)
    function(add_nds_target target_name arm7_target_name arm9_target_name copy_nds_to_source_dir arm7_target_path arm9_target_path exe_name)

        set(nds ${CMAKE_CURRENT_BINARY_DIR}/${exe_name}.nds)
        set(nds_copy ${CMAKE_SOURCE_DIR}/${exe_name}.nds)
        set(i9 ${CMAKE_CURRENT_BINARY_DIR}/${arm9_target_path})
        set(i7 ${CMAKE_CURRENT_BINARY_DIR}/${arm7_target_path})

        if(copy_nds_to_source_dir)
            add_custom_command(OUTPUT ${nds} ${nds_copy}
                               DEPENDS ${i9} ${i7}
                               COMMAND ${NDSTOOL_EXE} ARGS -c ${nds} -9 ${i9} -7 ${i7}
                               COMMAND ${CMAKE_COMMAND} -E copy ARGS ${nds} ${nds_copy})

            add_custom_target(${target_name} ALL
                              DEPENDS ${nds} ${nds_copy})
        else()
            add_custom_command(OUTPUT ${nds}
                               DEPENDS ${i9} ${i7}
                               COMMAND ${NDSTOOL_EXE} ARGS -c ${nds} -9 ${i9} -7 ${i7})

            add_custom_target(${target_name} ALL
                              DEPENDS ${nds})
        endif()

        add_dependencies(${target_name} 
                         ${arm7_target_name}
                         ${arm9_target_name})

    endfunction(add_nds_target)
endif()
