cmake_minimum_required(VERSION 3.16)

project(csad_2025_project VERSION 0.1.0 LANGUAGES CXX)

# Require C++17
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(BUILD_TESTS "Build unit tests" ON)

# Create the main executable from main.cpp
add_executable(hello
    main.cpp
)

# Install rule for the executable (cross-platform)
install(TARGETS hello
    RUNTIME DESTINATION bin
)

# Unit tests (optional)
if(BUILD_TESTS)
    enable_testing()

    include(FetchContent)

    # Use a known stable release of GoogleTest
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
        PRIVATE gtest_main
    )

    include(GoogleTest)
    gtest_discover_tests(hello_tests)

    add_test(NAME hello_tests COMMAND hello_tests)
endif()
