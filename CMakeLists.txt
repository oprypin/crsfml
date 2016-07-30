cmake_minimum_required(VERSION 2.8.11)

project(CrSFML)

set(VERSION_MAJOR 2)
set(VERSION_MINOR 3)
set(VERSION_PATCH 10)



find_program(CRYSTAL crystal)

find_package(SFML 2 COMPONENTS system window graphics audio network REQUIRED)
include_directories(${SFML_INCLUDE_DIR})


if(NOT PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
    # Out-of-source build

    # Copy relevant files from source directory to build directory
    file(
        GLOB_RECURSE source_files
        RELATIVE ${CMAKE_CURRENT_SOURCE_DIR}
        "src/*.cr" "shard.yml"
        "voidcsfml/include/*.h" "voidcsfml/src/*.cpp"
        "examples/*.cr" "examples/resources/*"
        "*/CMakeLists.txt"
        "*/*.md" "*/LICENSE"
    )
    foreach(path ${source_files})
        configure_file(
            "${CMAKE_CURRENT_SOURCE_DIR}/${path}"
            "${CMAKE_CURRENT_BINARY_DIR}/${path}"
            COPYONLY
        )
    endforeach()
endif()


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


add_custom_command(
    COMMAND ${CRYSTAL} run "${CMAKE_CURRENT_SOURCE_DIR}/generate.cr" -- ${SFML_INCLUDE_DIR}
    OUTPUT ${SRC_C} ${SRC_CR} ${SIZES_CPP}
    DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/generate.cr"
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
