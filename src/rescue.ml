module Stubs = struct
  type ctxt

  external allocate_ctxt : unit -> ctxt
    = "caml_bls12_381_hash_rescue_allocate_ctxt_stubs"

  external constants_init :
    Bls12_381.Fr.t array ->
    Bls12_381.Fr.t array array ->
    int ->
    int ->
    int ->
    int = "caml_bls12_381_hash_rescue_constants_init_stubs"

  external init :
    ctxt -> Bls12_381.Fr.t -> Bls12_381.Fr.t -> Bls12_381.Fr.t -> unit
    = "caml_bls12_381_hash_rescue_init_stubs"

  external apply_perm : ctxt -> unit
    = "caml_bls12_381_hash_rescue_apply_perm_stubs"

  external get_state :
    Bls12_381.Fr.t -> Bls12_381.Fr.t -> Bls12_381.Fr.t -> ctxt -> unit
    = "caml_bls12_381_hash_rescue_get_state_stubs"
end

type ctxt = Stubs.ctxt

let constants_init ark mds =
  let ark_len = Array.length ark in
  let mds_nb_rows = Array.length mds in
  assert (mds_nb_rows > 0) ;
  let mds_nb_cols = Array.length mds.(0) in
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
