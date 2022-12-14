open Core_bench

let t params =
  let name =
    Printf.sprintf
      "Benchmark one permutation of Griffin (state size = %d)"
      params.Bls12_381_hash.Permutation.Griffin.Parameters.state_size
  in
  let ctxt = Bls12_381_hash.Permutation.Griffin.allocate_ctxt params in
  let () =
    Bls12_381_hash.Permutation.Griffin.set_state
      ctxt
      (Array.init
         params.Bls12_381_hash.Permutation.Griffin.Parameters.state_size
         (fun _ -> Bls12_381.Fr.random ()))
  in
  Bench.Test.create ~name (fun () ->
      let () = Bls12_381_hash.Permutation.Griffin.apply_permutation ctxt in
      ())

let command =
  Bench.make_command
    [ t Bls12_381_hash.Permutation.Griffin.Parameters.security_128_state_size_3;
      t Bls12_381_hash.Permutation.Griffin.Parameters.security_128_state_size_4
    ]

let () = Command_unix.run command
