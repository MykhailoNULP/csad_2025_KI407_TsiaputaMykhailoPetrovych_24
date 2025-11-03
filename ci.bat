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

if %errorlevel% neq 0 exit /b %errorlevel%

echo Building project with: cmake --build .
cmake --build .

if %errorlevel% neq 0 exit /b %errorlevel%

echo Running tests with: ctest --output-on-failure
ctest --output-on-failure

if %errorlevel% neq 0 exit /b %errorlevel%

cd ..
echo Build and tests completed successfully!
