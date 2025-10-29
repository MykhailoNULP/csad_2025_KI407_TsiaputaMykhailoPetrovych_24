#include <iostream>


void printHello(std::ostream& os) {
    os << "Hello, World!";
}

int main() {
    printHello(std::cout);
    return 0;
}
