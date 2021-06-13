if(NOT ARM7_TARGET_NAME)
    message(FATAL_ERROR "Please set ARM7_TARGET_NAME")
endif()

if(NOT SHARED_TARGET_NAME)
    message(FATAL_ERROR "Please set SHARED_TARGET_NAME")
endif()

set(arm7_files
    main-arm7.cpp)

set(arm7_libnds_libs nds7
                     dswifi7
                     mm7)
  
setup_arm7_target("${ARM7_TARGET_NAME}" "${SHARED_TARGET_NAME}" "${arm7_libnds_libs}" "${arm7_files}")
