cmake_minimum_required(VERSION 3.16)

project(csad_2025_project VERSION 0.1.0 LANGUAGES CXX)

# Require C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(BUILD_TESTS "Build unit tests" ON)

# Create main executable
add_executable(hello
    main.cpp
    math_operations.cpp
)

# Add include path for headers
target_include_directories(hello PRIVATE ${PROJECT_SOURCE_DIR})

# Install rule for cross-platform usage
install(TARGETS hello
    RUNTIME DESTINATION bin
)

# Unit tests
if(BUILD_TESTS)
    enable_testing()
    include(FetchContent)

    # Fetch GoogleTest
    FetchContent_Declare(
        googletest
        URL https://github.com/google/googletest/archive/refs/tags/v1.15.2.zip
        DOWNLOAD_EXTRACT_TIMESTAMP true
    )

    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(googletest)

    add_executable(hello_tests
        tests/main_test.cpp
        main.cpp
        math_operations.cpp
    )

    # Include path for test sources
    target_include_directories(hello_tests PRIVATE ${PROJECT_SOURCE_DIR})

    target_link_libraries(hello_tests PRIVATE gtest_main)

    include(GoogleTest)
    gtest_discover_tests(hello_tests)
endif()
