cmake_minimum_required(VERSION 3.16)
project(csad_2025_project VERSION 0.1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(BUILD_TESTS "Build unit tests" ON)

# === Основна програма ===
add_executable(hello
    main.cpp
)

install(TARGETS hello RUNTIME DESTINATION bin)

# === Модуль з логікою ===
add_library(math_operations
    math_operations.cpp
)
target_include_directories(math_operations PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# === Юніт-тести ===
if(BUILD_TESTS)
    enable_testing()
    include(FetchContent)

   FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/refs/tags/v1.14.0.zip
)
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(googletest)

    add_executable(unit_tests
        tests/unit_tests.cpp
    )

    target_link_libraries(unit_tests
        PRIVATE
            math_operations
            gtest_main
    )

    include(GoogleTest)
    gtest_discover_tests(unit_tests)
endif()
