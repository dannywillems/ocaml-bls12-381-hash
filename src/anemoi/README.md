# Anemoi in C

This is a C implementation of AnemoiJive for `l = 1` for the scalar field of BLS12-381 using [blst](https://github.com/supranational/blst/).

## Compile

Here a simple program using the primitive:
```C
#include "blst.h"
#include "blst_misc.h"
#include "anemoi.h"
#include <string.h>
#include <stdlib.h>

int main() {
  blst_fr x0;
  blst_fr y0;
  blst_fr *res = malloc(sizeof(blst_fr));

  // Set x0 and y0 to 0
  memset(&x0, 0, sizeof(blst_fr));
  memset(&y0, 0, sizeof(blst_fr));

  anemoi_jive128_1_compress(res, &x0, &y0);

  return (0);
}
```

To compile, use:
```
gcc \
  -o main \
  anemoi.c main.c \
  -lblst \
  -lbls12_381_stubs \
  -I$(pwd) \
  -I$OPAM_SWITCH_PREFIX/lib/bls12-381 \
  -L$OPAM_SWITCH_PREFIX/lib/bls12-381
```

The current implementation uses additional primitives built over blst added by
[ocaml-bls12-381](https://gitlab.com/dannywillems/ocaml-bls12-381) like
`blst_fr_pow`. It will get removed later when the additional chain will be
implemented.
Therefore, you need to install first the OCaml package bls12-381. Simply follow
the instruction in the README of tis repository to install a compatible version.
