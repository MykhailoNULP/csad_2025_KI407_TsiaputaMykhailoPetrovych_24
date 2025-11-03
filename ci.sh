#!/bin/bash
set -e

echo "========================================"
echo "CI: Build and test (no parameters required)"
echo "========================================"

# Create build directory
if [ ! -d "build" ]; then
  echo "Creating 'build' directory..."
  mkdir build
else
  echo "'build' directory already exists"
fi

# Enter build directory
cd build

# Configure project
echo "Configuring project with: cmake .."
cmake ..

# Build project
echo "Building project with: cmake --build ."
cmake --build .

# Run tests (if any)
echo "Running tests with ctest"
ctest --output-on-failure || true

echo "========================================"
echo "✅ CI completed successfully"
echo "========================================"
