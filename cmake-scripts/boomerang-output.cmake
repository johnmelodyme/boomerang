#
# This file is part of the Boomerang Decompiler.
#
# See the file "LICENSE.TERMS" for information on usage and
# redistribution of this file, and for a DISCLAIMER OF ALL
# WARRANTIES.
#


# Base directory for all output files
set(BOOMERANG_OUTPUT_DIR "${PROJECT_BINARY_DIR}/out")

set(CMAKE_SHARED_MODULE_PREFIX "") # prevent windows/mingw modules having lib* prefix
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${BOOMERANG_OUTPUT_DIR}/bin/")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${BOOMERANG_OUTPUT_DIR}/lib/")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${BOOMERANG_OUTPUT_DIR}/lib/")

if (WIN32)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG          "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE        "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL     "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")

    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG          "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE        "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL     "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")

    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG          "${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}")
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE        "${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}")
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL     "${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}")
    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO "${CMAKE_ARCHIVE_OUTPUT_DIRECTORY}")

    add_definitions(-D__USE_MINGW_ANSI_STDIO=1)
endif ()

file(MAKE_DIRECTORY ${BOOMERANG_OUTPUT_DIR}/bin)
file(MAKE_DIRECTORY ${BOOMERANG_OUTPUT_DIR}/share)

# link output data directory to ${CMAKE_SOURCE_DIR}/data"
if (WIN32)
    execute_process(COMMAND mklink /D "${BOOMERANG_OUTPUT_DIR}/share/boomerang" "${CMAKE_SOURCE_DIR}/data/")
else () # Linux
    execute_process(COMMAND ln -sfn "${CMAKE_SOURCE_DIR}/data" "${BOOMERANG_OUTPUT_DIR}/share/boomerang")
endif ()

# delete all files in the 'out/' directory on make clean
set(EXTRA_CLEAN_FILES "${BOOMERANG_OUTPUT_DIR}")
set_directory_properties(PROPERTIES ADDITIONAL_MAKE_CLEAN_FILES "${EXTRA_CLEAN_FILES}")
