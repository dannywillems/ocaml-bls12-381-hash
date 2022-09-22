module Stubs = struct
  type ctxt

  external anemoi_jive128_1_compress :
    Bls12_381.Fr.t -> Bls12_381.Fr.t -> Bls12_381.Fr.t -> unit
    = "caml_bls12_381_hash_anemoi_jive128_1_compress_stubs"

  external anemoi_jive_get_state : Bls12_381.Fr.t array -> ctxt -> unit
    = "caml_bls12_381_hash_anemoi_jive_get_state_stubs"

  external anemoi_jive_get_state_size : ctxt -> int
    = "caml_bls12_381_hash_anemoi_jive_get_state_size_stubs"

  external anemoi_jive_apply : ctxt -> unit
    = "caml_bls12_381_hash_anemoi_jive_apply_stubs"

  external anemoi_jive_allocate_ctxt :
    ?mds:Bls12_381.Fr.t array array ->
    ?constants:Bls12_381.Fr.t array ->
    int ->
    Bls12_381.Fr.t array ->
    ctxt = "caml_bls12_381_hash_anemoi_jive_allocate_ctxt_stubs"
end

type ctxt = Stubs.ctxt

let allocate_ctxt ?mds ?constants size init_values =
  if size <= 0 then failwith "Size must be at least 1" ;
  if size > 4 && (Option.is_none mds || Option.is_none constants) then
    failwith
      "For instances with l > 4 the constants and the matrix for the linear \
       layer must be given" ;
  let ctxt = Stubs.anemoi_jive_allocate_ctxt ?mds ?constants size init_values in
  ctxt

let get_state ctxt =
  let state_size = Stubs.anemoi_jive_get_state_size ctxt in
  let state = Array.init state_size (fun _ -> Bls12_381.Fr.(copy zero)) in
  Stubs.anemoi_jive_get_state state ctxt ;
  state

let apply ctxt = Stubs.anemoi_jive_apply ctxt

let jive128_1_compress x y =
  let res = Bls12_381.Fr.(copy zero) in
  Stubs.anemoi_jive128_1_compress res x y ;
  res
