## 2.0.0

### Breaking API changes

- Implement Jive mode and move permutations in Permutation submodule (479cc0384f3171aea971c45b3e27e2de647f155c)
- Anemoi: add getters for Parameters.t (4990608b4e96d71e7c2dedcf5bf54ab246ca6e10)
- Anemoi: add security parameters for 20 rounds and 141bits of security for a state size of 2 (e12ee827e9ad948fcf8a9ddf34aebfd27499be9f)
- Anemoi: add apply_linear_layer/apply_flystel/apply_constants_addition (ff88ab1fce5a6b0011c085e8f2de79f4cdd76868)

### CI

- drop support for alpine 3.14 and 3.15 (f2b6b67506e01cd090eac14f675d708dae1659cb0
- add support for alpine 3.16 and 3.17 (b1aa50725eae85dea28056c73b98de21286f0215)

### Dependencies

- use dune 3.0 (5e9b3a1b950110ea49d6c5513d513eebe5d923c9)
- Use ocamlformat.0.24.1 (8a3d370895c8df3c83f1aee0902c8faa6592c878)
- Bump up core dependency version (2e5e9e13a26c6224e654e36d3ed2268ae0d8ab94)
