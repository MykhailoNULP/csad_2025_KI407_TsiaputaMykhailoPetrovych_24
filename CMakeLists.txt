cmake_minimum_required(VERSION 3.16)
project(csad_2025_project VERSION 0.1.0 LANGUAGES CXX)

# === Global settings ===
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(BUILD_TESTS "Build unit tests" ON)

# === Library with core functionality ===
add_library(hello_lib STATIC
    main.cpp
)

target_include_directories(hello_lib PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# === Executable ===
add_executable(hello
    main.cpp
)
target_link_libraries(hello PRIVATE hello_lib)

install(TARGETS hello RUNTIME DESTINATION bin)

# === Unit tests ===
if(BUILD_TESTS)
    enable_testing()
    include(FetchContent)

    FetchContent_Declare(
        googletest
        URL https://github.com/google/googletest/archive/refs/tags/release-1.14.0.zip
    )
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(googletest)

    add_executable(hello_tests
        test/main_test.cpp
    )
    target_link_libraries(hello_tests
        PRIVATE
            hello_lib
            gtest_main
    )

    include(GoogleTest)
    gtest_discover_tests(hello_tests)
endif()
