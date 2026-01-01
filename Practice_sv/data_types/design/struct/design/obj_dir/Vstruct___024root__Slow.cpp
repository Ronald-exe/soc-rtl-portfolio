// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vstruct.h for the primary calling header

#include "Vstruct__pch.h"
#include "Vstruct__Syms.h"
#include "Vstruct___024root.h"

void Vstruct___024root___ctor_var_reset(Vstruct___024root* vlSelf);

Vstruct___024root::Vstruct___024root(Vstruct__Syms* symsp, const char* v__name)
    : VerilatedModule{v__name}
    , vlSymsp{symsp}
 {
    // Reset structure values
    Vstruct___024root___ctor_var_reset(this);
}

void Vstruct___024root::__Vconfigure(bool first) {
    if (false && first) {}  // Prevent unused
}

Vstruct___024root::~Vstruct___024root() {
}
