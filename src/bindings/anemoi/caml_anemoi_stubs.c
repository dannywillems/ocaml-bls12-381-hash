#include "blst.h"
#include "blst_misc.h"

#include "anemoi.h"
#include "caml_bls12_381_stubs.h"

#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>
#include <caml/memory.h>
#include <caml/mlvalues.h>

// From ocaml/ocaml
// https://github.com/ocaml/ocaml/blob/aca84729327d327eaf6e82f3ae15d0a63953288e/runtime/caml/mlvalues.h#L401
#if OCAML_VERSION < 412000
#define Val_none Val_int(0)
#define Some_val(v) Field(v, 0)
#define Tag_some 0
#define Is_none(v) ((v) == Val_none)
#define Is_some(v) Is_block(v)
#endif

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
  free(ctxt->ctxt);
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

value caml_bls12_381_hash_anemoi_jive_allocate_ctxt_stubs(value vmds,
                                                          value vconstants,
                                                          value vl,
                                                          value vinit) {
  CAMLparam4(vl, vinit, vmds, vconstants);
  CAMLlocal1(vblock);

  int l = Int_val(vl);
  int state_size = 2 * l;

  int nb_rounds;

  // compute number of rounds
  if (l == 1) {
    nb_rounds = 19;
  }

  else if (l == 2) {
    nb_rounds = 12;
  } else {
    nb_rounds = 10;
  }

  int mds_size = l * l;
  int nb_constants = l * 2 * nb_rounds;
  int total_blst_fr_elements = state_size;
  if (l > 4) {
    total_blst_fr_elements += mds_size + nb_constants;
  }

  // Initialize state. It contains the constants and the MDS
  blst_fr *ctxt_internal = malloc(sizeof(blst_fr) * total_blst_fr_elements);

  if (ctxt_internal == NULL) {
    caml_raise_out_of_memory();
  }

  blst_fr *state = ctxt_internal;

  for (int i = 0; i < state_size; i++) {
    memcpy(state + i, Blst_fr_val(Field(vinit, i)), sizeof(blst_fr));
  }

  if (l > 4) {
    blst_fr *mds = ctxt_internal + state_size;
    blst_fr *constants = ctxt_internal + state_size + mds_size;

    // Copying MDS
    for (int i = 0; i < l; i++) {
      for (int j = 0; j < l; j++) {
        memcpy(mds + i * l + j, Fr_val_ij(Some_val(vmds), i, j),
               sizeof(blst_fr));
      }
    }

    // Copying ark
    for (int i = 0; i < nb_constants; i++) {
      memcpy(constants + i, Fr_val_k(Some_val(vconstants), i), sizeof(blst_fr));
    }
  }

  anemoi_ctxt_t *ctxt = malloc(sizeof(anemoi_ctxt_t));
  if (ctxt == NULL) {
    free(ctxt_internal);
    caml_raise_out_of_memory();
  }
  ctxt->ctxt = ctxt_internal;
  ctxt->l = l;
  ctxt->nb_rounds = nb_rounds;

  size_t out_of_heap_memory_size =
      sizeof(blst_fr) * total_blst_fr_elements + sizeof(anemoi_ctxt_t);
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
  blst_fr *state = ctxt->ctxt;
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
