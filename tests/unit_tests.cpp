#include <gtest/gtest.h>
#include "math_operations.h"

TEST(MathOperationsTest, AddsPositiveNumbers) {
    EXPECT_EQ(add(2, 3), 5);
}

TEST(MathOperationsTest, AddsNegativeNumbers) {
    EXPECT_EQ(add(-2, -3), -5);
}

TEST(MathOperationsTest, AddsMixedNumbers) {
    EXPECT_EQ(add(-2, 3), 1);
}
