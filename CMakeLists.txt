cmake_minimum_required(VERSION 3.16)

project(csad_2025_project VERSION 0.1.0 LANGUAGES CXX)

# ==== Компілерні налаштування ====
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

option(BUILD_TESTS "Build unit tests" ON)

# ==== Основна програма ====
add_executable(hello
    main.cpp
    math_operations.cpp
)

target_include_directories(hello PRIVATE ${CMAKE_SOURCE_DIR})

# ==== Встановлення (інсталяція) ====
install(TARGETS hello
    RUNTIME DESTINATION bin
)

# ==== Тестування ====
if(BUILD_TESTS)
    enable_testing()

    include(FetchContent)

    # Отримуємо GoogleTest стабільної версії
    FetchContent_Declare(
        googletest
        URL https://github.com/google/googletest/archive/refs/tags/v1.15.2.zip
    )

    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(googletest)

    # Тестовий виконуваний файл
    add_executable(hello_tests
        tests/main_test.cpp
        math_operations.cpp
    )

    target_include_directories(hello_tests PRIVATE ${CMAKE_SOURCE_DIR})

    target_link_libraries(hello_tests
        PRIVATE
            gtest_main
    )

    include(GoogleTest)
    gtest_discover_tests(hello_tests)
endif()
