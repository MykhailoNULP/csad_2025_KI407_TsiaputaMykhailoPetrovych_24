#include <gtest/gtest.h>
#include <sstream>
#include "math_operations.h"

// Декларація функції (щоб бачити її в тестах)
void printHello(std::ostream &out);

TEST(HelloFunctionTest, WritesHelloToStream) {
    std::ostringstream output;
    printHello(output);
    EXPECT_EQ(output.str(), "Hello, world!\n");
}

TEST(MathOperationsTest, AddsCorrectly) {
    EXPECT_EQ(add(2, 3), 5);
    EXPECT_EQ(add(-1, 1), 0);
}
