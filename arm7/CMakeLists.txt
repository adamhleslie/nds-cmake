set(arm7_files
    main-arm7.cpp)

set(arm7_libnds_libs nds7
                     dswifi7
                     mm7)
  
setup_arm7_target("${arm7_libnds_libs}" "${arm7_files}")
