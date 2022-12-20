open Core_bench

let t1 =
  let open Bls12_381_hash.Permutation.Poseidon.Parameters in
  let name = "Benchmark one permutation of Poseidon128" in
  let state =
    Array.init security_128_state_size_3.state_size (fun _ ->
        Bls12_381.Fr.random ())
  in
  let ctxt =
    Bls12_381_hash.Permutation.Poseidon.allocate_ctxt security_128_state_size_3
  in
  let () = Bls12_381_hash.Permutation.Poseidon.set_state ctxt state in
  Bench.Test.create ~name (fun () ->
      Bls12_381_hash.Permutation.Poseidon.apply_permutation ctxt)

let create_bench nb_of_full_rounds nb_of_partial_rounds state_size batch_size =
  let open Bls12_381_hash.Permutation.Poseidon.Parameters in
  let ark_length = state_size * (nb_of_full_rounds + nb_of_partial_rounds) in
  let ark = Array.init ark_length (fun _ -> Bls12_381.Fr.random ()) in
  let mds =
    Array.init state_size (fun _ ->
        Array.init state_size (fun _ -> Bls12_381.Fr.random ()))
  in
  let parameters =
    { state_size;
      batch_size;
      round_constants = ark;
      linear_layer = mds;
      nb_of_full_rounds;
      nb_of_partial_rounds
    }
  in
  let state = Array.init state_size (fun _ -> Bls12_381.Fr.random ()) in
  let ctxt = Bls12_381_hash.Permutation.Poseidon.allocate_ctxt parameters in
  let () = Bls12_381_hash.Permutation.Poseidon.set_state ctxt state in
  let name =
    Printf.sprintf
      "Benchmark Poseidon: width = %d, partial = %d, full = %d, batch size = %d"
      state_size
      nb_of_partial_rounds
      nb_of_full_rounds
      batch_size
  in
  let t =
    Bench.Test.create ~name (fun () ->
        Bls12_381_hash.Permutation.Poseidon.apply_permutation ctxt)
  in
  t

let bench_neptunus =
  let state_size = 5 in
  let nb_of_full_rounds = 60 in
  let nb_of_partial_rounds = 0 in
  let batch_size = 1 in
  let ark_length = state_size * (nb_of_full_rounds + nb_of_partial_rounds) in
  let ark = Array.init ark_length (fun _ -> Bls12_381.Fr.random ()) in
  let mds =
    Array.init state_size (fun _ ->
        Array.init state_size (fun _ -> Bls12_381.Fr.random ()))
  in
  let state = Array.init state_size (fun _ -> Bls12_381.Fr.random ()) in
  let open Bls12_381_hash.Permutation.Poseidon.Parameters in
  let parameters =
    { state_size;
      batch_size;
      nb_of_full_rounds;
      nb_of_partial_rounds;
      round_constants = ark;
      linear_layer = mds
    }
  in
  let ctxt = Bls12_381_hash.Permutation.Poseidon.allocate_ctxt parameters in
  let () = Bls12_381_hash.Permutation.Poseidon.set_state ctxt state in
  let name = "Benchmark Neptunus" in
  Bench.Test.create ~name (fun () ->
      Bls12_381_hash.Permutation.Poseidon.apply_permutation ctxt)

let command = Bench.make_command (t1 :: [bench_neptunus])

let () = Command_unix.run command
