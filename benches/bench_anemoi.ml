open Core_bench

let t1 =
  let a, b = (Bls12_381.Fr.random (), Bls12_381.Fr.random ()) in
  let name = "Benchmark AnemoiJive128_1" in
  Bench.Test.create ~name (fun () ->
      ignore @@ Bls12_381_hash.Anemoi.jive128_1 a b)

let t2 l =
  let state_size = l * 2 in
  let nb_rounds = if l = 1 then 19 else if l = 2 then 12 else 10 in
  let mds, constants =
    if l > 4 then
      let mds =
        Array.init l (fun _ -> Array.init l (fun _ -> Bls12_381.Fr.random ()))
      in
      let constants =
        Array.init (2 * l * nb_rounds) (fun _ -> Bls12_381.Fr.random ())
      in
      (Some mds, Some constants)
    else (None, None)
  in
  let state = Array.init state_size (fun _ -> Bls12_381.Fr.random ()) in
  let name = Printf.sprintf "Benchmark AnemoiJive%d" l in
  let parameters =
    if state_size = 2 then
      Bls12_381_hash.Anemoi.Parameters.security_128_state_size_2
    else if state_size = 4 then
      Bls12_381_hash.Anemoi.Parameters.security_128_state_size_4
    else if state_size = 6 then
      Bls12_381_hash.Anemoi.Parameters.security_128_state_size_6
    else if state_size = 8 then
      Bls12_381_hash.Anemoi.Parameters.security_128_state_size_8
    else
      Bls12_381_hash.Anemoi.Parameters.
        { nb_rounds;
          state_size;
          linear_layer = Option.get mds;
          round_constants = Option.get constants
        }
  in
  let ctxt = Bls12_381_hash.Anemoi.allocate_ctxt parameters in
  let () = Bls12_381_hash.Anemoi.set_state ctxt state in
  Bench.Test.create ~name (fun () ->
      Bls12_381_hash.Anemoi.apply_permutation ctxt)

let command = Bench.make_command [t1; t2 2; t2 3; t2 4; t2 5; t2 6; t2 10]

let () = Core.Command.run command
