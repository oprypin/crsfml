cmake_minimum_required(VERSION 2.8.11)

project(CrSFML)

set(VERSION_MAJOR 2)
set(VERSION_MINOR 4)
set(VERSION_PATCH 2)



find_program(CRYSTAL crystal)

list(APPEND CMAKE_MODULE_PATH "/usr/local/share/SFML/cmake/Modules")
list(APPEND CMAKE_MODULE_PATH "/usr/local/opt/sfml/share/SFML/cmake/Modules") # Homebrew

find_package(SFML 2.3 COMPONENTS system window graphics audio network REQUIRED)
include_directories(${SFML_INCLUDE_DIR})


# Copy relevant files from source directory to build directory

if(NOT CMAKE_CURRENT_SOURCE_DIR STREQUAL CMAKE_CURRENT_BINARY_DIR)
    # Out-of-source build
    file(
        GLOB_RECURSE source_files
        RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
        "src/*.cr"
        "voidcsfml/include/*.h" "voidcsfml/src/*.cpp"
        "examples/*.cr" "examples/resources/*"
    )
    foreach(path ${source_files}
        LICENSE README.md
        voidcsfml/LICENSE voidcsfml/README.md
        examples/README.md
    )
        configure_file(
            "${path}" "${path}"
            COPYONLY
        )
    endforeach()
    file(
        COPY "${CMAKE_CURRENT_SOURCE_DIR}/examples/libs"
        DESTINATION "${CMAKE_CURRENT_BINARY_DIR}/examples"
    )
endif()

file(
    GLOB_RECURSE source_files_in
    RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
    "*.in"
)
foreach(path_in ${source_files_in})
    string(REGEX REPLACE "\\.in$" "" path "${path_in}")
    configure_file(
        "${path_in}" "${path}"
        @ONLY
    )
endforeach()



# Prepare lists of files to be generated
foreach(module system window graphics audio network)
    foreach(file lib obj)
        list(APPEND SRC_CR "${CMAKE_CURRENT_BINARY_DIR}/src/${module}/${file}.cr")
    endforeach()

    list(APPEND SRC_C "${CMAKE_CURRENT_BINARY_DIR}/voidcsfml/include/voidcsfml/${module}.h")
    list(APPEND SRC_C "${CMAKE_CURRENT_BINARY_DIR}/voidcsfml/src/voidcsfml/${module}.cpp")
endforeach()

set(SIZES_CPP "${CMAKE_CURRENT_BINARY_DIR}/sizes.cpp")
set(SIZES_CR "${CMAKE_CURRENT_BINARY_DIR}/src/sizes.cr")

add_custom_target(c-sources DEPENDS ${SRC_C})
add_custom_target(crystal-sources DEPENDS ${SRC_CR} ${SIZES_CR})


file(
    GLOB doc_diffs
    RELATIVE "${CMAKE_CURRENT_SOURCE_DIR}"
    "docs/*.diff"
)
add_custom_command(
    COMMAND ${CRYSTAL} run "${CMAKE_CURRENT_SOURCE_DIR}/generate.cr" -- ${SFML_INCLUDE_DIR}
    OUTPUT ${SRC_C} ${SRC_CR} ${SIZES_CPP}
    DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/generate.cr" ${doc_diffs}
)

add_executable(sizes-generator ${SIZES_CPP})

# Run sizes.cpp to generate sizes.cr
add_custom_command(
    COMMAND sizes-generator > ${SIZES_CR}
    OUTPUT ${SIZES_CR}
    DEPENDS sizes-generator
)


add_subdirectory("${CMAKE_CURRENT_BINARY_DIR}/voidcsfml" "${CMAKE_CURRENT_BINARY_DIR}/voidcsfml")


add_custom_target(CrSFML ALL DEPENDS crystal-sources VoidCSFML)
