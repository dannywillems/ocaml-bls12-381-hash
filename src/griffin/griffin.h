#ifndef GRIFFIN_H
#define GRIFFIN_H

#include "blst.h"
#include <stdlib.h>
#include <string.h>

typedef struct griffin_ctxt_s {
  // State. Contains the actual state, the alpha beta and the round constants
  blst_fr *state;
  // state_size := m = 2 * l
  int state_size;
  int nb_rounds;
} griffin_ctxt_t;

void griffin_apply_permutation(griffin_ctxt_t *ctxt);

blst_fr *griffin_get_state_from_context(griffin_ctxt_t *ctxt);

blst_fr *griffin_get_alpha_beta_from_context(griffin_ctxt_t *ctxt);

blst_fr *griffin_get_round_constants_from_context(griffin_ctxt_t *ctxt);

#endif
