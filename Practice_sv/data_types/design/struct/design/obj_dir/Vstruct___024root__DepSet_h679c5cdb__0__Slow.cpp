// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vstruct.h for the primary calling header

#include "Vstruct__pch.h"
#include "Vstruct___024root.h"

VL_ATTR_COLD void Vstruct___024root___eval_static(Vstruct___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vstruct__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vstruct___024root___eval_static\n"); );
}

VL_ATTR_COLD void Vstruct___024root___eval_initial__TOP(Vstruct___024root* vlSelf);

VL_ATTR_COLD void Vstruct___024root___eval_initial(Vstruct___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vstruct__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vstruct___024root___eval_initial\n"); );
    // Body
    Vstruct___024root___eval_initial__TOP(vlSelf);
}

VL_ATTR_COLD void Vstruct___024root___eval_initial__TOP(Vstruct___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vstruct__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vstruct___024root___eval_initial__TOP\n"); );
    // Init
    Vstruct_struck__DOT____typeimpsu1__struct__0 struck__DOT__st_fruit;
    struck__DOT__st_fruit.__PVT__cout = 0;
    struck__DOT__st_fruit.__PVT__expiry = 0;
    std::string __Vtemp_1;
    std::string __Vtemp_2;
    // Body
    struck__DOT__st_fruit = Vstruct_struck__DOT____typeimpsu1__struct__0{
        .__PVT__fruit = std::string{"apple"}, .__PVT__cout = (IData)(4U), 
        .__PVT__expiry = (CData)(0xfU)};
    __Vtemp_1 = VL_TO_STRING(struck__DOT__st_fruit);
    VL_WRITEF("st_fruit = %@\n",-1,&(__Vtemp_1));
    struck__DOT__st_fruit.__PVT__fruit = std::string{"pineapple"};
    struck__DOT__st_fruit.__PVT__expiry = 7U;
    __Vtemp_2 = VL_TO_STRING(struck__DOT__st_fruit);
    VL_WRITEF("st_fruit = %@\n",-1,&(__Vtemp_2));
}

VL_ATTR_COLD void Vstruct___024root___eval_final(Vstruct___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vstruct__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vstruct___024root___eval_final\n"); );
}

VL_ATTR_COLD void Vstruct___024root___eval_settle(Vstruct___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vstruct__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vstruct___024root___eval_settle\n"); );
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vstruct___024root___dump_triggers__act(Vstruct___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vstruct__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vstruct___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VactTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vstruct___024root___dump_triggers__nba(Vstruct___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vstruct__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vstruct___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vstruct___024root___ctor_var_reset(Vstruct___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vstruct__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vstruct___024root___ctor_var_reset\n"); );
}
