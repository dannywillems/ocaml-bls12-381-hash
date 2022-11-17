#ifndef ANEMOI_H
#define ANEMOI_H

#include "anemoi_constants.h"

#include "blst.h"
#include "blst_misc.h"
#include <string.h>

typedef struct anemoi_ctxt_s {
  // state_size := m = 2 * l
  int l;
  int nb_rounds;
  // State + MDS + constants
  blst_fr *ctxt;
} anemoi_ctxt_t;

void anemoi128_1_jive(blst_fr *res, blst_fr *x, blst_fr *y);

void anemoi_apply_permutation(anemoi_ctxt_t *ctxt);

void anemoi_apply_one_round(anemoi_ctxt_t *ctxt, int idx);

blst_fr *anemoi_get_state_from_context(anemoi_ctxt_t *ctxt);

anemoi_ctxt_t *anemoi_allocate_context(int l, int nb_rounds);

void anemoi_set_state_from_context(anemoi_ctxt_t *ctxt, blst_fr *state);

int anemoi_get_state_size_from_context(anemoi_ctxt_t *ctxt);

blst_fr *anemoi_get_mds_from_context(anemoi_ctxt_t *ctxt);

blst_fr *anemoi_get_round_constants_from_context(anemoi_ctxt_t *ctxt);

void anemoi_free_context(anemoi_ctxt_t *ctxt);

#endif
