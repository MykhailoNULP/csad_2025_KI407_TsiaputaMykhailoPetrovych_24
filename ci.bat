@echo off
setlocal

echo ========================================
echo CI: Build and test (no parameters required)
echo ========================================

REM Create build directory if it doesn't exist
if not exist "build" (
    echo Creating 'build' directory...
    mkdir "build" || (echo Failed to create 'build' & exit /b 1)
) else (
    echo 'build' directory already exists
)

REM Enter build directory
pushd "build" || (echo Failed to change directory to 'build' & exit /b 1)

REM Configure with CMake
echo.
echo Configuring project with: cmake ..
cmake .. || (echo CMake configuration failed & popd & exit /b 1)

REM Build the project
echo.
echo Building project with: cmake --build .
cmake --build . || (echo Build failed & popd & exit /b 1)

REM Run tests
echo.
echo Running tests with: ctest -V
ctest -V
set "CTEST_EXIT=%ERRORLEVEL%"

REM Return and exit with test status
popd
endlocal
exit /b %CTEST_EXIT%