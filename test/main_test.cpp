// ...existing code...
#include <gtest/gtest.h>
#include <sstream>
#include <string>
#include <ostream>

// Declaration of the function under test
void printHello(std::ostream& os);

TEST(HelloFunctionTest, WritesHelloToStream) {
    std::ostringstream ss;
    printHello(ss);
    std::string output = ss.str();
    EXPECT_NE(std::string::npos, output.find("Hello"));
}
// ...existing code...