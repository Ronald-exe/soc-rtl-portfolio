// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vstruct.h for the primary calling header

#include "Vstruct__pch.h"
#include "Vstruct__Syms.h"
#include "Vstruct___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vstruct___024root___dump_triggers__act(Vstruct___024root* vlSelf);
#endif  // VL_DEBUG

void Vstruct___024root___eval_triggers__act(Vstruct___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vstruct__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vstruct___024root___eval_triggers__act\n"); );
    // Body
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vstruct___024root___dump_triggers__act(vlSelf);
    }
#endif
}
