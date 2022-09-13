let test_vectors () =
  (* Generated from https://extgit.iaik.tugraz.at/krypto/zkfriendlyhashzoo *)
  let vectors =
    [ ( ( "18463500124224312515875567238728244985257614546546778836630989065496961733332",
          "46981865534249059754749826182943352598004016487267289209329045182268251827732",
          "281220935108567092124864882450372048777669128036755944610462739083424420854"
        ),
        ( "312967684503808125264008501181907359079558761116291453411613667947766899516",
          "45085022860794304016331869598892373488807386198128958652149726446059364221856",
          "3143235844449445682654083063998365970447678809821256700746892060010723945844"
        ) );
      ( ( "37430619512013660924725326078209379186383782215505557594723583515547878680657",
          "15993191006246128054961715163349476792514546237817331760637228653648805884929",
          "586854312443779697715508748423011917816841144091125416169048666119872372790"
        ),
        ( "17795078392989753588187047645247938619792251973934963507233142728921502730375",
          "23947216748739774482602221821766081757111537527154723423518134779107549197638",
          "10733328928829291297000046981966971033540811270220965825105168354718419883281"
        ) ) ]
  in
  List.iter
    (fun ((x1_s, x2_s, x3_s), (exp_res1_s, exp_res2_s, exp_res3_s)) ->
      let x1 = Bls12_381.Fr.of_string x1_s in
      let x2 = Bls12_381.Fr.of_string x2_s in
      let x3 = Bls12_381.Fr.of_string x3_s in
      let exp_res1 = Bls12_381.Fr.of_string exp_res1_s in
      let exp_res2 = Bls12_381.Fr.of_string exp_res2_s in
      let exp_res3 = Bls12_381.Fr.of_string exp_res3_s in
      let ctxt = Bls12_381_hash.Griffin.init x1 x2 x3 in
      let () = Bls12_381_hash.Griffin.apply_permutation ctxt in
      let res1, res2, res3 = Bls12_381_hash.Griffin.get ctxt in
      let b =
        Bls12_381.Fr.eq exp_res1 res1
        && Bls12_381.Fr.eq exp_res2 res2
        && Bls12_381.Fr.eq exp_res3 res3
      in
      if not b then
        Alcotest.failf
          "Expected result = (%s, %s, %s), computed result = (%s, %s, %s), \
           input = (%s, %s, %s)"
          exp_res1_s
          exp_res2_s
          exp_res3_s
          (Bls12_381.Fr.to_string res1)
          (Bls12_381.Fr.to_string res2)
          (Bls12_381.Fr.to_string res3)
          x1_s
          x2_s
          x3_s)
    vectors

let () =
  let open Alcotest in
  run
    "Griffin"
    [ ( "Test vectors",
        [test_case "from reference implementation" `Quick test_vectors] ) ]
