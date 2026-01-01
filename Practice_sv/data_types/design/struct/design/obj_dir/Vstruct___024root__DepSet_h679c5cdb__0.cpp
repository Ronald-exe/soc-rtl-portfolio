// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vstruct.h for the primary calling header

#include "Vstruct__pch.h"
#include "Vstruct___024root.h"

void Vstruct___024root___eval_act(Vstruct___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vstruct__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vstruct___024root___eval_act\n"); );
}

void Vstruct___024root___eval_nba(Vstruct___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vstruct__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vstruct___024root___eval_nba\n"); );
}

void Vstruct___024root___eval_triggers__act(Vstruct___024root* vlSelf);

bool Vstruct___024root___eval_phase__act(Vstruct___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vstruct__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vstruct___024root___eval_phase__act\n"); );
    // Init
    VlTriggerVec<0> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vstruct___024root___eval_triggers__act(vlSelf);
    __VactExecute = vlSelf->__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
        vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
        Vstruct___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vstruct___024root___eval_phase__nba(Vstruct___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vstruct__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vstruct___024root___eval_phase__nba\n"); );
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelf->__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vstruct___024root___eval_nba(vlSelf);
        vlSelf->__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vstruct___024root___dump_triggers__nba(Vstruct___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vstruct___024root___dump_triggers__act(Vstruct___024root* vlSelf);
#endif  // VL_DEBUG

void Vstruct___024root___eval(Vstruct___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vstruct__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vstruct___024root___eval\n"); );
    // Init
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
            Vstruct___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("struct.sv", 1, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                Vstruct___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("struct.sv", 1, "", "Active region did not converge.");
            }
            vlSelf->__VactIterCount = ((IData)(1U) 
                                       + vlSelf->__VactIterCount);
            vlSelf->__VactContinue = 0U;
            if (Vstruct___024root___eval_phase__act(vlSelf)) {
                vlSelf->__VactContinue = 1U;
            }
        }
        if (Vstruct___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vstruct___024root___eval_debug_assertions(Vstruct___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vstruct__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vstruct___024root___eval_debug_assertions\n"); );
}
#endif  // VL_DEBUG

std::string VL_TO_STRING(const Vstruct_struck__DOT____typeimpsu1__struct__0& obj) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vstruct___024root::VL_TO_STRING\n"); );
    // Body
    std::string out;
    out += "'{fruit:" + VL_TO_STRING(obj.__PVT__fruit);
        out += ", cout:" + VL_TO_STRING(obj.__PVT__cout);
        out += ", expiry:" + VL_TO_STRING(obj.__PVT__expiry);
        out += "}";
    return out;
}
