# Copilot: generate a cross-platform CMakeLists.txt for this project.
# Requirements:
# - cmake_minimum_required(VERSION 3.16)
# - project name: csad_2025_project
# - C++ standard: C++17 (required)
# - add option(BUILD_TESTS "Build unit tests" ON)
# - create executable target 'hello' from main.cpp
# - use FetchContent to integrate GoogleTest when BUILD_TESTS is ON
# - add enable_testing() and add_test for the test executable
# - add install(TARGETS) rules for the 'hello' executable (RUNTIME DESTINATION bin)
# - keep file cross-platform (works on Linux/Windows/macOS)

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
    GIT_REPOSITORY https://github.com/google/googletest.git
    GIT_TAG main
)
FetchContent_MakeAvailable(googletest)



    # For MSVC: prefer shared CRT for gtest to match project settings (no-op on other platforms)
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)

    FetchContent_MakeAvailable(googletest)

    # Add a test executable. Create tests under test/ (add test sources there).
    add_executable(hello_tests
        test/main_test.cpp
    )

    target_link_libraries(hello_tests
        PRIVATE
            gtest_main
    )

    include(GoogleTest)
    gtest_discover_tests(hello_tests)

    # Also provide a classic add_test for compatibility
    add_test(NAME hello_tests COMMAND hello_tests)
endif()
