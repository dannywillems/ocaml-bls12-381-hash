module Stubs = struct
  external anemoi_jive128_1_compress :
    Bls12_381.Fr.t -> Bls12_381.Fr.t -> Bls12_381.Fr.t -> unit
    = "caml_bls12_381_hash_anemoi_jive128_1_compress_stubs"
end

let jive128_1_compress x y =
  let res = Bls12_381.Fr.(copy zero) in
  Stubs.anemoi_jive128_1_compress res x y ;
  res
