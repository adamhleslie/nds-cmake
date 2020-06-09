set(arm9_files
    init.cpp
    main-arm9.cpp)

set(arm9_libnds_libs nds9)

setup_arm9_target("${arm9_libnds_libs}" "${arm9_files}")
