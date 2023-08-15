# OUT: Defines add_grit_target function for handling png image files

if (NOT GRIT_EXE)
	message(STATUS "Looking for grit")
	find_program(GRIT_EXE grit)
	if (GRIT_EXE)
		message(STATUS "    Found -- ${GRIT_EXE}")
	else ()
		message(FATAL_ERROR "    Could not find grit")
	endif ()
endif ()

if (GRIT_EXE)
	function(add_grit_target target_name src_path gen_path)

		# Find all PNG files
		file(GLOB png_files "${src_path}/*.png")

		# Create target directory
		file(MAKE_DIRECTORY ${gen_path})

		# Add a command to process each file with grit
		foreach (png_file ${png_files})
			get_filename_component(png_filename ${png_file} NAME)

			# Compute output files
			string(REPLACE ".png" ".h" gen_file_h "${gen_path}/${png_filename}")
			string(REPLACE ".png" ".c" gen_file_c "${gen_path}/${png_filename}")

			# Mark as generated files
			set_source_files_properties("${gen_file_h}" PROPERTIES GENERATED TRUE)
			set_source_files_properties("${gen_file_c}" PROPERTIES GENERATED TRUE)

			# Append to files list
			set(gen_files_c ${gen_files_c} ${gen_file_c})
			set(gen_files_h ${gen_files_h} ${gen_file_h})

			# Create grit command
			add_custom_command(OUTPUT ${gen_file_h} ${gen_file_c}
			                   COMMAND ${GRIT_EXE}
			                   ARGS ${png_file} -ftc -o${gen_path}/${png_filename})

		endforeach (png_file)

		# Create a target with those files
		# So IDEs can recognize them
		add_library(${target_name} OBJECT ${gen_files_c})
		add_custom_target("${target_name}_raw" SOURCES "${png_files};${gen_files_h}")

	endfunction(add_grit_target)
endif ()
