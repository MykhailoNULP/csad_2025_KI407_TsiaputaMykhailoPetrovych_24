#include <iostream>

// Функція, яку перевіряють тести
void printHello(std::ostream &out) {
    out << "Hello, world!\n";
}

int main() {
    printHello(std::cout);
    return 0;
}
