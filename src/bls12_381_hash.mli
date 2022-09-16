(** Implementation of an instantiation of
    {{:https://eprint.iacr.org/2019/458.pdf} Poseidon} over the scalar field of
    BLS12-381 for a security of 128 bits and with the permutation [x^5]. The
    parameters of the instantiation are:
    - state size = 3
    - number of full rounds = 8
    - number partial rounds = 56
    - the partial rounds run the sbox on the last element of the state

    These parameters have been generated using {{:
    https://gitlab.com/dannywillems/ocaml-ec/-/tree/master/utils/poseidon-hash }
    security_parameters.ml from Mec }.

    The linear layer constants and the round keys can be generated using
    {{:
    https://gitlab.com/dannywillems/ocaml-ec/-/tree/master/utils/poseidon-hash }
    generate_ark.ml and generate_mds.sage from Mec }. The constants must be
    loaded at the top level using {!Poseidon128.constants_init}.

    {b The current implementation only provides the functions to run a
       permutation. The user is responsible to build a hash function on top of
       it. } *)
module Poseidon128 : sig
  (** Context of the permutation *)
  type ctxt

  (** [constants_init ark mds] initializes the constants for Poseidon.

      {b Warnings: }
         - The function does not verify the parameters are secured
         - This function must be called before calling {!init},
           {!apply_permutation} and {!get} *)
  val constants_init :
    Bls12_381.Fr.t array -> Bls12_381.Fr.t array array -> unit

  (** [init a b c] returns a new context with an initialised state with the
      value [[a, b, c]].
  *)
  val init : Bls12_381.Fr.t -> Bls12_381.Fr.t -> Bls12_381.Fr.t -> ctxt

  (** [apply_permutation ctxt] applies a permutation on the state. The context
      is modified. *)
  val apply_permutation : ctxt -> unit

  (** [get ctxt] returns the state of the permutation *)
  val get : ctxt -> Bls12_381.Fr.t * Bls12_381.Fr.t * Bls12_381.Fr.t
end

module Poseidon : sig
  (** Generate your own Poseidon instance *)
  module Make (Parameters : sig
    val nb_full_rounds : int

    val nb_partial_rounds : int

    val batch_size : int

    val width : int

    val ark : Bls12_381.Fr.t array

    val mds : Bls12_381.Fr.t array array
  end) : sig
    (** Context of the permutation *)
    type ctxt

    (** [init inputs] returns a new context with an initialised state with the
        value [inputs].
    *)
    val init : Bls12_381.Fr.t array -> ctxt

    (** [apply_permutation ctxt] applies a permutation on the state. The context
        is modified. *)
    val apply_permutation : ctxt -> unit

    (** [get ctxt] returns the state of the permutation *)
    val get : ctxt -> Bls12_381.Fr.t array
  end
end

(** Implementation of an instantiation of {{: https://eprint.iacr.org/2019/426 }
    Rescue } over the scalar field of BLS12-381 for a security of 128 bits and
    with the permutation [x^5]. The parameters of the instantiation are:
    - state size = 3
    - number of rounds = 14

    These parameters have been generated using {{:
    https://github.com/KULeuven-COSIC/Marvellous/blob/0969ce8a5ebaa0bf45696b44e276d3dd81d2e455/rescue_prime.sage}
    this script}.
*)
module Rescue : sig
  (** Context of the permutation *)
  type ctxt

  (** [constants_init ark mds] initializes the constants for Poseidon.

      {b Warnings: }
      - The function does not verify the parameters are secured
      - This function must be called before calling {!init},
           {!apply_permutation} and {!get} *)
  val constants_init :
    Bls12_381.Fr.t array -> Bls12_381.Fr.t array array -> unit

  (** [init a b c] returns a new context with an initialised state with the
      value [[a, b, c]].
  *)
  val init : Bls12_381.Fr.t -> Bls12_381.Fr.t -> Bls12_381.Fr.t -> ctxt

  (** [apply_permutation ctxt] applies a permutation on the state. The context
      is modified. *)
  val apply_permutation : ctxt -> unit

  (** [get ctxt] returns the state of the permutation *)
  val get : ctxt -> Bls12_381.Fr.t * Bls12_381.Fr.t * Bls12_381.Fr.t
end

(** Implementation of an instanciation of {{: https://eprint.iacr.org/2022/840}
    AnemoiJive2 } over the scalar field of BLS12-381 for a security of 128 bits.
*)
module Anemoi : sig
  type ctxt

  val allocate_ctxt : int -> Bls12_381.Fr.t array -> ctxt

  val get_state : ctxt -> Bls12_381.Fr.t array

  val apply : ctxt -> unit

  val jive128_1_compress : Bls12_381.Fr.t -> Bls12_381.Fr.t -> Bls12_381.Fr.t
end

(** Implementation of an instantiation of {{: https://eprint.iacr.org/2022/403.pdf }
    Griffin } over the scalar field of BLS12-381 for a security of 128 bits and
    with the permutation [x^5]. The parameters of the instantiation are:
    - state size = 3
    - number of rounds = 12
*)
module Griffin : sig
  (** Context of the permutation *)
  type ctxt

  (** [init a b c] returns a new context with an initialised state with the
      value [[a, b, c]].
  *)
  val init : Bls12_381.Fr.t -> Bls12_381.Fr.t -> Bls12_381.Fr.t -> ctxt

  (** [apply_permutation ctxt] applies a permutation on the state. The context
      is modified. *)
  val apply_permutation : ctxt -> unit

  (** [get ctxt] returns the state of the permutation *)
  val get : ctxt -> Bls12_381.Fr.t * Bls12_381.Fr.t * Bls12_381.Fr.t
end
