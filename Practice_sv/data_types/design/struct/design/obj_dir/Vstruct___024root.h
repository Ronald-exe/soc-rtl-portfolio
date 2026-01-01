// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vstruct.h for the primary calling header

#ifndef VERILATED_VSTRUCT___024ROOT_H_
#define VERILATED_VSTRUCT___024ROOT_H_  // guard

#include "verilated.h"
#include "Vstruct___024root.h"


class Vstruct__Syms;

// UNPACKED STRUCT TYPES
struct Vstruct_struck__DOT____typeimpsu1__struct__0 {
    std::string __PVT__fruit;
    IData/*31:0*/ __PVT__cout;
    CData/*7:0*/ __PVT__expiry;

    bool operator==(const Vstruct_struck__DOT____typeimpsu1__struct__0& rhs) const {
        return __PVT__fruit == rhs.__PVT__fruit
            && __PVT__cout == rhs.__PVT__cout
            && __PVT__expiry == rhs.__PVT__expiry;
    }
    bool operator!=(const Vstruct_struck__DOT____typeimpsu1__struct__0& rhs) const {
        return !(*this == rhs);
    }
};

class alignas(VL_CACHE_LINE_BYTES) Vstruct___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    CData/*0:0*/ __VactContinue;
    IData/*31:0*/ __VactIterCount;
    VlTriggerVec<0> __VactTriggered;
    VlTriggerVec<0> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vstruct__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vstruct___024root(Vstruct__Syms* symsp, const char* v__name);
    ~Vstruct___024root();
    VL_UNCOPYABLE(Vstruct___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};

std::string VL_TO_STRING(const Vstruct_struck__DOT____typeimpsu1__struct__0& obj);

#endif  // guard
