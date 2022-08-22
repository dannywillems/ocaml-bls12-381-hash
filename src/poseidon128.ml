open Poseidon_utils

module Stubs = struct
  type ctxt

  external allocate_ctxt : unit -> ctxt
    = "caml_bls12_381_hash_poseidon128_allocate_ctxt_stubs"

  external constants_init :
    Bls12_381.Fr.t array ->
    Bls12_381.Fr.t array array ->
    int ->
    int ->
    int ->
    int = "caml_bls12_381_hash_poseidon128_constants_init_stubs"

  external init :
    ctxt -> Bls12_381.Fr.t -> Bls12_381.Fr.t -> Bls12_381.Fr.t -> unit
    = "caml_bls12_381_hash_poseidon128_init_stubs"

  external apply_perm : ctxt -> unit
    = "caml_bls12_381_hash_poseidon128_apply_perm_stubs"

  external get_state :
    Bls12_381.Fr.t -> Bls12_381.Fr.t -> Bls12_381.Fr.t -> ctxt -> unit
    = "caml_bls12_381_hash_poseidon128_get_state_stubs"
end

let width = 3

let nb_partial_rounds = 56

let nb_full_rounds = 8

let batch_size = 3

type ctxt = Stubs.ctxt

let constants_init ark mds =
  let mds_nb_rows = Array.length mds in
  assert (mds_nb_rows > 0) ;
  let mds_nb_cols = Array.length mds.(0) in
  let ( arc_full_round_start_with_first_partial,
        arc_intermediate_state,
        arc_unbatched,
        arc_full_round_end ) =
    compute_updated_constants
      nb_partial_rounds
      nb_full_rounds
      width
      batch_size
      ark
      mds
  in
  let ark =
    Array.concat
      [ arc_full_round_start_with_first_partial;
        arc_intermediate_state;
        arc_unbatched;
        arc_full_round_end;
        (* Adding dummy constants, zeroes, for the last round as we apply the
           round key at the end of a full round. *)
        Array.init width (fun _ -> Bls12_381.Fr.(copy zero)) ]
  in
  let ark_len = Array.length ark in
  assert (0 = Stubs.constants_init ark mds ark_len mds_nb_rows mds_nb_cols)

let init a b c =
  let ctxt = Stubs.allocate_ctxt () in
  Stubs.init ctxt a b c ;
  ctxt

let apply_permutation ctxt = Stubs.apply_perm ctxt

let get ctxt =
  let a = Bls12_381.Fr.(copy zero) in
  let b = Bls12_381.Fr.(copy zero) in
  let c = Bls12_381.Fr.(copy zero) in
  Stubs.get_state a b c ctxt ;
  (a, b, c)
