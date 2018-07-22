cmake_minimum_required(VERSION 2.8.11)

project(VoidCSFML)

add_custom_target(VoidCSFML ALL)


# define a macro that helps defining an option
macro(voidcsfml_set_option var default type docstring)
    if(NOT DEFINED ${var})
        set(${var} ${default})
    endif()
    set(${var} ${${var}} CACHE ${type} ${docstring} FORCE)
endmacro()

# set a default build type if none was provided
# this has to be done before the project() instruction!
voidcsfml_set_option(CMAKE_BUILD_TYPE Release STRING "Choose the type of build (Debug or Release)")


# detect the OS
if(${CMAKE_SYSTEM_NAME} MATCHES "Windows")
    set(SFML_OS_WINDOWS 1)
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Linux")
    set(SFML_OS_LINUX 1)
elseif(${CMAKE_SYSTEM_NAME} MATCHES "FreeBSD")
    set(SFML_OS_FREEBSD 1)
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set(SFML_OS_MACOSX 1)

    # detect OS X version. (use '/usr/bin/sw_vers -productVersion' to extract V from '10.V.x'.)
    exec_program(/usr/bin/sw_vers ARGS -productVersion OUTPUT_VARIABLE MACOSX_VERSION_RAW)
    string(REGEX REPLACE "10\\.([0-9]+).*" "\\1" MACOSX_VERSION "${MACOSX_VERSION_RAW}")
    if(${MACOSX_VERSION} LESS 5)
        message(FATAL_ERROR "Unsupported version of OS X : ${MACOSX_VERSION_RAW}")
        return()
    endif()
else()
    message(FATAL_ERROR "Unsupported operating system")
    return()
endif()

# detect the compiler and its version
# Note: on some platforms (OS X), CMAKE_COMPILER_IS_GNUCXX is true
# even when CLANG is used, therefore the Clang test is done first
if(CMAKE_CXX_COMPILER MATCHES ".*clang[+][+]" OR CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
    # CMAKE_CXX_COMPILER_ID is an internal CMake variable subject to change,
    # but there is no other way to detect CLang at the moment
    set(SFML_COMPILER_CLANG 1)
    execute_process(COMMAND "${CMAKE_CXX_COMPILER}" "--version" OUTPUT_VARIABLE CLANG_VERSION_OUTPUT)
    string(REGEX REPLACE ".*clang version ([0-9]+\\.[0-9]+).*" "\\1" SFML_CLANG_VERSION "${CLANG_VERSION_OUTPUT}")
elseif(CMAKE_COMPILER_IS_GNUCXX)
    set(SFML_COMPILER_GCC 1)
    execute_process(COMMAND "${CMAKE_CXX_COMPILER}" "-dumpversion" OUTPUT_VARIABLE GCC_VERSION_OUTPUT)
    string(REGEX REPLACE "([0-9]+\\.[0-9]+).*" "\\1" SFML_GCC_VERSION "${GCC_VERSION_OUTPUT}")
    execute_process(COMMAND "${CMAKE_CXX_COMPILER}" "--version" OUTPUT_VARIABLE GCC_COMPILER_VERSION)
    string(REGEX MATCHALL ".*(tdm[64]*-[1-9]).*" SFML_COMPILER_GCC_TDM "${GCC_COMPILER_VERSION}")
    execute_process(COMMAND "${CMAKE_CXX_COMPILER}" "-dumpmachine" OUTPUT_VARIABLE GCC_MACHINE)
    string(STRIP "${GCC_MACHINE}" GCC_MACHINE)
    if(${GCC_MACHINE} MATCHES ".*w64.*")
        set(SFML_COMPILER_GCC_W64 1)
    endif()
elseif(MSVC)
    set(SFML_COMPILER_MSVC 1)
    if(MSVC_VERSION EQUAL 1400)
        set(SFML_MSVC_VERSION 8)
    elseif(MSVC_VERSION EQUAL 1500)
        set(SFML_MSVC_VERSION 9)
    elseif(MSVC_VERSION EQUAL 1600)
        set(SFML_MSVC_VERSION 10)
    elseif(MSVC_VERSION EQUAL 1700)
        set(SFML_MSVC_VERSION 11)
    elseif(MSVC_VERSION EQUAL 1800)
        set(SFML_MSVC_VERSION 12)
    endif()
else()
    message(FATAL_ERROR "Unsupported compiler")
    return()
endif()

# define the install directory for miscellaneous files
if(SFML_OS_WINDOWS)
    set(INSTALL_MISC_DIR .)
elseif(SFML_OS_LINUX OR SFML_OS_FREEBSD OR SFML_OS_MACOSX)
    set(INSTALL_MISC_DIR share/voidcsfml)
endif()



# add the VoidCSFML header path
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/include)

# add an option for choosing the build type (shared or static)
voidcsfml_set_option(BUILD_SHARED_LIBS TRUE BOOL "TRUE to build VoidCSFML as shared libraries, FALSE to build it as static libraries")

# add an option for linking to SFML either statically or dynamically
voidcsfml_set_option(VOIDCSFML_LINK_SFML_STATICALLY TRUE BOOL "TRUE to link to a static version of SFML, FALSE to link dynamically")

# disable the rpath stuff
set(CMAKE_SKIP_BUILD_RPATH TRUE)

# define an option for choosing between static and dynamic C runtime (Windows only)
if(SFML_OS_WINDOWS)
    set(STATIC_STD_LIBS FALSE CACHE BOOL "TRUE to statically link to the standard libraries, FALSE to use them as DLLs")

    # for VC++, we can apply it globally by modifying the compiler flags
    if(SFML_COMPILER_MSVC AND STATIC_STD_LIBS)
        foreach(flag
                CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
                CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)
            if(${flag} MATCHES "/MD")
                string(REGEX REPLACE "/MD" "/MT" ${flag} "${${flag}}")
            endif()
        endforeach()
    endif()
endif()


include(CMakeParseArguments)

# add a new target which is a VoidCSFML library
# ex: voidcsfml_add_library(graphics DEPENDS window system)
macro(voidcsfml_add_library module)
    cmake_parse_arguments(voidcsfml_add_library "" "" "DEPENDS" ${ARGN})

    set(target "voidcsfml-${module}")

    set(sources
        "${CMAKE_CURRENT_SOURCE_DIR}/include/voidcsfml/${module}.h"
        "${CMAKE_CURRENT_SOURCE_DIR}/src/voidcsfml/${module}.cpp"
    )

    add_library(${target} ${sources})

    add_dependencies(VoidCSFML ${target})

    if(NOT CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_SOURCE_DIR)
        # if cmake is run outside the voidcsfml folder, we expect the outer CMakeLists to generate these source files.
        add_dependencies(${target} c-sources)
        set_source_files_properties(${sources} PROPERTIES GENERATED TRUE)
    endif()
    # otherwise, they're supposed to already be there; don't set these as generated so that the build fails early.

    # define the export symbol of the module
    string(REPLACE "-" "_" target_upper "${target}")
    string(TOUPPER "${target_upper}" target_upper)
    set_target_properties(${target} PROPERTIES DEFINE_SYMBOL ${target_upper}_EXPORTS)

    if(SFML_OS_WINDOWS)
        # include the major version number in Windows shared library names (but not import library names)
        set_target_properties(${target} PROPERTIES DEBUG_POSTFIX -d)
        set_target_properties(${target} PROPERTIES SUFFIX "-${SFML_VERSION_MAJOR}${CMAKE_SHARED_LIBRARY_SUFFIX}")
    else()
        set_target_properties(${target} PROPERTIES DEBUG_POSTFIX -d)
    endif()
    if(SFML_OS_WINDOWS AND SFML_COMPILER_GCC)
        # on Windows/gcc get rid of "lib" prefix for shared libraries,
        # and transform the ".dll.a" suffix into ".a" for import libraries
        set_target_properties(${target} PROPERTIES PREFIX "")
        set_target_properties(${target} PROPERTIES IMPORT_SUFFIX ".a")
    endif()

    # set the version and soversion of the target (for compatible systems -- mostly Linuxes)
    set_target_properties(${target} PROPERTIES SOVERSION ${SFML_VERSION_MAJOR}.${SFML_VERSION_MINOR})
    set_target_properties(${target} PROPERTIES VERSION ${SFML_VERSION_MAJOR}.${SFML_VERSION_MINOR})

    # set the target's folder (for IDEs that support it, e.g. Visual Studio)
    set_target_properties(${target} PROPERTIES FOLDER "voidcsfml")

    # for gcc >= 4.0 on Windows, apply the SFML_USE_STATIC_STD_LIBS option if it is enabled
    if(SFML_OS_WINDOWS AND SFML_COMPILER_GCC AND NOT SFML_GCC_VERSION VERSION_LESS "4")
        if(SFML_USE_STATIC_STD_LIBS AND NOT SFML_COMPILER_GCC_TDM)
            set_target_properties(${target} PROPERTIES LINK_FLAGS "-static-libgcc -static-libstdc++")
        elseif(NOT SFML_USE_STATIC_STD_LIBS AND SFML_COMPILER_GCC_TDM)
            set_target_properties(${target} PROPERTIES LINK_FLAGS "-shared-libgcc -shared-libstdc++")
        endif()
    endif()

    # if using gcc >= 4.0 or clang >= 3.0 on a non-Windows platform, we must hide public symbols by default
    # (exported ones are explicitely marked)
    if(NOT SFML_OS_WINDOWS AND (
        (SFML_COMPILER_GCC AND NOT SFML_GCC_VERSION VERSION_LESS "4") OR
        (SFML_COMPILER_CLANG AND NOT SFML_CLANG_VERSION VERSION_LESS "3")
    ))
        set_target_properties(${target} PROPERTIES COMPILE_FLAGS -fvisibility=hidden)
    endif()

    # link the target to its external dependencies (C++ SFML libraries)
    foreach(depend ${module} ${voidcsfml_add_library_DEPENDS})
        string(TOUPPER "${depend}" depend)
        target_link_libraries(${target} ${SFML_${depend}_LIBRARY} ${SFML_${depend}_DEPENDENCIES})
    endforeach()

    # build dylibs
    if(SFML_OS_MACOSX AND BUILD_SHARED_LIBS)
        # adapt install directory to allow distributing dylibs in user’s application bundle
        set_target_properties(${target} PROPERTIES
                              BUILD_WITH_INSTALL_RPATH 1
                              INSTALL_NAME_DIR "@rpath")
    endif()

    # add the install rule
    install(
        TARGETS ${target}
        RUNTIME DESTINATION bin COMPONENT bin
        LIBRARY DESTINATION lib${LIB_SUFFIX} COMPONENT bin
        ARCHIVE DESTINATION lib${LIB_SUFFIX} COMPONENT devel
    )

endmacro()


# add the VoidCSFML sources path
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/src)

# define the export symbol
add_definitions(-DVOIDCSFML_EXPORTS)

# disable stupid warnings with Visual C++
if(SFML_COMPILER_MSVC)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)
endif()

# find SFML libraries (C++)
if(SFML_OS_WINDOWS)
    if(VOIDCSFML_LINK_SFML_STATICALLY)
        set(SFML_STATIC_LIBRARIES TRUE)
        add_definitions(-DSFML_STATIC)
    endif()
endif()

list(APPEND CMAKE_MODULE_PATH "/usr/share/SFML/cmake/Modules")
list(APPEND CMAKE_MODULE_PATH "/usr/local/share/SFML/cmake/Modules")
list(APPEND CMAKE_MODULE_PATH "/usr/local/opt/sfml/share/SFML/cmake/Modules") # Homebrew

find_package(SFML 2.5
    COMPONENTS system window graphics audio network REQUIRED
)
if(NOT "2.5.0" STREQUAL "${SFML_VERSION_MAJOR}.${SFML_VERSION_MINOR}.${SFML_VERSION_PATCH}")
    message(WARNING
        "Expecting SFML 2.5.0, "
        "found SFML ${SFML_VERSION_MAJOR}.${SFML_VERSION_MINOR}.${SFML_VERSION_PATCH}"
    )
endif()
include_directories(${SFML_INCLUDE_DIR})


voidcsfml_add_library(system)
voidcsfml_add_library(window DEPENDS system)
voidcsfml_add_library(graphics DEPENDS window system)
voidcsfml_add_library(audio DEPENDS system)
voidcsfml_add_library(network DEPENDS system)


# setup the install rules
install(DIRECTORY include DESTINATION . COMPONENT devel)
install(FILES LICENSE DESTINATION ${INSTALL_MISC_DIR})
install(FILES README.md DESTINATION ${INSTALL_MISC_DIR})
