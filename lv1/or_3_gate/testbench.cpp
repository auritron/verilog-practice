#include <verilated.h>
#include <iostream>
#include "Vdesign.h"

inline constexpr size_t TEST_CASES = 8;

double sc_time_stamp() {
    return 0;
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    Vdesign* top = new Vdesign;

    int sim_time{0};

    using Test = std::array<bool, TEST_CASES>;
    Test tb_a = {0, 1, 0, 1, 0, 1, 0, 1};
    Test tb_b = {0, 0, 1, 1, 0, 0, 1, 1};
    Test tb_c = {0, 0, 0, 0, 1, 1, 1, 1};

    for (int i{0}; i < 8; i++) {
        top->in_a = tb_a[i];
        top->in_b = tb_b[i];
        top->in_c = tb_c[i];

        top->eval();

        std::cout << "Time: " << sim_time << "ns | "
                << "A: " << (int)top->in_a << " | "
                << "B: " << (int)top->in_b << " | "
                << "C: " << (int)top->in_c << " | "
                << "OUT = " << (int)top->out << "\n";

        sim_time += 10;
    
    }

    top->final();
    delete top;
    return 0;
}
