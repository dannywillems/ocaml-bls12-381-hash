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

  free(res);

  return (0);
}
```

To compile, use:
```
gcc \
  -o main \
  anemoi.c main.c \
  -lblst \
  -I$(pwd) \
  -I$OPAM_SWITCH_PREFIX/lib/bls12-381 \
  -L$OPAM_SWITCH_PREFIX/lib/bls12-381
```
