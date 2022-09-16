#include "blst.h"
#include "blst_misc.h"

#include "anemoi.h"
#include "caml_bls12_381_stubs.h"

#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

value caml_bls12_381_hash_anemoi_jive128_1_compress_stubs(value vres, value vx,
                                                          value vy) {
  CAMLparam3(vres, vx, vy);
  anemoi_jive128_1_compress(Blst_fr_val(vres), Blst_fr_val(vx),
                            Blst_fr_val(vy));
  CAMLreturn(Val_unit);
}

#define Anemoi_ctxt_val(v) (*((anemoi_ctxt_t **)Data_custom_val(v)))

static void finalize_free_anemoi_ctxt(value vctxt) {
  anemoi_ctxt_t *ctxt = Anemoi_ctxt_val(vctxt);
  free(ctxt->state);
  free(ctxt);
}

static struct custom_operations anemoi_ctxt_ops = {"anemoi_ctxt_t",
                                                   finalize_free_anemoi_ctxt,
                                                   custom_compare_default,
                                                   custom_hash_default,
                                                   custom_serialize_default,
                                                   custom_deserialize_default,
                                                   custom_compare_ext_default,
                                                   custom_fixed_length_default};

value caml_bls12_381_hash_anemoi_jive_allocate_ctxt_stubs(value vl,
                                                          value vinit) {
  CAMLparam2(vl, vinit);
  CAMLlocal1(vblock);

  int l = Int_val(vl);
  int state_size = 2 * l;
  // Initialize state
  blst_fr *state = malloc(sizeof(blst_fr) * state_size);
  if (state == NULL) {
    caml_raise_out_of_memory();
  }
  for (int i = 0; i < state_size; i++) {
    memcpy(state + i, Blst_fr_val(Field(vinit, i)), sizeof(blst_fr));
  }

  anemoi_ctxt_t *ctxt = malloc(sizeof(anemoi_ctxt_t));
  if (ctxt == NULL) {
    free(state);
    caml_raise_out_of_memory();
  }
  ctxt->state = state;
  ctxt->l = l;

  size_t out_of_heap_memory_size =
      sizeof(blst_fr) * state_size + sizeof(anemoi_ctxt_t);
  vblock = caml_alloc_custom_mem(&anemoi_ctxt_ops, sizeof(anemoi_ctxt_t *),
                                 out_of_heap_memory_size);

  anemoi_ctxt_t **block = (anemoi_ctxt_t **)Data_custom_val(vblock);
  *block = ctxt;

  CAMLreturn(vblock);
}

value caml_bls12_381_hash_anemoi_jive_get_state_stubs(value vbuffer,
                                                      value vctxt) {
  CAMLparam2(vbuffer, vctxt);
  anemoi_ctxt_t *ctxt = Anemoi_ctxt_val(vctxt);
  blst_fr *state = ctxt->state;
  for (int i = 0; i < 2 * ctxt->l; i++) {
    memcpy(Blst_fr_val(Field(vbuffer, i)), state + i, sizeof(blst_fr));
  }
  CAMLreturn(Val_unit);
}

value caml_bls12_381_hash_anemoi_jive_get_state_size_stubs(value vctxt) {
  CAMLparam1(vctxt);
  anemoi_ctxt_t *ctxt = Anemoi_ctxt_val(vctxt);
  CAMLreturn(Val_int(2 * ctxt->l));
}

value caml_bls12_381_hash_anemoi_jive_apply_stubs(value vctxt) {
  CAMLparam1(vctxt);
  anemoi_ctxt_t *ctxt = Anemoi_ctxt_val(vctxt);
  anemoi_jive_apply(ctxt);
  CAMLreturn(Val_unit);
}
