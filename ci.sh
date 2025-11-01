#!/bin/bash
set -e

echo "========================================"
echo "CI: Build and test (no parameters required)"
echo "========================================"

# Create build directory if not exists
if [ ! -d "build" ]; then
  echo "Creating 'build' directory..."
  mkdir build
else
  echo "'build' directory already exists"
fi

echo ""
echo "Configuring project with: cmake .."
cd build
cmake .. || { echo "CMake configuration failed"; exit 1; }

echo ""
echo "Building project with: cmake --build ."
cmake --build . || { echo "Build failed"; exit 1; }

echo ""
echo "Running tests with ctest"
ctest --output-on-failure || { echo "Tests failed"; exit 1; }

echo ""
echo "Build and tests completed successfully!"
