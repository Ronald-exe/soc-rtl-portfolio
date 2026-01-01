// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Model implementation (design independent parts)

#include "Vstruct__pch.h"

//============================================================
// Constructors

Vstruct::Vstruct(VerilatedContext* _vcontextp__, const char* _vcname__)
    : VerilatedModel{*_vcontextp__}
    , vlSymsp{new Vstruct__Syms(contextp(), _vcname__, this)}
    , rootp{&(vlSymsp->TOP)}
{
    // Register model with the context
    contextp()->addModel(this);
}

Vstruct::Vstruct(const char* _vcname__)
    : Vstruct(Verilated::threadContextp(), _vcname__)
{
}

//============================================================
// Destructor

Vstruct::~Vstruct() {
    delete vlSymsp;
}

//============================================================
// Evaluation function

#ifdef VL_DEBUG
void Vstruct___024root___eval_debug_assertions(Vstruct___024root* vlSelf);
#endif  // VL_DEBUG
void Vstruct___024root___eval_static(Vstruct___024root* vlSelf);
void Vstruct___024root___eval_initial(Vstruct___024root* vlSelf);
void Vstruct___024root___eval_settle(Vstruct___024root* vlSelf);
void Vstruct___024root___eval(Vstruct___024root* vlSelf);

void Vstruct::eval_step() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vstruct::eval_step\n"); );
#ifdef VL_DEBUG
    // Debug assertions
    Vstruct___024root___eval_debug_assertions(&(vlSymsp->TOP));
#endif  // VL_DEBUG
    vlSymsp->__Vm_deleter.deleteAll();
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) {
        vlSymsp->__Vm_didInit = true;
        VL_DEBUG_IF(VL_DBG_MSGF("+ Initial\n"););
        Vstruct___024root___eval_static(&(vlSymsp->TOP));
        Vstruct___024root___eval_initial(&(vlSymsp->TOP));
        Vstruct___024root___eval_settle(&(vlSymsp->TOP));
    }
    VL_DEBUG_IF(VL_DBG_MSGF("+ Eval\n"););
    Vstruct___024root___eval(&(vlSymsp->TOP));
    // Evaluate cleanup
    Verilated::endOfEval(vlSymsp->__Vm_evalMsgQp);
}

//============================================================
// Events and timing
bool Vstruct::eventsPending() { return false; }

uint64_t Vstruct::nextTimeSlot() {
    VL_FATAL_MT(__FILE__, __LINE__, "", "%Error: No delays in the design");
    return 0;
}

//============================================================
// Utilities

const char* Vstruct::name() const {
    return vlSymsp->name();
}

//============================================================
// Invoke final blocks

void Vstruct___024root___eval_final(Vstruct___024root* vlSelf);

VL_ATTR_COLD void Vstruct::final() {
    Vstruct___024root___eval_final(&(vlSymsp->TOP));
}

//============================================================
// Implementations of abstract methods from VerilatedModel

const char* Vstruct::hierName() const { return vlSymsp->name(); }
const char* Vstruct::modelName() const { return "Vstruct"; }
unsigned Vstruct::threads() const { return 1; }
void Vstruct::prepareClone() const { contextp()->prepareClone(); }
void Vstruct::atClone() const {
    contextp()->threadPoolpOnClone();
}

//============================================================
// Trace configuration

VL_ATTR_COLD void Vstruct::trace(VerilatedVcdC* tfp, int levels, int options) {
    vl_fatal(__FILE__, __LINE__, __FILE__,"'Vstruct::trace()' called on model that was Verilated without --trace option");
}
