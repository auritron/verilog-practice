#include <verilated.h>
#include <iostream>
#include "Vdesign.h"

double sc_time_stamp() {
    return 0;
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    Vdesign* top = new Vdesign;

    int sim_time = 0;

    bool test_a[] = {0, 1, 0, 1};
    bool test_b[] = {0, 0, 1, 1};

    std::cout << "Starting Simulation..." << std::endl;

    for (int i = 0; i < 4; i++) {
        top->in_a = test_a[i];
        top->in_b = test_b[i];

        top->eval();

        std::cout << "Time = " << sim_time << "ns | "
                  << "a = " << (int)top->in_a << ", "
                  << "b = " << (int)top->in_b << " | "
                  << "out = " << (int)top->out << std::endl;

        sim_time += 10;
    }

    top->final();
    delete top;
    return 0;
}
