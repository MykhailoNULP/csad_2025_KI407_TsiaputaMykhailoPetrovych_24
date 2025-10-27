#include <gtest/gtest.h>
#include <sstream>
#include <string>

// Forward declaration of the program's main.
// Ensure the test target links the translation unit that defines main() (e.g. main.cpp).
extern int main();

TEST(HelloWorldTest, PrintsHello) {
    std::ostringstream ss;
    std::streambuf* old_buf = std::cout.rdbuf(ss.rdbuf());

    // Call the program entry point
    main();

    // Restore original buffer
    std::cout.rdbuf(old_buf);

    std::string output = ss.str();
    EXPECT_NE(std::string::npos, output.find("Hello"));
}