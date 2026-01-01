// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Symbol table internal header
//
// Internal details; most calling programs do not need this header,
// unless using verilator public meta comments.

#ifndef VERILATED_VSTRUCT__SYMS_H_
#define VERILATED_VSTRUCT__SYMS_H_  // guard

#include "verilated.h"

// INCLUDE MODEL CLASS

#include "Vstruct.h"

// INCLUDE MODULE CLASSES
#include "Vstruct___024root.h"

// SYMS CLASS (contains all model state)
class alignas(VL_CACHE_LINE_BYTES)Vstruct__Syms final : public VerilatedSyms {
  public:
    // INTERNAL STATE
    Vstruct* const __Vm_modelp;
    VlDeleter __Vm_deleter;
    bool __Vm_didInit = false;

    // MODULE INSTANCE STATE
    Vstruct___024root              TOP;

    // CONSTRUCTORS
    Vstruct__Syms(VerilatedContext* contextp, const char* namep, Vstruct* modelp);
    ~Vstruct__Syms();

    // METHODS
    const char* name() { return TOP.name(); }
};

#endif  // guard
