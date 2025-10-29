#include <gtest/gtest.h>
#include <sstream>
#include <string>
#include <ostream>

// Declarations of functions under test
void printHello(std::ostream& os);
int add(int a, int b);

TEST(HelloFunctionTest, WritesHelloToStream) {
    std::ostringstream ss;
    printHello(ss);
    std::string output = ss.str();
    EXPECT_NE(std::string::npos, output.find("Hello"));
}

TEST(AddFunctionTest, HandlesPositiveNumbers) {
    EXPECT_EQ(add(2, 3), 5);
}

TEST(AddFunctionTest, HandlesNegativeNumbers) {
    EXPECT_EQ(add(-2, -3), -5);
}

TEST(AddFunctionTest, HandlesZero) {
    EXPECT_EQ(add(0, 0), 0);
}
