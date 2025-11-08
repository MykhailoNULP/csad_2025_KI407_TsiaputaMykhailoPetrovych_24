@echo off
echo ========================================
echo CI: Build and test (no parameters required)
echo ========================================

if exist build (
    echo Removing old 'build' directory...
    rmdir /s /q build
)

echo Creating 'build' directory...
mkdir build
cd build

echo Configuring project with: cmake ..
cmake ..

if errorlevel 1 (
    echo CMake configuration failed 
    exit /b 1
)

echo Building project with: cmake --build .
cmake --build . --config Release

if errorlevel 1 (
    echo Build failed 
    exit /b 1
)

echo Running tests...
ctest -C Release --output-on-failure
