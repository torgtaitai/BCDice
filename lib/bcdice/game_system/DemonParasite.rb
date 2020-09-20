# frozen_string_literal: true

module BCDice
  module GameSystem
    class DemonParasite < Base
      # ゲームシステムの識別子
      ID = 'DemonParasite'

      # ゲームシステム名
      NAME = 'デモンパラサイト'

      # ゲームシステム名の読みがな
      SORT_KEY = 'てもんはらさいと'

      # ダイスボットの使い方
      HELP_MESSAGE = <<~INFO_MESSAGE_TEXT
        ・衝動表　(URGEx)
        　"URGE衝動レベル"の形で指定します。
        　衝動表に従って自動でダイスロールを行い、結果を表示します。
        　ダイスロールと同様に、他のプレイヤーに隠れてロールすることも可能です。
        　頭に識別文字を追加して、デフォルト以外の衝動表もロールできます。
        　・NURGEx　頭に「N」を付けると「新衝動表」。
        　・AURGEx　頭に「A」を付けると「誤作動表」。
        　・MURGEx　頭に「M」を付けると「ミュータント衝動表」になります。
        　・UURGEx　頭に「U」が付くと鬼御魂の戦闘外衝動表。
        　・CURGEx　頭に「C」で鬼御魂の戦闘中衝動表になります。
        例）URGE1　　　urge5　　　Surge2
        ・D66ダイスあり
      INFO_MESSAGE_TEXT

      register_prefix(['[NAMUC]?URGE\d+'])

      def initialize(command)
        super(command)

        @sort_add_dice = true
        @enabled_d66 = true
        @d66_sort_type = D66SortType::NO_SORT
      end

      # ゲーム別成功度判定(nD6)
      def check_nD6(total, _dice_total, dice_list, cmp_op, target)
        if dice_list.count(1) >= 2 # １の目が２個以上ならファンブル
          return " ＞ 致命的失敗"
        elsif dice_list.count(6) >= 2 # ６の目が２個以上あったらクリティカル
          return " ＞ 効果的成功"
        elsif target == "?"
          return ''
        end

        if [:>=, :>].include?(cmp_op)
          if total.send(cmp_op, target)
            " ＞ 成功"
          else
            " ＞ 失敗"
          end
        end
      end

      def eval_game_system_specific_command(command)
        return get_urge(command)
      end

      # 衝動表
      def get_urge(string)
        m = /([NAMUC])?URGE\s*(\d+)/i.match(string)
        unless m
          return '1'
        end

        initialWord = m[1]
        urgelv = m[2].to_i

        case initialWord
        when nil
          title = "衝動表"
          urge = URGE_TABLE
        when "N"
          title = "新衝動表"
          urge = NEW_URGE_TABLE
        when "A"
          title = "誤作動表"
          urge = MALFUNCTION_TABLE
        when "M"
          title = "ミュータント衝動表"
          urge = MUTANT_TABLE
        when "U"
          title = "鬼御魂(戦闘外)衝動表"
          urge = ONIMITAMA_OUT_OF_BATTLE_TABLE
        when "C"
          title = "鬼御魂(戦闘中)衝動表"
          urge = ONIMITAMA_BATTLE_TABLE
        else
          # あり得ない文字
          return '1'
        end

        if urgelv < 1 || urgelv > 5
          return '衝動段階は1から5です'
        end

        dice_now = @randomizer.roll_sum(2, 6)

        resultText = urge[urgelv - 1][dice_now - 2]

        return "#{title}#{urgelv}-#{dice_now}:#{resultText}"
      end

      # 衝動表
      URGE_TABLE = [
        [
          '『怒り』突然強い怒りに駆られる。近くの対象に(非暴力の)怒りを全力でぶつける。このターンの終了まで「行動不能」となる。[経験値20点]',
          '『絶叫』寄生生物が体内で蠢く。その恐怖に絶叫。このターンの終了まで「行動不能」となる。[経験値10点]',
          '『悲哀』急に悲しいことを思い出して動きが止まる。このターンの終了まで「行動不能」となる。[経験値10点]',
          '『微笑』可笑しくてしょうがない。くすくす笑いが止まらず、このターンの終了まで「行動不能」となる。[経験値10点]',
          '『鈍感』衝動に気が付かなかった。何も起こらない。[経験値0点]',
          '『抑制』衝動を抑え込んだ。何も起こらない。[経験値0点]',
          '『我慢』衝動を我慢した。何も起こらない。[経験値0点]',
          '『前兆』悪魔的特徴が一瞬目立つ。１ターン(10秒)持続。変身中なら影響なし。[経験値10点]',
          '『発現』悪魔的特徴が急に目立つ。60ターン(10分)持続。変身中なら影響なし。[経験値10点]',
          '『変化』利き腕/前脚が２ターン(20秒)かけて悪魔化する。18ターン(3分)持続。変身中なら影響なし。[経験値20点]',
          '『顕現』利き腕/前脚が瞬時に悪魔化。60ターン(10分)持続。変身中なら影響なし。[経験値20点]',
        ],
        [
          '『茫然』思考が止まり、このターンの終了まで「攻撃」行動を行えない。回避行動に影響はない。[経験値20点]',
          '『激怒』側にいるもの(生物、物体問わず)が憎く、殴る。変身後ならば次のターンの終了まで、すべての命中判定+5、回避判定-5。[経験値20点]',
          '『残忍』殺意、破壊衝動が一瞬増す。戦闘中ならば次のターンに行われる「攻撃」行動の達成値に+5。[経験値20点]',
          '『落涙』過去の悲しい想い出が去来し、涙が溢れる。１ターン(10秒)「通常」行動を行えない。回避行動に影響はない。[経験値10点]',
          '『抑制』衝動を抑え込んだ。何も起こらない。[経験値0点]',
          '『我慢』衝動を我慢した。何も起こらない。[経験値0点]',
          '『忍耐』肉体を傷つけて衝動に耐えた。５ダメージ。[経験値10点]',
          '『辛抱』ほんの一瞬、全身が変身しかかる。無理に抑えたので、５ダメージ。変身中なら影響なし。[経験値10点]',
          '『異貌』３ターン(30秒)かけて顔が変身する。18ターン(3分)持続。変身中なら影響なし。[経験値20点]',
          '『苦痛』寄生生物が体内で暴れ、痛みにのけぞる。10ダメージ。[経験値20点]',
          '『変貌』変身後の(特異な)外見的特徴が３ターン(30秒)かけて現れる。18ターン(3分)持続。変身中なら影響なし。[経験値20点]',
        ],
        [
          '『憤怒』怒りに全身が満たされる。次のターンの終了まで、すべてのダメージのサイコロを+1個する。[経験値20点]',
          '『加速』ほとばしる衝動により。次のターンは【行動値】が２倍になる。[経験値20点]',
          '『発露』力が溢れ出る。次のターンの終了まで、すべてのダメージに+5、防御点-5(最低0)される。[経験値20点]',
          '『乾き』攻撃衝動を抑えられない。次のターンの終了まで全ての命中判定+5、回避判定-5。[経験値10点]',
          '『絶叫』あらん限りの声で叫ぶ。このターンの終了まで、全ての回避判定に-10。[経験値10点]',
          '『我慢』衝動を我慢した。何も起こらない。[経験値0点]',
          '『限界』衝動を無理矢理抑え込む。あちこちの血管が破裂し、10ダメージ。[経験値10点]',
          '『解放』衝動に耐えられず変身が始まる。３ターン(30秒)かけて変身。変身中なら影響なし。[経験値10点]',
          '『本能』衝動に駆られ、瞬時に変身。次のターン、目の前の動くものを敵味方区別無く攻撃する。[経験値20点]',
          '『保身』次のターンの終了まで、敵を攻撃できない。全ての防御力に+5。[経験値20点]',
          '『救済』悪魔寄生体が危機を察知し、【エナジー】を20点回復する。[経験値20点]',
        ],
        [
          '『癒し』衝動を１点使った回復を行う。[経験値20点]',
          '『離脱』その場から逃げ出す。逃げられない場合は、うずくまって動けなくなる。１ターン(10秒)経過すれば我に返る。[経験値20点]',
          '『脱力』急に力が抜ける。次のターンの終了まで、全ての判定に-5される。[経験値20点]',
          '『全力』激しい躁状態。次のターンの終了まで、命中判定に+10、回避判定に-10[経験値20点]',
          '『混沌』意味のある言葉を話せなくなる。１時間持続する。[経験値10点]',
          '『限界』衝動を無理矢理抑え込む。あちこちの血管が破裂し、10ダメージ。[経験値10点]',
          '『本能』衝動に駆られ、瞬時に変身。次のターン、目の前の動くものを敵味方区別無く攻撃する。[経験値20点]',
          '『焦燥』焦りから「転倒」する。[経験値20点]',
          '『猜疑』味方が急に敵に思える。即座に近くの味方に一回攻撃し、自動命中となる。いなければ影響なし。[経験値20点]',
          '『自虐』自分が許せない。自分へ攻撃(自動命中。ダメージは通常)。[経験値20点]',
          '『自浄』少し我に返る。衝動が２点回復する。[経験値20点]',
        ],
        [
          '『絶望』自殺を試みる。変身中ならば最強の攻撃(特殊能力等を使用しての攻撃)を自分へ与える。[経験値30点]',
          '『賛美』敵(複数いる場合はリーダー格)を主と思いこむ。主が倒されるか、このターンの終了まで主の命令を聞く。[経験値30点]',
          '『拒絶』変身が解除される。変身していなければ影響なし。[経験値20点]',
          '『飢餓』近くの無防備な対象を喰らおうとする。邪魔する物は敵として攻撃する。次ターンの終了時に我に返る。[経験値20点]',
          '『暗闇』視神経に影響が出る。以後１日「暗闇」になる。[経験値20点]',
          '『混乱』意味のある言葉を話せなくなる。１時間持続する。[経験値20点]',
          '『嫉妬』仲間に猛烈な嫉妬を覚える。即座に一番近くの味方を攻撃。判定は自動的に効果的成功となる。いなければ影響なし。[経験値20点]',
          '『暴君』自分が最強に思えてしかたがない。60ターン(10分)攻撃判定の達成値に+10、回避判定の達成値は-10。[経験値20点]',
          '『無双』全力だが無防備。60ターン(10分)、全てのダメージに+10、防御点0、【行動値】0。[経験値20点]',
          '『定着』変身していなければ、即座に変身。肉体が変身に馴染んでしまう。24時間、変身が解除されなくなる。[経験値30点]',
          '『眠り』猛烈な睡魔に襲われる。60ターン(10分)、もしくは戦闘終了まで起こしても起きない。[経験値30点]',
        ]
      ].freeze

      # 新衝動表
      NEW_URGE_TABLE = [
        [
          '『開眼』潜在能力が発揮される。10分間、あらゆる戦闘以外の判定に+5。',
          '『集中』感覚が研ぎ澄まされる。次のターンの終了まで、射撃の命中判定に+5。',
          '『迅速』運動神経が上昇する。20分間、戦闘以外の【機敏】判定に+5。',
          '『怪力』怪力を発揮する。20分間、戦闘以外の【肉体】判定に+5。',
          '『鈍感』衝動に気が付かない。何も起こらない。',
          '『抑制』衝動を抑え込む。何も起こらない。',
          '『我慢』衝動を我慢する。何も起こらない。',
          '『無心』冷静になる。20分間、戦闘以外の【精神】判定に+5。',
          '『解放』感覚が解放される。20分間、戦闘以外の【感覚】判定に+5。',
          '『攻撃』攻撃の姿勢を取る。次のターンの終了まで、すべてのダメージが+5。',
          '『防御』防御の姿勢を取る。このターンの終了まで、すべての防御力が+5。',
        ],
        [
          '『敵視』激しい攻撃本能に駆られる。次のターンの終了まで、肉弾ダメージ+10。',
          '『忘我』怒りに痛みを忘れる。エナジー5点回復。',
          '『閃き』頭が冴える。20分間、戦闘以外の【知力】判定に+5。',
          '『全力』筋肉のリミッターが一時的にはずれる。次のターンの終了まで、肉弾ダメージに+5。',
          '『抑制』衝動を抑え込む。何も起こらない。',
          '『我慢』衝動を我慢する。何も起こらない。',
          '『反射』反射神経が研ぎ澄まされる。次のターンの終了まで、射撃の回避判定に+5。',
          '『機転』わずかなチャンスを見逃さなくなる。20分間、戦闘以外の【幸運】判定に+5。',
          '『耐性』精神力が上昇する。次のターンの終了まで、特殊防御力+5。',
          '『怒り』敵に対する怒りにとらわれる。次のターンの終了まで、肉弾の命中判定に+10。',
          '『活発』明るく活発になる。戦闘終了まで【行動値】+5。',
        ],
        [
          '『漲り』体の奥底から力がみなぎってくる。エナジー10点回復。',
          '『分析』相手の動きを冷静に分析できるようになる。5ターンの間、射撃ダメージに+10。',
          '『慈愛』万人に対して慈愛を感じるようになる。5ターンの間、回復に振るダイスが+1d。',
          '『慎重』敵の攻撃に慎重になる。次のターンの終了まで、すべての回避判定に+5。',
          '『本能』攻撃本能がむき出しになる。5ターンの間、特殊の命中判定に+5。',
          '『性急』気が早くなる。次のターンの終了まで、【行動値】に+3',
          '『凶暴』イライラが止まらなくなる。5ターンの間、肉弾の命中判定に+5。',
          '『楽観』気分がリラックスする。エナジー5点回復。',
          '『自閉』自分の殻に閉じこもろうとする。5ターンの間、特殊防御力に+5。',
          '『反射』敵の攻撃に即座に反応できる。5ターンの間、肉弾の回避判定に+10。',
          '『快感』快感を覚える。衝動が1点回復する。',
        ],
        [
          '『情熱』激しい情熱が噴き出してくる。エナジー10点と衝動1点回復。',
          '『気合』体中に気合いが入る。10ターンの間、すべてのダメージに+10。',
          '『加速』体中の神経が加速する。10ターンの間、すべての命中判定に+10。',
          '『利己』考え方が利己的になる。10ターンの間、特殊の命中判定に+10。',
          '『頑強』肉体が鋼のように強くなる。10ターンの間、肉弾防御力に+5。',
          '『察知』相手の動きを察知できる。10ターンの間、射撃防御力に+5。',
          '『殺意』激しい殺意にとらわれる。10ターンの間、特殊ダメージに+10。',
          '『静観』心が落ち着き冷静になる。10ターンの間、射撃の回避判定に+5。',
          '『是空』頭が冴えて敵の行動が読める。10ターンの間、すべての回避判定に+5。',
          '『心眼』心の目で相手の行動を読める。5ターンの間、射撃の回避判定に+10。',
          '『自愛』何をおいても自分が愛しく思える。5ターンの間、特殊の回避判定に+10。',
        ],
        [
          '『神速』人知を超えたスピードに目覚める。戦闘終了まで「通常」行動を２回行えるようになる。',
          '『流水』超感覚に目覚める。10ターンの間、すべての回避判定に+10。',
          '『覚醒』肉体の回復力が限界突破。エナジー20点回復。',
          '『忍耐』あらゆる苦痛に耐える鋼の精神が宿る。10ターンの間、すべての防御力に+5。',
          '『予知』第六感が研ぎ澄まされる。10ターンの間、射撃の命中とダメージに+10。',
          '『豪傑』身体能力が限界を超えて上昇する。10ターンの間、肉弾の命中とダメージに+10。',
          '『殺気』猛烈な殺意がみなぎる。10ターンの間、特殊の命中判定とダメージに+10。',
          '『発動』反射神経が飛躍的に加速される。10ターンの間、【行動値】+10。',
          '『激情』激しい感情があふれ出す。10ターンの間、すべてのダメージに+10。',
          '『超人』運動神経が飛躍的に加速される。10ターンの間、すべての命中判定に+15。',
          '『悟り』心が解放され無我の境地に達する。衝動が３点回復する',
        ]
      ].freeze

      # 誤作動表
      MALFUNCTION_TABLE = [
        [
          '『緊急停止』機能に異常発生。次のターンの終了まで、「行動不能」になる。[30点]',
          '『動力不調』動力装置に異常発生。このターンの終了時まで、「行動不能」になる。[30点]',
          '『腕部停止』腕部機構に異常発生。このターンの終了時まで、「タイミング：攻撃」が行えない。[20点]',
          '『脚部停止』脚部機構に異常発生。このターンの終了時まで、あらゆる「移動」を行えない。[20点]',
          '『機能制動』機能が一瞬停止するが、影響なし。[10点]',
          '『不良調整』機能に違和感。影響なし。[10点]',
          '『機能安定』機能が安定した。影響なし。[10点]',
          '『機能暴発』直前に使用した《兵装》がこのターンの終了時まで使用不能。未使用なら影響なし。[20点]',
          '『離脱機能』機能の異常発生。行動を消費することなく、即座に敵から「移動(全力)」で離れる。[20点]',
          '『排熱暴走』排熱機能に異常発生。次のターン終了時まで「着火」状態となる。[30点]',
          '『作動予測』次に起きる誤作動を予測できる。「第2限界点」に達したとき、「作動予測」以外の任意の誤作動を選択できる。[30点]',
        ],
        [
          '『安全機能』安全機能が作動。このターンの終了時まで、あらゆる判定に-5。[40点]',
          '『筋肉萎縮』人工筋肉に異常発生。次のターン終了時まで、【肉体】判定に-2。[30点]',
          '『出力低下』駆動部に異常発生。次のターンの終了時まで、【機敏】判定に-2。[30点]',
          '『感覚異常』視界機能に異常発生。次のターンの終了時まで、【感覚】判定に-2。[20点]',
          '『視界不良』視界機能に異常発生。次のターンの終了時まで、【幸運】判定に-2。[20点]',
          '『機能制動』機能が一瞬停止するが、影響なし。[10点]',
          '『不良調整』機能に違和感。影響なし。[10点]',
          '『援護不通』援護ソフトが誤作動。次のターンの終了時まで、【知力】判定-2。[20点]',
          '『発声変調』発声機能に異常発生。次のターンの終了時まで、【精神】判定-2。[30点]',
          '『装甲軟化』防御機構に異常発生。あらゆる防御力に-5。[30点]',
          '『作動予測』次に起きる誤作動を予測できる。「第3限界点」に達したとき、「作動予測」以外の任意の誤作動を選択できる。[40点]',
        ],
        [
          '『動力漏電』動力から漏電。『負荷』が2点上昇。[40点]',
          '『駆動異常』脚部に異常発生。次のターンの終了時まで、「移動」距離半減。[40点]',
          '『足下転倒』バランサーに異常発生。「転倒」状態となる。[30点]',
          '『出力向上』《兵装》機能が向上。次のターンの終了時まで、特殊ダメージに+1d点。[30点]',
          '『機能制動』機能が一瞬停止するが、影響なし。[20点]',
          '『機能暴走』攻撃機能が暴走し、戦闘能力が上昇。「着火」状態になるが、あらゆるダメージに+10。[20点]',
          '『身体向上』格闘機能が向上。次のターンの終了時まで、肉弾ダメージに+1d点。[30点]',
          '『反射向上』反応速度が向上。次のターンの終了時まで、【行動値】が+5。[30点]',
          '『精度向上』標準機能が向上。次のターンの終了時まで、射撃ダメージに+1d点。[30点]',
          '『電子賦活』電磁障壁が突如回復。【電力】が10点回復する。[30点]',
          '『作動予測』次に起きる誤作動を予測できる。「第4限界点」に達したとき、「作動予測」以外の任意の誤作動を選択できる。[40点]',
        ],
        [
          '『照準誤認』照準機能に異常発生。即座に最も近い味方を全力攻撃。[50点]',
          '『攻撃特化』攻撃機能が上昇。次のターン終了時まで、あらゆるダメージに+2dされるが「タイミング：防御」を行えない。[40点]',
          '『機内窒息』呼吸補助機能に異常発生。次のターン終了時まで、「窒息」状態。[40点]',
          '『機能増強』全機能が飛躍的に向上。次のターン終了時まで、《兵装》のコストを払わなくて良い。[30点]',
          '『音声遮断』聴覚機能に異常発生。次のターン終了時まで、一切の物音が聞こえず、あらゆる回避判定に-5。[30点]',
          '『電流加速』電磁障壁が効率的に流れる。『負荷』が1点回復。[20点]',
          '『精密射撃』照準の精度が向上。あらゆるダメージに+5点。[30点]',
          '『電力浪費』電磁障壁が過剰に使用される。【電力】が10点減少。[30点]',
          '『荷電暴走』【電力】を5点消費するが、次のターン終了時まで、あらゆるダメージに+10点。[40点]',
          '『状況分析』視界機能が向上。あらゆる命中判定に+5。[40点]',
          '『作動予測』次に起きる誤作動を予測できる。「第5限界点」に達したとき、「作動予測」以外の任意の誤作動を選択できる。[50点]',
        ],
        [
          '『出力過剰』全出力が過剰。次のターン終了時まで、あらゆるダメージの総計が2倍になるが《兵装》のコストも2倍になる。[50点]',
          '『機関暴走』放熱機能が暴走。自分を中心に半径5m以内すべての対象を「着火」状態にする。[50点]',
          '『機体清冽』機能異常から復帰。「気絶」「死亡」を除く、あらゆる状態変化がすべて消滅。[40点]',
          '『鉄壁装甲』防御機能が向上。次のターン終了時まで、あらゆる防御力に+5。[30点]',
          '『緊急駆動』回避機能が向上。次のターン終了時まで、あらゆる回避判定に+5。[30点]',
          '『出力増大』装備補助機能が向上。次のターン終了時まで、「所持品」あるいは《兵装》を使用したダメージ総計が2倍になる。[30点]',
          '『機体加速』運動機能が暴走。次のターン終了時まで、【行動値】が2倍となる。[30点]',
          '『自動追尾』自動追尾機能が発動。次のターン終了時まで、あらゆる命中値に+5。[40点]',
          '『限定解除』全機能の限界を解除。次のターン終了時まで、あらゆるダメージに+10。[50点]',
          '『負荷軽減』急激に機体の負荷が低下。『負荷』が2点回復する。[50点]',
          '『複合反応』この表を2回振る。ただし、同じ結果が出た場合は適用するのは一度だけ。獲得経験値は累積する。[0点]',
        ]
      ].freeze

      # ミュータント衝動表
      MUTANT_TABLE = [
        [
          '『怒り』突然強い怒りに駆られる。近くの対象にあたりちらす。このターンの終了まで「行動不能」となる。[20点]',
          '『絶叫』悪魔寄生体が蠢きだす。その恐怖に絶叫。このターンの終了まで「行動不能」となる。[10点]',
          '『悲哀』急に悲しいことを思い出す。このターンの終了まで「行動不能」となる。[10点]',
          '『微笑』可笑しくてしょうがない。くすくす笑いが止まらず、このターンの終了まで「行動不能」となる。[10点]',
          '『鈍感』衝動に気が付かなかった。何も起こらない。[0点]',
          '『抑制』衝動を抑え込んだ。何も起こらない。[0点]',
          '『我慢』衝動を我慢した。何も起こらない。[0点]',
          '『前兆』悪魔的特徴が一瞬目立つ。１ターン(10秒)持続。《擬態変化》を解いているなら影響なし。[10点]',
          '『発現』悪魔的特徴が急に目立つ。60ターン(10分)持続。《擬態変化》を解いているなら影響なし。[10点]',
          '『解除』利き腕/前脚の《擬態変化》が２ターン(20秒)かけて解除される。18ターン(3分)持続。《擬態変化》を解いているなら影響なし。[20点]',
          '『顕現』利き腕/前脚の《擬態変化》が瞬時に解除。60ターン(10分)持続。《擬態変化》を解いているなら影響なし。[20点]',
        ],
        [
          '『茫然』思考が止まり、このターンの終了まで「攻撃」行動を行えない。その他の行動は影響なし。[20点]',
          '『激怒』側にいるもの(生物、物体問わず)が憎くなり、殴る。《擬態変化》を解いているならば次のターンの終了まで、すべての命中判定+5、回避判定-5。[20点]',
          '『残忍』殺意、破壊衝動が一瞬増す。戦闘中ならば次のターンに行われる「攻撃」行動の達成値に+5。[20点]',
          '『落涙』過去の悲しい想い出が去来し、涙が溢れる。１ターン(10秒)「通常」行動を行えない。その他の行動に影響はない。[10点]',
          '『抑制』衝動を抑え込んだ。何も起こらない。[0点]',
          '『我慢』衝動を我慢した。何も起こらない。[0点]',
          '『忍耐』肉体を傷つけて衝動に耐えた。5点ダメージ。[10点]',
          '『辛抱』ほんの一瞬、《擬態変化》が解けかかる。無理に抑えたので5点ダメージ。《擬態変化》を解いているなら影響なし。[10点]',
          '『異貌』３ターン(30秒)かけて《擬態変化》が解除される。18ターン(3分)持続。《擬態変化》を解いているなら影響なし。[20点]',
          '『苦痛』寄生生物が体内で暴れ狂う。10点ダメージ。[20点]',
          '『変貌』特異な外見的特徴が３ターン(30秒)かけて現れる。18ターン(3分)持続。《擬態変化》を解いているなら影響なし。[20点]',
        ],
        [
          '『憤怒』怒りに全身が満たされる。次のターンの終了まで、すべてのダメージを+1d点する。[20点]',
          '『加速』ほとばしる衝動により。次のターンは【行動値】が２倍になる。[20点]',
          '『発露』力が溢れ出る。次のターンの終了まで、すべてのダメージに+5、防御点-5(最低0)される。[20点]',
          '『乾き』攻撃衝動を抑えられない。次のターンの終了まで全ての命中判定+5、回避判定-5。[10点]',
          '『絶叫』あらん限りの声で叫ぶ。このターンの終了まで、あらゆる回避判定に-10。[10点]',
          '『我慢』衝動を我慢した。何も起こらない。[0点]',
          '『限界』衝動を無理矢理抑え込む。10点ダメージ。[10点]',
          '『解放』衝動に耐えられず擬態が解ける。３ターン(30秒)かけて解除。《擬態変化》を解いているなら影響なし。[10点]',
          '『本能』衝動に駆られ、《擬態変化》が瞬時に解除。次のターンは、目の前の動くものを敵味方区別無く攻撃する。[20点]',
          '『保身』次のターンの終了まで、敵を攻撃できない。全ての防御力に+5。[20点]',
          '『救済』悪魔寄生体が危機を察知し、【エナジー】を20点回復する。[20点]',
        ],
        [
          '『癒し』【エナジー】が即座に3d点回復。[20点]',
          '『離脱』その場から逃げ出す。逃げられない場合は、うずくまって動けなくなる。１ターン(10秒)経過すれば我に返る。[20点]',
          '『脱力』急に力が抜ける。次のターンの終了まで、全ての判定に-5される。[20点]',
          '『全力』激しい躁状態。次のターンの終了まで、命中判定に+10、回避判定に-10。[20点]',
          '『混沌』1時間の間、意味のある言葉を話せなくなる。[10点]',
          '『争乱』体内で共生生物同士が争い、暴れ回る。衝動が1点増える。[10点]',
          '『本能』衝動に駆られ、《擬態変化》が瞬時に解除。次のターン、目の前の動くものを敵味方区別無く攻撃する。[20点]',
          '『焦燥』焦りから「転倒」する。[20点]',
          '『猜疑』味方が急に敵に思える。即座に近くの味方に1回攻撃(自動命中。ダメージは通常)。いなければ影響なし。[20点]',
          '『自虐』自分が許せない。自分へ素手攻撃(自動命中。ダメージは通常)。[20点]',
          '『自浄』少し我に返る。衝動が2点回復する。[20点]',
        ],
        [
          '『絶望』無力感にさいなまれる。次のターンの終了時まで「行動不能」となる。[30点]',
          '『眠り』猛烈な睡魔に襲われる。60ターン(10分)、もしくは戦闘終了まで起こしても起きない。[30点]',
          '『誤動』突然《擬態変化》が使用され、人間の姿になる(衝動も通常通り使用する)。既に使用していた場合は変化無し。[20点]',
          '『暗闇』視神経に影響が出る。以後1日「暗闇」になる。[20点]',
          '『再生』共生生物が危機を察知し、【エナジー】を10点回復する。[20点]',
          '『混乱』1時間の間、意味のある言葉を話せなくなる。[20点]',
          '『硬化』急に体が硬直する。このターンの終了時まで、あらゆる命中判定に-10、防御力に+10。[20点]',
          '『暴君』自分が最強に思えてしかたがない。60ターン(10分)攻撃判定に+10、回避判定に-10。[20点]',
          '『無双』全力だが無防備。60ターン(10分)、全てのダメージに+10、防御点と【行動値】は0。[20点]',
          '『喪失』《擬態変化》が使用中なら、即座に解除。さらに24時間、《擬態変化》が使えなくなる。[30点]',
          '『進化』共生生物たちが上手く混じって身体能力が向上する。次の判定の達成値+10。[30点]',
        ]
      ].freeze

      # 鬼御魂(戦闘外)衝動表
      ONIMITAMA_OUT_OF_BATTLE_TABLE = [
        [
          '『恐怖』恐怖の感情が爆発し、目に映るすべてが恐ろしくなる。[20点]',
          '『落涙』過去の悲しい思い出が去来し、涙が溢れる。[10点]',
          '『哄笑』突如として精神が高揚し、狂ったように笑う。[10点]',
          '『咆哮』<和魂>によって怒りが増し、突如として雄たけびを上げる。[10点]',
          '『抑制』衝動を完全に律する。何も起こらない。[0点]',
          '『沈静』穏やかな気分になる。[0点]',
          '『理性』衝動を理性で押さえ込む。何も起こらない。[0点]',
          '『破裂』衝動を押さえ込もうとして体内の欠陥が破裂、喀血する。[10点]',
          '『喪失』一瞬、〈和魂〉の神通力が失われる。[10点]',
          '『枯渇』吸血への渇望が押さえられず、一般人を血走った目で見つめる。[10点]',
          '『内包』凄まじい勢いで体内に妖気が内包され、力が増す。[20点]',
        ],
        [
          '『飢餓』突然の吸血衝動。一般人を猛烈に襲いたくなる。[20点]',
          '『封印』妖気を操作できず、1分間《特殊能力》を使用できない。[20点]',
          '『拒絶』情緒が不安定となり、味方が急に怖くなる。[20点]',
          '『拡散』突如として全身から妖気が噴出、目の前の対象を吹き飛ばす。[10点]',
          '『抑制』衝動を完全に律する。なにも起こらない。[0点]',
          '『治癒』疲れが癒される。[0点]',
          '『本能』暴力衝動に駆られ、瞬時に"異形化"してしまう。[10点]',
          '『破砕』破壊衝動が巻き起こり、目の前の障害物を破壊する。[20点]',
          '『悪寒』突如として悪寒が走り、物事に集中できなくなる。',
          '『心傷』突如としてトラウマを思い出し、立ちつくす。[20点]',
          '『回想』過去の思い出が去来、活力がみなぎる。[30点]',
        ],
        [
          '『不動』妖気が全身を駆け巡り、激痛によって動けなくなる。[20点]',
          '『脱力』突如として妖気が衰え、脱力のあまり膝をつく。[20点]',
          '『異形』瞬時にして犬歯が肥大し、目が紅く、邪悪に輝く。[20点]',
          '『精密』突如として視界が広がり、目視せずとも背後の風景や人物を見通せる。[10点]',
          '『獰猛』突如として怒りの感情が湧き起こり、目前の対象を罵倒する。[0点]',
          '『高揚』〈和魂〉の影響により精神が高揚、躁状態となる。[0点]',
          '『憎悪』突如として憎悪が沸き起こり、目前の対象に掴みかかる。[0点]',
          '『加速』全身に妖気が駆け巡り、反射速度が増し、10秒を1分のように感じる。[10点]',
          '『平穏』精神に変調が起こり、異常なほど理性的になる。[20点]',
          '『慈愛』あらゆる者に自愛を抱き、親身に接する。[20点]',
          '『支配』一瞬〈和魂〉を完全支配、次に行う戦闘外の判定を1回だけ効果的成功する。[20点]',
        ],
        [
          '『変質』突如として妖気が変質、半径5mにわたって透明な壁を展開する。[30点]',
          '『増強』妖気によって身体能力が増強され、10分間[運動]上級を取得する。[20点]',
          '『拡大』妖気が目視できるほど両腕から発散、20m先の物体を操作できる。[20点]',
          '『清浄』妖気を開放、<鬼御魂>を持たない半径10m内全ての生物を眠らせる。[10点]',
          '『透視』濃密な妖気が瞳に宿り、1分間20mの距離を透視できる。[10点]',
          '『強行』突如として妖気が増し、接触した対象を【肉体】x2m吹き飛ばす。[0点]',
          '『衝撃』妖気が殺傷能力を帯び、接触した物体を破壊。20秒間、手足が簡易の肉弾武器となる。[10点]',
          '『撃滅』妖気が稲妻や火災へと変異し、接触した物体を「着火」させる。[20点]',
          '『展開』全身を包む妖気の層が厚くなり、1分間物理的な接触を行えない。[20点]',
          '『模倣』<和魂>が精神を活性化させ、異常な記憶力を手に入れる。[20点]',
          '『支配』一瞬<和魂>を完全支配、次に行う戦闘外の判定を1回だけ効果的成功する。[20点]',
        ],
        [
          '『解放』妖気を無尽蔵に解放、1分間、戦闘外で使用する「コスト」を無視できる。[30点]',
          '『加速』妖気が両足に集中、1分間、時速50kmで疾走できる。[20点]',
          '『付与』妖気が感覚に集中、1分間50m先を透視できる。[20点]',
          '『強固』妖気が全身に浸透、1分間「窒息」「状態変化」のダメージを無効。[20点]',
          '『破壊』全妖気が膂力に変換され、1分間【肉体】判定の達成値を2倍にする。[20点]',
          '『爆散』1分間妖気が変質、接触した対象を爆破でき、障害物を瞬時に破壊。[10点]',
          '『浄化』半径10m全てを浄化、範囲内で持続する《特殊能力》の効果を無効化。[20点]',
          '『律動』半径10m内の<鬼御魂>を持たない生物を1分間気絶させる。[20点]',
          '『修復』妖気が極限まで活性化され、疲労を取り払う。[20点]',
          '『本性』瞬時に異形化。異形化中であれば、さらに禍々しい姿へ変質する。[20点]',
          '『覚醒』1時間、全身から閃光を発し、高さが【精神】mの"光の柱"に包まれる。[30点]',
        ]
      ].freeze

      # 鬼御魂(戦闘中)衝動表
      ONIMITAMA_BATTLE_TABLE = [
        [
          '『恐怖』効果が発生したターンの終了時まで「行動不能」状態となる。',
          '『落涙』1ターン(10秒)「通常」行動を行えない。回避行動に影響はない。',
          '『哄笑』効果が発生したターンの終了時まで「行動不能」となる。',
          '『咆哮』効果が発生したターンの終了時まで「行動不能」となる。',
          '『抑制』影響なし。',
          '『沈静』【エナジー】を3点回復する。',
          '『理性』影響なし。',
          '『破裂』【エナジー】が5点減少する。',
          '『喪失』次ターンの【行動値】が半減(端数切捨て)。',
          '『枯渇』次ターンの終了時まで、あらゆるダメージに「+2」点。',
          '『内包』『衝動』が2点回復する。',
        ],
        [
          '『飢餓』最も近くの無防備な対象から血液摂取を試みる。対象が<鬼御魂>を持たない場合、血液採取の効果を得られる。',
          '『封印』効果が発生したターンの終了時まで《特殊能力》を使用できない。',
          '『拒絶』効果が発生したターンの終了時まで、味方を対象とした《特殊効果》を使用不可。',
          '『拡散』半径5m以内の対象全ての【エナジー】を1d点減少する(抵抗不可、防御力無視)。',
          '『抑制』影響なし。',
          '『治癒』【エナジー】を5点回復する。',
          '『本能』即座に"異形化"、ターン終了まで任意のダメージ1つに「+1d」点。',
          '『破砕』行動を消費することなく、近くに存在する障害物1つを瞬時に破壊。',
          '『悪寒』効果が発生したターンの終了時まで、あらゆる判定の達成値に「-5」。',
          '『心傷』効果が発生したターンの終了時まで、「タイミング:攻撃」を行えない。',
          '『回想』『衝動』を3点回復する。',
        ],
        [
          '『不動』次のターンの終了時まで「タイミング:通常」を行えない。',
          '『脱力』次のターンの終了時まで「転倒」状態となる。',
          '『異形』次に行う行為判定は、出目に関係なく効果的成功として扱う。',
          '『精密』次のターンの終了時まで、射撃ダメージに「+5」点。',
          '『獰猛』次のターンの終了時まで、肉弾ダメージに「+5」点。',
          '『高揚』次のターンの終了時まで、あらゆるダメージに「+1d」点。',
          '『憎悪』次のターンの終了時まで、特殊ダメージに「+5」点。',
          '『加速』次のターンの終了時まで【行動値】に「+5」。',
          '『平穏』あらゆる「状態変化」を任意で1つ消滅させる。',
          '『慈愛』半径5m内の味方全ての【エナジー】を5点回復する。',
          '『支配』「衝動表」の結果を、第三段階の中から任意のものから1つ選択できる。',
        ],
        [
          '『変質』次のターンの終了時まで、任意の防御力の1つに「+10」点。',
          '『増強』次のターンの終了時まで、任意の回避判定1つに「+5」。',
          '『拡大』次のターンの終了時まで、任意の命中判定1つに「+5」。',
          '『清浄』半径10m内の味方全ての【エナジー】を5点回復する。',
          '『透視』次のターン終了時まで、射撃ダメージに「+10」点。',
          '『強行』次のターンは、「タイミング:攻撃」を余分に1回行うことができる。',
          '『衝撃』次のターンの終了時まで、肉弾ダメージに「+10」点。',
          '『撃滅』次のターンの終了時まで、特殊ダメージに「+10」点。',
          '『展開』次のターンの終了時まで、本人が受けるあらゆるダメージを半減できる。',
          '『模倣』次のターンの終了時まで、敵が使用した《特殊能力》1つを1回だけ使用可能。',
          '『支配』「衝動表」の結果を、第四段階の中から任意のものから1つ選択できる。',
        ],
        [
          '『解放』次のターンの終了時まで、あらゆる戦闘修正が2倍となる。',
          '『加速』次のターンの終了時まで、【行動値】が2倍となる。',
          '『付与』次のターンの終了時まで、射撃ダメージの総計を2倍にできる。',
          '『強固』次のターンの終了時まで、あらゆる防御力に「+10」点。',
          '『破壊』次のターンの終了時まで、肉弾ダメージの総計を2倍にできる。',
          '『爆散』次のターンの終了時まで、あらゆるダメージに「+2d」点。',
          '『浄化』『衝動』を1d点回復する。',
          '『律動』次のターンの終了時まで、特殊ダメージの総計を2倍にできる。',
          '『修復』【エナジー】が最大値まで回復する。',
          '『本性』この戦闘中のみ、最終能力を2回使用できる。',
          '『覚醒』第五段階を2回振り、双方の効果を適応する。',
        ]
      ].freeze
    end
  end
end
