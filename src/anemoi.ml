module Stubs = struct
  type ctxt

  external anemoi_jive128_1_compress :
    Bls12_381.Fr.t -> Bls12_381.Fr.t -> Bls12_381.Fr.t -> unit
    = "caml_bls12_381_hash_anemoi_jive128_1_compress_stubs"

  external get_state : Bls12_381.Fr.t array -> ctxt -> unit
    = "caml_bls12_381_hash_anemoi_jive_get_state_stubs"

  external get_state_size : ctxt -> int
    = "caml_bls12_381_hash_anemoi_jive_get_state_size_stubs"

  external set_state : ctxt -> Bls12_381.Fr.t array -> unit
    = "caml_bls12_381_hash_anemoi_jive_set_state_stubs"

  external anemoi_apply_one_round : ctxt -> int -> unit
    = "caml_bls12_381_hash_anemoi_apply_one_round_stubs"

  external anemoi_jive_apply_permutation : ctxt -> unit
    = "caml_bls12_381_hash_anemoi_jive_apply_permutation_stubs"

  external anemoi_jive_allocate_ctxt :
    ?mds:Bls12_381.Fr.t array array ->
    ?constants:Bls12_381.Fr.t array ->
    int ->
    int ->
    ctxt = "caml_bls12_381_hash_anemoi_jive_allocate_ctxt_stubs"
end

type ctxt = Stubs.ctxt

let allocate_ctxt ?mds ?constants size nb_rounds =
  if size <= 0 then failwith "Size must be at least 1" ;
  if size > 4 && (Option.is_none mds || Option.is_none constants) then
    failwith
      "For instances with l > 4 the constants and the matrix for the linear \
       layer must be given" ;
  let ctxt = Stubs.anemoi_jive_allocate_ctxt ?mds ?constants size nb_rounds in
  ctxt

let set_state ctxt state =
  let exp_state_size = Stubs.get_state_size ctxt in
  let state_size = Array.length state in
  if state_size <> exp_state_size then
    failwith
      (Printf.sprintf
         "The given array contains %d elements but the expected state size is \
          %d"
         state_size
         exp_state_size) ;
  Stubs.set_state ctxt state

let get_state_size ctxt = Stubs.get_state_size ctxt

let get_state ctxt =
  let state_size = Stubs.get_state_size ctxt in
  let state = Array.init state_size (fun _ -> Bls12_381.Fr.(copy zero)) in
  Stubs.get_state state ctxt ;
  state

let apply_one_round ctxt idx = Stubs.anemoi_apply_one_round ctxt idx

let apply_permutation ctxt = Stubs.anemoi_jive_apply_permutation ctxt

let jive128_1_compress x y =
  let res = Bls12_381.Fr.(copy zero) in
  Stubs.anemoi_jive128_1_compress res x y ;
  res

module Parameters = struct
  let g = Bls12_381.Fr.of_string "7"

  let beta = Bls12_381.Fr.of_string "7"

  let delta =
    Bls12_381.Fr.of_string
      "14981678621464625851270783002338847382197300714436467949315331057125308909861"

  let alpha = Bls12_381.Fr.of_string "5"

  let alpha_inv =
    Bls12_381.Fr.of_string
      "20974350070050476191779096203274386335076221000211055129041463479975432473805"

  let gamma = Bls12_381.Fr.zero

  let state_size_1 =
    ( 19,
      1,
      Bls12_381.Fr.[| [| one; g |]; [| g; square g + one |] |],
      Bls12_381.Fr.
        [| of_string "39";
           of_string
             "41362478282768062297187132445775312675360473883834860695283235286481594490621";
           of_string
             "9548818195234740988996233204400874453525674173109474205108603996010297049928";
           of_string
             "25365440569177822667580105183435418073995888230868180942004497015015045856900";
           of_string
             "34023498397393406644117994167986720327178154686105264833093891093045919619309";
           of_string
             "38816051319719761886041858113129205506758421478656182868737326994635468402951";
           of_string
             "35167418087531820804128377095512663922179887277669504047069913414630376083753";
           of_string
             "25885868839756469722325652387535232478219821850603640827385444642154834700231";
           of_string
             "8867588811641202981080659274007552529205713737251862066053445622305818871963";
           of_string
             "36439756010140137556111047750162544185710881404522379792044818039722752946048";
           of_string
             "7788624504122357216765350546787885309160020166693449889975992574536033007374";
           of_string
             "3134147137704626983201116226440762775442116005053282329971088789984415999550";
           of_string
             "50252287380741824818995733304361249016282047978221591906573165442023106203143";
           of_string
             "48434698978712278012409706205559577163572452744833134361195687109159129985373";
           of_string
             "32960510617530186159512413633821386297955642598241661044178889571655571939473";
           of_string
             "12850897859166761094422335671106280470381427571695744605265713866647560628356";
           of_string
             "14578036872634298798382048587794204613583128573535557156943783762854124345644";
           of_string
             "21588109842058901916690548710649523388049643745013696896704903154857389904594";
           of_string
             "35731638686520516424752846654442973203189295883541072759390882351699754104989";
           of_string
             "14981678621464625851270783002338847382197300714436467949315331057125308909900";
           of_string
             "28253420209785428420233456008091632509255652343634529984400816700490470131093";
           of_string
             "51511939407083344002778208487678590135577660247075600880835916725469990319313";
           of_string
             "46291121544435738125248657675097664742296276807186696922340332893747842754587";
           of_string
             "3650460179273129580093806058710273018999560093475503119057680216309578390988";
           of_string
             "45802223370746268123059159806400152299867771061127345631244786118574025749328";
           of_string
             "11798621276624967315721748990709309216351696098813162382053396097866233042733";
           of_string
             "42372918959432199162670834641599336326433006968669415662488070504036922966492";
           of_string
             "52181371244193189669553521955614617990714056725501643636576377752669773323445";
           of_string
             "23791984554824031672195249524658580601428376029501889159059009332107176394097";
           of_string
             "33342520831620303764059548442834699069640109058400548818586964467754352720368";
           of_string
             "16791548253207744974576845515705461794133799104808996134617754018912057476556";
           of_string
             "11087343419860825311828133337767238110556416596687749174422888171911517001265";
           of_string
             "11931207770538477937808955037363240956790374856666237106403111503668796872571";
           of_string
             "3296943608590459582451043049934874894049468383833500962645016062634514172805";
           of_string
             "7080580976521357573320018355401935489220216583936865937104131954142364033647";
           of_string
             "25990144965911478244481527888046366474489820502460615136523859419965697796405";
           of_string
             "33907313384235729375566529911940467295099705980234607934575786561097199483218";
           of_string
             "25996950265608465541351207283024962044374873682152889814392533334239395044136"
        |] )

  let state_size_2 =
    ( 12,
      2,
      Bls12_381.Fr.[| [| one; g |]; [| g; square g + one |] |],
      Bls12_381.Fr.
        [| of_string "39";
           of_string
             "17756515227822460609684409997111995494590448775258437999344446424780281143353";
           of_string
             "41362478282768062297187132445775312675360473883834860695283235286481594490621";
           of_string
             "3384073892082712848969991795331397937188893616190315628722966662742467187281";
           of_string
             "9548818195234740988996233204400874453525674173109474205108603996010297049928";
           of_string
             "51311880822158488881090781617710146800056386303122657365679608608648067582435";
           of_string
             "25365440569177822667580105183435418073995888230868180942004497015015045856900";
           of_string
             "29347609441914902330741511702270026847909178228078752565372729158237774700914";
           of_string
             "34023498397393406644117994167986720327178154686105264833093891093045919619309";
           of_string
             "2339620320400167830454536231899316133967303509954474267430948538955691907104";
           of_string
             "38816051319719761886041858113129205506758421478656182868737326994635468402951";
           of_string
             "27338042530319738113354246208426108832239651080023276643867223794985578055610";
           of_string
             "35167418087531820804128377095512663922179887277669504047069913414630376083753";
           of_string
             "42192983528513372869128514327443204912824559545179630597589572656156258515752";
           of_string
             "25885868839756469722325652387535232478219821850603640827385444642154834700231";
           of_string
             "42721818980548514490325424436763032046927347769153393863616095871384405840432";
           of_string
             "8867588811641202981080659274007552529205713737251862066053445622305818871963";
           of_string
             "23473499332437056484066006746048591864129988909190267521144125882222313735740";
           of_string
             "36439756010140137556111047750162544185710881404522379792044818039722752946048";
           of_string
             "16497366583607480604161417644040292299204496829635795525393416854929276060989";
           of_string
             "7788624504122357216765350546787885309160020166693449889975992574536033007374";
           of_string
             "16727395967350522643500778393489915391834352737211416857240725807058479128000";
           of_string
             "3134147137704626983201116226440762775442116005053282329971088789984415999550";
           of_string
             "46525506418681456193255596516104416743523037046982280449529426136392814992763";
           of_string
             "14981678621464625851270783002338847382197300714436467949315331057125308909900";
           of_string
             "48720959343719104324739338388885839802998711550637402773896395605948383052052";
           of_string
             "28253420209785428420233456008091632509255652343634529984400816700490470131093";
           of_string
             "6257781313532096835800460747082714697295034136932481743077166200794135826591";
           of_string
             "51511939407083344002778208487678590135577660247075600880835916725469990319313";
           of_string
             "4386017178186728799761421274050927732938229436976005221436222062273391481632";
           of_string
             "46291121544435738125248657675097664742296276807186696922340332893747842754587";
           of_string
             "13820180736478645172746469075181304604729976364812127548341524461074783412926";
           of_string
             "3650460179273129580093806058710273018999560093475503119057680216309578390988";
           of_string
             "40385222771838099109662234020243831589690223478794847201235014486200724862134";
           of_string
             "45802223370746268123059159806400152299867771061127345631244786118574025749328";
           of_string
             "50306980075778262214155693291132052551559962723436936231611301042966928400825";
           of_string
             "11798621276624967315721748990709309216351696098813162382053396097866233042733";
           of_string
             "34806952212038537244506031612074847133207330427265785757809673463434908473570";
           of_string
             "42372918959432199162670834641599336326433006968669415662488070504036922966492";
           of_string
             "22755759419530071315007011572076166983660942447634027701351681157370705921018";
           of_string
             "52181371244193189669553521955614617990714056725501643636576377752669773323445";
           of_string
             "30334172084294870556875274308904688414158741457854908094300017436690480001547";
           of_string
             "23791984554824031672195249524658580601428376029501889159059009332107176394097";
           of_string
             "19832360622723392584029764807971325641132953515557801717644226271356492507876";
           of_string
             "33342520831620303764059548442834699069640109058400548818586964467754352720368";
           of_string
             "5828182614154296575131381170785760240834851189333374788484657124381010655319";
           of_string
             "16791548253207744974576845515705461794133799104808996134617754018912057476556";
           of_string
             "23729797853490401568967730686618146850735129707152853256809050789424668284094"
        |] )

  let state_size_3 =
    ( 10,
      3,
      Bls12_381.Fr.
        [| [| g + one; one; g + one |]; [| one; one; g |]; [| g; one; one |] |],
      Bls12_381.Fr.
        [| of_string "39";
           of_string
             "17756515227822460609684409997111995494590448775258437999344446424780281143353";
           of_string
             "10188916128123599964772546147951904500865009616764646948187915341627970346879";
           of_string
             "41362478282768062297187132445775312675360473883834860695283235286481594490621";
           of_string
             "3384073892082712848969991795331397937188893616190315628722966662742467187281";
           of_string
             "38536464596998108028197905645250196649287447208374169339784649587982292038621";
           of_string
             "9548818195234740988996233204400874453525674173109474205108603996010297049928";
           of_string
             "51311880822158488881090781617710146800056386303122657365679608608648067582435";
           of_string
             "24596965950552905296088269899880882549715354660832391374009234980535928382152";
           of_string
             "25365440569177822667580105183435418073995888230868180942004497015015045856900";
           of_string
             "29347609441914902330741511702270026847909178228078752565372729158237774700914";
           of_string
             "14356478667385969079309349540394948109414829921001045845599553435706989367858";
           of_string
             "34023498397393406644117994167986720327178154686105264833093891093045919619309";
           of_string
             "2339620320400167830454536231899316133967303509954474267430948538955691907104";
           of_string
             "12136748919666286297989154404429099226154686992028401568133058190732008277996";
           of_string
             "38816051319719761886041858113129205506758421478656182868737326994635468402951";
           of_string
             "27338042530319738113354246208426108832239651080023276643867223794985578055610";
           of_string
             "15580674179713644540398409523441814073810768449493940562136422009899312699155";
           of_string
             "35167418087531820804128377095512663922179887277669504047069913414630376083753";
           of_string
             "42192983528513372869128514327443204912824559545179630597589572656156258515752";
           of_string
             "47389212411441573266379092392931599970417884729397156841216318364858334633325";
           of_string
             "25885868839756469722325652387535232478219821850603640827385444642154834700231";
           of_string
             "42721818980548514490325424436763032046927347769153393863616095871384405840432";
           of_string
             "5855288403637341107158034195599277569854359593529752399086836976954392351035";
           of_string
             "8867588811641202981080659274007552529205713737251862066053445622305818871963";
           of_string
             "23473499332437056484066006746048591864129988909190267521144125882222313735740";
           of_string
             "5696063807157149622355481994320806474692190935543821893362808351446578125354";
           of_string
             "36439756010140137556111047750162544185710881404522379792044818039722752946048";
           of_string
             "16497366583607480604161417644040292299204496829635795525393416854929276060989";
           of_string
             "31479323495970113713816467604460499675889579912370034974841212556442942086146";
           of_string
             "14981678621464625851270783002338847382197300714436467949315331057125308909900";
           of_string
             "48720959343719104324739338388885839802998711550637402773896395605948383052052";
           of_string
             "11709610427641952476226704950218052763560489079301307464225164120801969364960";
           of_string
             "28253420209785428420233456008091632509255652343634529984400816700490470131093";
           of_string
             "6257781313532096835800460747082714697295034136932481743077166200794135826591";
           of_string
             "11966422202069200811427605007493817363680804416274031195624148724039857787313";
           of_string
             "51511939407083344002778208487678590135577660247075600880835916725469990319313";
           of_string
             "4386017178186728799761421274050927732938229436976005221436222062273391481632";
           of_string
             "663227665329044490605880474899933274574966982371072793854806732105730575244";
           of_string
             "46291121544435738125248657675097664742296276807186696922340332893747842754587";
           of_string
             "13820180736478645172746469075181304604729976364812127548341524461074783412926";
           of_string
             "21821175320697611197161277831984495658213397245419754392657307036488476373765";
           of_string
             "3650460179273129580093806058710273018999560093475503119057680216309578390988";
           of_string
             "40385222771838099109662234020243831589690223478794847201235014486200724862134";
           of_string
             "20738601554725926373596082603265918636164823648026470243422423735982938342408";
           of_string
             "45802223370746268123059159806400152299867771061127345631244786118574025749328";
           of_string
             "50306980075778262214155693291132052551559962723436936231611301042966928400825";
           of_string
             "9105861908793877437599087016640061747418296780065295891365798855886560153752";
           of_string
             "11798621276624967315721748990709309216351696098813162382053396097866233042733";
           of_string
             "34806952212038537244506031612074847133207330427265785757809673463434908473570";
           of_string
             "10559431278588446438155840088055546145087872298641007742921718770142881700525";
           of_string
             "42372918959432199162670834641599336326433006968669415662488070504036922966492";
           of_string
             "22755759419530071315007011572076166983660942447634027701351681157370705921018";
           of_string
             "8881354201366797207686592249590682298565723459695719800911380560885170725516";
           of_string
             "52181371244193189669553521955614617990714056725501643636576377752669773323445";
           of_string
             "30334172084294870556875274308904688414158741457854908094300017436690480001547";
           of_string
             "35548861917762862971011720475855172816698712671893796030607658203859222685056";
           of_string
             "23791984554824031672195249524658580601428376029501889159059009332107176394094";
           of_string
             "19832360622723392584029764807971325641132953515557801717644226271356492507876";
           of_string
             "5370567718707734490084045178883836972105253285449736908577321570876055642415"
        |] )
end
