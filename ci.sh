@echo off
echo ========================================
echo CI: Build and test (no parameters required)
echo ========================================

if exist build (
    echo Removing old build directory...
    rmdir /s /q build
)

echo Creating 'build' directory...
mkdir build
cd build

echo Configuring project with: cmake ..
cmake ..

if %errorlevel% neq 0 (
    echo CMake configuration failed
    exit /b %errorlevel%
)

echo Building project with: cmake --build .
cmake --build .

if %errorlevel% neq 0 (
    echo Build failed
    exit /b %errorlevel%
)

echo Running tests...
ctest --output-on-failure