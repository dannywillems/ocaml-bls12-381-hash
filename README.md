# OCaml implementation of BLS12-381

**Use with caution before release 1.0.0**

This library provides a fast implementation of:
- an instantiation of
  [Poseidon](https://eprint.iacr.org/2019/458.pdf) providing a security of
  128 bits. See [the
  documentation](https://dannywillems.gitlab.io/ocaml-bls12-381-hash/bls12-381-hash/Bls12_381_hash/Poseidon128/index.html)
  for more information on the used parameters.
- an instantiation of
  [Rescue](https://eprint.iacr.org/2019/426.pdf) providing a security of
  128 bits. See [the
  documentation](https://dannywillems.gitlab.io/ocaml-bls12-381-hash/bls12-381-hash/Bls12_381_hash/Rescue/index.html)
  for more information on the used parameters.
- an instantiation of [Anemoi](https://eprint.iacr.org/2022/840) providing a
  security of 128 bits. See [the
  documentation](https://dannywillems.gitlab.io/ocaml-bls12-381-hash/bls12-381-hash/Bls12_381_hash/Anemoi/index.html)
  for more information on the used parameters.

## Install


```shell
opam install bls12-381-hash
```

## Run tests

```
dune runtest
```

To get the coverage:
```
dune runtest --instrument-with bisect_ppx --force
bisect-ppx-report html
```

## Run the benchmarks

Install `core_bench`:

```
opam install core_bench
```

See files listed in the directory `benchmark` and execute it with `dune exec`. For instance:
```
dune exec ./benchmark/bench_anemoi.exe
```

## Documentation

```
opam install odoc
dune build @doc
```
