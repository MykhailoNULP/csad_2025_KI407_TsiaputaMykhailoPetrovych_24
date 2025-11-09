#include <iostream>
#include "math_operations.h"

// Функція, яку перевіряють тести
void printHello(std::ostream &out) {
    out << "Hello, world!\n";
}

int main() {
    printHello(std::cout);
    std::cout << "2 + 3 = " << add(2, 3) << std::endl;
    return 0;
}
