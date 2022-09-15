module Stubs = struct
  type ctxt

  external allocate_ctxt : unit -> ctxt
    = "caml_bls12_381_griffin_allocate_ctxt_stubs"

  external init :
    ctxt -> Bls12_381.Fr.t -> Bls12_381.Fr.t -> Bls12_381.Fr.t -> unit
    = "caml_bls12_381_griffin_init_ctxt_stubs"

  external apply_perm : ctxt -> unit
    = "caml_bls12_381_griffin_apply_permutation_stubs"

  external get_state :
    Bls12_381.Fr.t -> Bls12_381.Fr.t -> Bls12_381.Fr.t -> ctxt -> unit
    = "caml_bls12_381_griffin_get_state_stubs"
end

type ctxt = Stubs.ctxt

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
