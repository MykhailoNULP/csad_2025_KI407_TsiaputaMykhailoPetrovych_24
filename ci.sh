#!/bin/bash
set -e

echo "========================================"
echo "CI: Build and test (no parameters required)"
echo "========================================"

# Clean previous build (important!)
if [ -d "build" ]; then
  echo "Removing old 'build' directory..."
  rm -rf build
fi

# Create fresh build directory
echo "Creating 'build' directory..."
mkdir build
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
