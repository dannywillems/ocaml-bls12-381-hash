open Core_bench

let t1 =
  let name = "Benchmark one permutation of Poseidon128" in
  let state_size, nb_full_rounds, nb_partial_rounds, batch_size, ark, mds =
    Bls12_381_hash.Poseidon.Parameters.state_size_128_3
  in
  let state = Array.init state_size (fun _ -> Bls12_381.Fr.random ()) in
  let ctxt =
    Bls12_381_hash.Poseidon.allocate_ctxt
      state_size
      nb_full_rounds
      nb_partial_rounds
      batch_size
      ark
      mds
  in
  let () = Bls12_381_hash.Poseidon.set_state ctxt state in
  Bench.Test.create ~name (fun () ->
      Bls12_381_hash.Poseidon.apply_permutation ctxt)

let create_bench nb_full_rounds nb_partial_rounds width batch_size =
  let ark_length = width * (nb_full_rounds + nb_partial_rounds) in
  let ark = Array.init ark_length (fun _ -> Bls12_381.Fr.random ()) in
  let mds =
    Array.init width (fun _ ->
        Array.init width (fun _ -> Bls12_381.Fr.random ()))
  in
  let state = Array.init width (fun _ -> Bls12_381.Fr.random ()) in
  let ctxt =
    Bls12_381_hash.Poseidon.allocate_ctxt
      width
      nb_full_rounds
      nb_partial_rounds
      batch_size
      ark
      mds
  in
  let () = Bls12_381_hash.Poseidon.set_state ctxt state in
  let name =
    Printf.sprintf
      "Benchmark Poseidon: width = %d, partial = %d, full = %d, batch size = %d"
      width
      nb_partial_rounds
      nb_full_rounds
      batch_size
  in
  let t =
    Bench.Test.create ~name (fun () ->
        Bls12_381_hash.Poseidon.apply_permutation ctxt)
  in
  t

let create_bench_different_batch_size_same_parameters_width state_size =
  let _, nb_full_rounds, nb_partial_rounds, _batch_size, ark, mds =
    Bls12_381_hash.Poseidon.Parameters.state_size_128_3
  in
  let state = Array.init state_size (fun _ -> Bls12_381.Fr.random ()) in
  let batch_sizes = [1; 2; 3; 5; 7; 10; 15] in
  let benches =
    List.map
      (fun batch_size ->
        let ctxt =
          Bls12_381_hash.Poseidon.allocate_ctxt
            state_size
            nb_full_rounds
            nb_partial_rounds
            batch_size
            ark
            mds
        in
        let () = Bls12_381_hash.Poseidon.set_state ctxt state in
        let name =
          Printf.sprintf
            "Benchmark Poseidon: width = %d, batch size = %d"
            state_size
            batch_size
        in
        Bench.Test.create ~name (fun () ->
            Bls12_381_hash.Poseidon.apply_permutation ctxt))
      batch_sizes
  in
  benches

let bench_neptunus =
  let width = 5 in
  let nb_full_rounds = 60 in
  let nb_partial_rounds = 0 in
  let batch_size = 1 in
  let ark_length = width * (nb_full_rounds + nb_partial_rounds) in
  let ark = Array.init ark_length (fun _ -> Bls12_381.Fr.random ()) in
  let mds =
    Array.init width (fun _ ->
        Array.init width (fun _ -> Bls12_381.Fr.random ()))
  in
  let state = Array.init width (fun _ -> Bls12_381.Fr.random ()) in
  let ctxt =
    Bls12_381_hash.Poseidon.allocate_ctxt
      width
      nb_full_rounds
      nb_partial_rounds
      batch_size
      ark
      mds
  in
  let () = Bls12_381_hash.Poseidon.set_state ctxt state in
  let name = "Benchmark Neptunus" in
  Bench.Test.create ~name (fun () ->
      Bls12_381_hash.Poseidon.apply_permutation ctxt)

let command =
  Bench.make_command
    (t1 :: bench_neptunus
    :: List.concat
         [ create_bench_different_batch_size_same_parameters_width 5;
           create_bench_different_batch_size_same_parameters_width 3 ])

let () = Core.Command.run command
