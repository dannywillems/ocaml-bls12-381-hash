open Core_bench

let t1 =
  let a, b, c =
    (Bls12_381.Fr.random (), Bls12_381.Fr.random (), Bls12_381.Fr.random ())
  in
  let name = "Benchmark one permutation of Griffin" in
  Bench.Test.create ~name (fun () ->
      let ctxt = Bls12_381_hash.Griffin.init a b c in
      let () = Bls12_381_hash.Griffin.apply_permutation ctxt in
      let _v = Bls12_381_hash.Griffin.get ctxt in
      ())

let command = Bench.make_command [t1]

let () = Core.Command.run command
