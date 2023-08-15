if (NOT ARM9_TARGET_NAME)
	message(FATAL_ERROR "Please set ARM7_TARGET_NAME")
endif ()

if (NOT SHARED_TARGET_NAME)
	message(FATAL_ERROR "Please set SHARED_TARGET_NAME")
endif ()

if (NOT GRIT_TARGET_NAME)
	message(FATAL_ERROR "Please set GRIT_TARGET_NAME")
endif ()

set(arm9_files
    init.cpp
    main-arm9.cpp)

set(arm9_libnds_libs nds9)

setup_arm9_target("${ARM9_TARGET_NAME}" "${SHARED_TARGET_NAME}" "${GRIT_TARGET_NAME}" "${arm9_libnds_libs}" "${arm9_files}")
