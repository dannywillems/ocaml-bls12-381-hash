(* Generated using
   https://github.com/vesselinux/anemoi-hash/commit/9d9fc2a52e31c5e9379be2856414233e4e780f58
   with:
       test_jive(
           n_tests=10,
           q=52435875175126190479447740508185965837690552500527637822603658699938581184513,
           alpha=5,
           n_rounds=19,
           n_cols=1,
           b=2,
           security_level=128)
*)

let test_vectors_jive128_1 () =
  let vectors =
    [ ( ( "35845669682800269995209049467553751861599775089532198376674489477778357560569",
          "28310433413288793552092391706285055875131165883761155923425672020460794794380"
        ),
        "17700999234906509130159287769741962009709982288860491609792036961305502635098"
      );
      ( ( "13880477308466057091493501926554391163288910083198657398974047674796581779693",
          "28373522553669637689090633983852091038187643792080489433228018701827926002768"
        ),
        "12743339877423634016102198261148085947154915493891480470390198918335851344292"
      );
      ( ( "38216845839357573472239023564373200263918534132389374505946789120458119648667",
          "39487400661842934211797098190376905462917596530484823725006452014098066670694"
        ),
        "20572002340893814224552312721780888755123139461240945499350006876769919946773"
      );
      ( ( "31131499311453094268713009639057190648340672035944963596113874024605484784791",
          "43680468547604090714590688733926978605538499294774749079842255618079617105051"
        ),
        "20569340066597303483907565303221880873948750088343130268109858923675035314078"
      );
      ( ( "10924450358499789254279737793602938412226831772739559590509902641736698048741",
          "18748800755846695314043868352493820136560550891447333332696158632417495012819"
        ),
        "26749108456690136523602417383379636205348260403407066884482315588658233098940"
      );
      ( ( "46462878845927326448614772124701161417983809741866268465266076023457688715870",
          "38375603405434266869135117417290149314037130980580543700755400748014512343979"
        ),
        "2673364003345693113273421176038865068057650274048787980068125230806361632850"
      );
      ( ( "39170732922513369978795230271067076371378632409257775938940964299534787717175",
          "2408517610992178001486942104041564424468943886715588829396035415376300986469"
        ),
        "13310229620063667311431399083462393119055434191991960510670894258662703203975"
      ) ]
  in
  List.iter
    (fun ((x1_s, x2_s), exp_res_s) ->
      let x1 = Bls12_381.Fr.of_string x1_s in
      let x2 = Bls12_381.Fr.of_string x2_s in
      let exp_res = Bls12_381.Fr.of_string exp_res_s in
      let res = Bls12_381_hash.Anemoi.jive128_1_compress x1 x2 in
      if not (Bls12_381.Fr.eq res exp_res) then
        Alcotest.failf
          "Expected result = %s, computed result = %s, input = (%s, %s)"
          exp_res_s
          (Bls12_381.Fr.to_string res)
          x1_s
          x2_s)
    vectors

let test_vectors_jive128_2 () =
  let vectors =
    [ ( ("0", "0", "0", "0"),
        ( "23506137766702864106501714498337645198425779982503345533323642665774237530743",
          "34447732706544914382845425456929395985238811287211171548953979792382042373740",
          "38305963246199256223939132687221377996807495295070124114622442403207046030062",
          "52085062252809860097055957733590114937197370490476211931083350477393806117621"
        ) );
      ( ( "27839080182556610705887939966818701340864145322792715287810357208440914854281",
          "41481150764080331637382663225726959872938887013456865948198868284552242708519",
          "38189883379737770191491270513853770942621403161576272820058113505808823630900",
          "6529435419442382849730797362349015216552820358285062739653681825023447217068"
        ),
        ( "14473897802199918953583228273316340143396476374899351470678632558263678699877",
          "24587633048074155346278630990352810495608304969367523541545168873834143089902",
          "47132715740050880437392890948798686584816384888633241850565214056840729624505",
          "6606493401694644772471916676579866387417408500033435451518189487740033865747"
        ) );
      ( ( "14716987267992449080941609095284865759356382937671116288486258350642247071627",
          "13760197033165110695402422952291893734496635277111384162422733902296757710874",
          "33294609204786805322854530266028003773787556848644980529869834547261241614105",
          "11644531352096195394853594279658462131209985215175335801365205433425048456350"
        ),
        ( "47737136264857950730454747976524405656326494304978652844311111261281852476501",
          "13716019695701301324018899979909121742372906083132069510290774177616830373506",
          "19515279450582255760487675881545023135485186764178376441852639052497885578212",
          "45847068138243304073707520982719523479147863491193499975734034993479294600685"
        ) );
      ( ( "42824693565443175259806687802757821151773600948730449896541161263256961486645",
          "31633466755115991202264118192133521021227289162761994770025404887100313415161",
          "43223036947018592502360048383150256123208669504194939523196078411285214762463",
          "7192257416851768692824129030440632757292330835871601049965097914082460916711"
        ),
        ( "38660702903297582610177132699877133632374538437943056324961513888350888194086",
          "31630694424006989989717484628399682914962426161626133340250479990037519265561",
          "13466503268904584668912085977052425437912732123809722793173012874164204852136",
          "4471437305484391530147684290538853431954907851628258053432383018741801157611"
        ) ) ]
  in

  List.iter
    (fun ( (x1_s, x2_s, y1_s, y2_s),
           (exp_res_x1_s, exp_res_x2_s, exp_res_y1_s, exp_res_y2_s) ) ->
      let l = 2 in
      let mds = Anemoi_jive_parameters.Jive2_128.mds in
      let constants = Anemoi_jive_parameters.Jive2_128.constants in
      let x1 = Bls12_381.Fr.of_string x1_s in
      let x2 = Bls12_381.Fr.of_string x2_s in
      let y1 = Bls12_381.Fr.of_string y1_s in
      let y2 = Bls12_381.Fr.of_string y2_s in
      let exp_res_x1 = Bls12_381.Fr.of_string exp_res_x1_s in
      let exp_res_x2 = Bls12_381.Fr.of_string exp_res_x2_s in
      let exp_res_y1 = Bls12_381.Fr.of_string exp_res_y1_s in
      let exp_res_y2 = Bls12_381.Fr.of_string exp_res_y2_s in
      let state = [| x1; x2; y1; y2 |] in
      let ctxt = Bls12_381_hash.Anemoi.allocate_ctxt ~mds ~constants l state in
      let () = Bls12_381_hash.Anemoi.apply ctxt in
      let output = Bls12_381_hash.Anemoi.get_state ctxt in
      let res_x1, res_x2, res_y1, res_y2 =
        (output.(0), output.(1), output.(2), output.(3))
      in
      let res_x1_s = Bls12_381.Fr.to_string res_x1 in
      let res_x2_s = Bls12_381.Fr.to_string res_x2 in
      let res_y1_s = Bls12_381.Fr.to_string res_y1 in
      let res_y2_s = Bls12_381.Fr.to_string res_y2 in
      let is_eq =
        Bls12_381.Fr.eq res_x1 exp_res_x1
        && Bls12_381.Fr.eq res_x2 exp_res_x2
        && Bls12_381.Fr.eq res_y1 exp_res_y1
        && Bls12_381.Fr.eq res_y2 exp_res_y2
      in
      if not is_eq then
        Alcotest.failf
          "Expected result = (%s, %s, %s, %s), computed result = (%s, %s, %s, \
           %s), input = (%s, %s, %s, %s)"
          exp_res_x1_s
          exp_res_x2_s
          exp_res_y1_s
          exp_res_y2_s
          res_x1_s
          res_x2_s
          res_y1_s
          res_y2_s
          x1_s
          x2_s
          y1_s
          y2_s)
    vectors

let test_vectors_jive128_3 () =
  let vectors =
    [ ( ("0", "0", "0", "0", "0", "0"),
        ( "20909190640978318820754653943637110067589269511360244120926140908021057709055",
          "1262244985777960225772116378685571242525047727491279127699243019467805385509",
          "10679869636172455590079813722013211491089004999370065495549728074809788605944",
          "8749645122094303358335363038858853071626167104585108913987538278602503610799",
          "52007547220060515746130897941754232540114517049831277946563599596735294791399",
          "21997299975800870623894877065476422740678798492930965827230754578369475793755"
        ) );
      ( ( "21136474194040113792174465398286200459307013289903150844748699441096918110453",
          "32311674671157338670155387113314352786330151951613611077779532937275746532573",
          "36907604963707620104484152940194193954527137692003736967769402395386527512984",
          "14450537571207904729704807723815776656250878535066332616139075926886254481777",
          "43855393420079240422094489433139137243503374848222874348805567020930351485289",
          "43968773581630068862849167147864019524343932415571883595371961173062975522853"
        ),
        ( "20428981203531118097792753024850577917959458191045146810147625927405425584748",
          "40757560821015044989448786836566051331657207528433101745485901277429218183512",
          "9872670287540083498314068388207263880072949656266190226644832722513867641138",
          "49587650730408969534511072929573805032099840356060565771562953228604522293329",
          "28627813698945618577653588235963171906585265713606451589459551486380903409385",
          "8122614435256950535141273133419063807993283425497178326939819062309319919466"
        ) );
      ( ( "15654622252613338074128918540369897825360063228974669723896745947100899361407",
          "31755913315499079970616479415893865876591903898341787075464645507535517644221",
          "27662450470772484569675626672637611943890527684807416052178483665736033759269",
          "32025061876362078998899045113417405366620239129931450012415159044257543771802",
          "5219000108433380121487496827301004842576073360890815169054208427399490382118",
          "21525107422629831898444296451796788212786763679216214351377736651406413438673"
        ),
        ( "6269929392436953490656289301182695970614977734678479986645988820440154759467",
          "10921177898574107371511644586005055406964295648347224403417732697434347083006",
          "6685446978561180698809388502949939344610466443347180814929964200419415308603",
          "29034254924558221375238486723752416435570264944366953578975264022999858640222",
          "28563114633841558239548204509907115015971046251147185565633527031667505106276",
          "24553115087874415652083053078337475169320197223414502343732044293927815240608"
        ) ) ]
  in

  List.iter
    (fun ( (x1_s, x2_s, x3_s, y1_s, y2_s, y3_s),
           ( exp_res_x1_s,
             exp_res_x2_s,
             exp_res_x3_s,
             exp_res_y1_s,
             exp_res_y2_s,
             exp_res_y3_s ) ) ->
      let l = 3 in
      let constants = Anemoi_jive_parameters.Jive3_128.constants in
      let mds = Anemoi_jive_parameters.Jive3_128.mds in
      let x1 = Bls12_381.Fr.of_string x1_s in
      let x2 = Bls12_381.Fr.of_string x2_s in
      let x3 = Bls12_381.Fr.of_string x3_s in
      let y1 = Bls12_381.Fr.of_string y1_s in
      let y2 = Bls12_381.Fr.of_string y2_s in
      let y3 = Bls12_381.Fr.of_string y3_s in
      let exp_res_x1 = Bls12_381.Fr.of_string exp_res_x1_s in
      let exp_res_x2 = Bls12_381.Fr.of_string exp_res_x2_s in
      let exp_res_x3 = Bls12_381.Fr.of_string exp_res_x3_s in
      let exp_res_y1 = Bls12_381.Fr.of_string exp_res_y1_s in
      let exp_res_y2 = Bls12_381.Fr.of_string exp_res_y2_s in
      let exp_res_y3 = Bls12_381.Fr.of_string exp_res_y3_s in
      let state = [| x1; x2; x3; y1; y2; y3 |] in
      let ctxt = Bls12_381_hash.Anemoi.allocate_ctxt ~mds ~constants l state in
      let () = Bls12_381_hash.Anemoi.apply ctxt in
      let output = Bls12_381_hash.Anemoi.get_state ctxt in
      let res_x1, res_x2, res_x3, res_y1, res_y2, res_y3 =
        (output.(0), output.(1), output.(2), output.(3), output.(4), output.(5))
      in
      let res_x1_s = Bls12_381.Fr.to_string res_x1 in
      let res_x2_s = Bls12_381.Fr.to_string res_x2 in
      let res_x3_s = Bls12_381.Fr.to_string res_x3 in
      let res_y1_s = Bls12_381.Fr.to_string res_y1 in
      let res_y2_s = Bls12_381.Fr.to_string res_y2 in
      let res_y3_s = Bls12_381.Fr.to_string res_y3 in
      let is_eq =
        Bls12_381.Fr.eq res_x1 exp_res_x1
        && Bls12_381.Fr.eq res_x2 exp_res_x2
        && Bls12_381.Fr.eq res_x3 exp_res_x3
        && Bls12_381.Fr.eq res_y1 exp_res_y1
        && Bls12_381.Fr.eq res_y2 exp_res_y2
        && Bls12_381.Fr.eq res_y3 exp_res_y3
      in
      if not is_eq then
        Alcotest.failf
          "Expected result = (%s, %s, %s, %s, %s, %s), computed result = (%s, \
           %s, %s, %s, %s, %s), input = (%s, %s, %s, %s, %s, %s)"
          exp_res_x1_s
          exp_res_x2_s
          exp_res_x3_s
          exp_res_y1_s
          exp_res_y2_s
          exp_res_y3_s
          res_x1_s
          res_x2_s
          res_x3_s
          res_y1_s
          res_y2_s
          res_y3_s
          x1_s
          x2_s
          x3_s
          y1_s
          y2_s
          y3_s)
    vectors

let test_vectors_jive128_4 () =
  let vectors =
    [ ( ("0", "0", "0", "0", "0", "0", "0", "0"),
        ( "20058366947742027461261618053378486897639165785263468047794626116830259214929",
          "3006530361801509761803565054177969548426284732824647555577346524284019810273",
          "39978152086459459913929936073499443510474497827320187307674983143812044272930",
          "4895666656380827889572108138173239080130380149736559292021613130458381719055",
          "16846871674127449893991780290122986523839084467768029039775935673789966991114",
          "1865764240623238114365321595564222339828258066912403716100532136924909750491",
          "28286625493572404257902925017723700828588002224405595494780300921501891705465",
          "19209453401074378098932473108206183579121797186137438752451926263449203411777"
        ) ) ]
  in

  List.iter
    (fun ( (x1_s, x2_s, x3_s, x4_s, y1_s, y2_s, y3_s, y4_s),
           ( exp_res_x1_s,
             exp_res_x2_s,
             exp_res_x3_s,
             exp_res_x4_s,
             exp_res_y1_s,
             exp_res_y2_s,
             exp_res_y3_s,
             exp_res_y4_s ) ) ->
      let l = 4 in
      let x1 = Bls12_381.Fr.of_string x1_s in
      let x2 = Bls12_381.Fr.of_string x2_s in
      let x3 = Bls12_381.Fr.of_string x3_s in
      let x4 = Bls12_381.Fr.of_string x4_s in
      let y1 = Bls12_381.Fr.of_string y1_s in
      let y2 = Bls12_381.Fr.of_string y2_s in
      let y3 = Bls12_381.Fr.of_string y3_s in
      let y4 = Bls12_381.Fr.of_string y4_s in
      let exp_res_x1 = Bls12_381.Fr.of_string exp_res_x1_s in
      let exp_res_x2 = Bls12_381.Fr.of_string exp_res_x2_s in
      let exp_res_x3 = Bls12_381.Fr.of_string exp_res_x3_s in
      let exp_res_x4 = Bls12_381.Fr.of_string exp_res_x4_s in
      let exp_res_y1 = Bls12_381.Fr.of_string exp_res_y1_s in
      let exp_res_y2 = Bls12_381.Fr.of_string exp_res_y2_s in
      let exp_res_y3 = Bls12_381.Fr.of_string exp_res_y3_s in
      let exp_res_y4 = Bls12_381.Fr.of_string exp_res_y4_s in
      let state = [| x1; x2; x3; x4; y1; y2; y3; y4 |] in
      let ctxt = Bls12_381_hash.Anemoi.allocate_ctxt l state in
      let () = Bls12_381_hash.Anemoi.apply ctxt in
      let output = Bls12_381_hash.Anemoi.get_state ctxt in
      let res_x1, res_x2, res_x3, res_x4, res_y1, res_y2, res_y3, res_y4 =
        ( output.(0),
          output.(1),
          output.(2),
          output.(3),
          output.(4),
          output.(5),
          output.(6),
          output.(7) )
      in
      let res_x1_s = Bls12_381.Fr.to_string res_x1 in
      let res_x2_s = Bls12_381.Fr.to_string res_x2 in
      let res_x3_s = Bls12_381.Fr.to_string res_x3 in
      let res_x4_s = Bls12_381.Fr.to_string res_x4 in
      let res_y1_s = Bls12_381.Fr.to_string res_y1 in
      let res_y2_s = Bls12_381.Fr.to_string res_y2 in
      let res_y3_s = Bls12_381.Fr.to_string res_y3 in
      let res_y4_s = Bls12_381.Fr.to_string res_y4 in
      let is_eq =
        Bls12_381.Fr.eq res_x1 exp_res_x1
        && Bls12_381.Fr.eq res_x2 exp_res_x2
        && Bls12_381.Fr.eq res_x3 exp_res_x3
        && Bls12_381.Fr.eq res_x4 exp_res_x4
        && Bls12_381.Fr.eq res_y1 exp_res_y1
        && Bls12_381.Fr.eq res_y2 exp_res_y2
        && Bls12_381.Fr.eq res_y3 exp_res_y3
        && Bls12_381.Fr.eq res_y4 exp_res_y4
      in
      if not is_eq then
        Alcotest.failf
          "Expected result = (%s, %s, %s, %s, %s, %s, %s, %s), computed result \
           = (%s, %s, %s, %s, %s, %s, %s, %s), input = (%s, %s, %s, %s, %s, \
           %s, %s, %s)"
          exp_res_x1_s
          exp_res_x2_s
          exp_res_x3_s
          exp_res_x4_s
          exp_res_y1_s
          exp_res_y2_s
          exp_res_y3_s
          exp_res_y4_s
          res_x1_s
          res_x2_s
          res_x3_s
          res_x4_s
          res_y1_s
          res_y2_s
          res_y3_s
          res_y4_s
          x1_s
          x2_s
          x3_s
          x4_s
          y1_s
          y2_s
          y3_s
          y4_s)
    vectors

let test_state_functions () =
  let l = 1 + Random.int 10 in
  let mds =
    Array.init l (fun _ -> Array.init l (fun _ -> Bls12_381.Fr.random ()))
  in
  let nb_rounds = if l = 1 then 19 else if l = 2 then 12 else 10 in
  let constants =
    Array.init (2 * l * nb_rounds) (fun _ -> Bls12_381.Fr.random ())
  in
  let state_size = 2 * l in
  let state = Array.init state_size (fun _ -> Bls12_381.Fr.random ()) in
  let ctxt = Bls12_381_hash.Anemoi.allocate_ctxt ~mds ~constants l state in
  let output = Bls12_381_hash.Anemoi.get_state ctxt in
  assert (Array.for_all2 Bls12_381.Fr.eq state output)

let test_anemoi_generic_with_l_one_is_anemoi_jive128_1_compress () =
  let l = 1 in
  let state_size = 2 * l in
  let state = Array.init state_size (fun _ -> Bls12_381.Fr.random ()) in
  let ctxt = Bls12_381_hash.Anemoi.allocate_ctxt l state in
  let () = Bls12_381_hash.Anemoi.apply ctxt in
  let output = Bls12_381_hash.Anemoi.get_state ctxt in
  assert (
    Bls12_381.Fr.eq
      (Bls12_381_hash.Anemoi.jive128_1_compress state.(0) state.(1))
      Bls12_381.Fr.(state.(0) + state.(1) + output.(0) + output.(1)))

let () =
  let open Alcotest in
  run
    "Anemoi"
    [ ( "Jive128_1",
        [ test_case
            "Tests vectors from reference implementation"
            `Quick
            test_vectors_jive128_1 ] );
      ( "Generic instantiations",
        [ test_case
            "l = 1 <==> jive128_1_compress"
            `Quick
            test_anemoi_generic_with_l_one_is_anemoi_jive128_1_compress;
          test_case
            "l = 2 -> tests vectors from reference implementation"
            `Quick
            test_vectors_jive128_2;
          (* test_case *)
          (*   "l = 4 -> tests vectors from reference implementation" *)
          (*   `Quick *)
          (*   test_vectors_jive128_4; *)
          test_case
            "l = 3 -> tests vectors from reference implementation"
            `Quick
            test_vectors_jive128_3 ] );
      ( "Additional functions",
        [ test_case
            "State initialisation and get state"
            `Quick
            test_state_functions ] ) ]
