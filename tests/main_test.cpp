#include <gtest/gtest.h>
#include <sstream>

// Декларація функції (щоб бачити її в тестах)
void printHello(std::ostream &out);

TEST(HelloFunctionTest, WritesHelloToStream) {
    std::ostringstream output;
    printHello(output);
    EXPECT_EQ(output.str(), "Hello, world!\n");
}
