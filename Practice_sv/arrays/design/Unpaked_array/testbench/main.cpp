#include <iostream>
#include <cstdint> // Para usar uint8_t (como el byte de SV)
#include <vector>

int main() {
    // Un arreglo "unpacked" de 8 posiciones
    std::vector<uint8_t> stack = {0x24, 0x81, 0x09, 0x63, 0x0D, 0x8D, 0x65, 0x12};

    for (int i = 0; i < stack.size(); i++) {
        // Imprimimos en Hexadecimal (std::hex)
        std::cout << "Assign 0x" << std::hex << (int)stack[i] 
                  << " to index " << std::dec << i << std::endl;
    }

    return 0;
}
