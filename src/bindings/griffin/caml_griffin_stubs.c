#include "blst.h"
#include "griffin.h"
#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>
#include <stdlib.h>
#include <string.h>

#include "caml_bls12_381_stubs.h"

CAMLprim value caml_bls12_381_griffin_allocate_ctxt_stubs(value vunit) {
  CAMLparam1(vunit);
  CAMLlocal1(block);
  block = caml_alloc_custom(&blst_fr_ops, sizeof(blst_fr) * GRIFFIN_STATE_SIZE, 0, 1);
  CAMLreturn(block);
}

CAMLprim value caml_bls12_381_griffin_init_ctxt_stubs(value vctxt, value va,
                                                      value vb, value vc) {
  CAMLparam4(vctxt, va, vb, vc);
  blst_fr *ctxt = Blst_fr_val(vctxt);
  blst_fr *a = Blst_fr_val(va);
  blst_fr *b = Blst_fr_val(vb);
  blst_fr *c = Blst_fr_val(vc);
  memcpy(ctxt, a, sizeof(blst_fr));
  memcpy(ctxt + 1, b, sizeof(blst_fr));
  memcpy(ctxt + 2, c, sizeof(blst_fr));
  CAMLreturn(Val_unit);
}

value caml_bls12_381_griffin_apply_permutation_stubs(value vctxt) {
  CAMLparam1(vctxt);
  griffin_apply_permutation(Blst_fr_val(vctxt));
  CAMLreturn(Val_unit);
}

CAMLprim value caml_bls12_381_griffin_get_state_stubs(value va, value vb,
                                                      value vc, value vctxt) {
  CAMLparam4(va, vb, vc, vctxt);
  blst_fr *ctxt = Blst_fr_val(vctxt);
  blst_fr *a = Blst_fr_val(va);
  blst_fr *b = Blst_fr_val(vb);
  blst_fr *c = Blst_fr_val(vc);
  memcpy(a, ctxt, sizeof(blst_fr));
  memcpy(b, ctxt + 1, sizeof(blst_fr));
  memcpy(c, ctxt + 2, sizeof(blst_fr));
  CAMLreturn(Val_unit);
}
