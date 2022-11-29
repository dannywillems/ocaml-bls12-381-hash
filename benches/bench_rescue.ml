open Core_bench

let t_state_size_3 =
  let open Bls12_381_hash.Rescue.Parameters in
  let inputs =
    Array.init security_128_state_size_3.state_size (fun _ ->
        Bls12_381.Fr.random ())
  in
  let ctxt = Bls12_381_hash.Rescue.allocate_ctxt security_128_state_size_3 in
  let () = Bls12_381_hash.Rescue.set_state ctxt inputs in
  let name = "Benchmark one permutation of Rescue" in
  Bench.Test.create ~name (fun () ->
      Bls12_381_hash.Rescue.apply_permutation ctxt)

let command = Bench.make_command [t_state_size_3]

let () = Core.Command.run command
