#include <iostream>
#include <ostream>

/**
 * Write a friendly greeting to the provided output stream.
 *
 * This function is useful for unit tests that inject a string stream
 * instead of using std::cout directly.
 */
void printHello(std::ostream& os) {
    os << "Hello, World!" << std::endl;
}

/**
 * Add two integers and return the result.
 *
 * Parameters:
 *  - a: first addend
 *  - b: second addend
 *
 * Returns:
 *  The arithmetic sum a + b.
 *
 * This function is intentionally simple, portable, and suitable for
 * use in tests and other code.
 */
int add(int a, int b) {
    return a + b;
}

int main() {
    // Use printHello so tests that depend on printHello(...) will pass.
    printHello(std::cout);
    return 0;
}
