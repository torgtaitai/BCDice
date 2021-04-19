# frozen_string_literal: true

module BCDice
  module GameSystem
    class MeikyuDays < Base
      # ゲームシステムの識別子
      ID = 'MeikyuDays'

      # ゲームシステム名
      NAME = '迷宮デイズ'

      # ゲームシステム名の読みがな
      SORT_KEY = 'めいきゆうていす'

      # ダイスボットの使い方
      HELP_MESSAGE = <<~INFO_MESSAGE_TEXT
        ・判定　(nMD+m)
        　n個のD6を振って大きい物二つだけみて達成値を算出します。修正mも可能です。
        　絶対成功と絶対失敗も自動判定します。
        ・各種表
        　・散策表　　　　　　DRT
        　・交渉表　　　　　　DNT
        　・休憩表　　　　　　DBT
        　・ハプニング表　　　DHT
        　・カーネル停止表　　KST
        　・痛打表　CAT／戦闘ファンブル表　CFT／致命傷表　FWT
        　・おたから表１／２／３／４　T1T/T2T/T3T/T4T
        　・相場表　　　　　　MPT
        　・登場表　　　　　　APT
        　・因縁表　DCT／怪物因縁表　MCT／PC因縁表　PCT／ラブ因縁表　LCT
        ・D66ダイスあり
      INFO_MESSAGE_TEXT

      def initialize(command)
        super(command)

        @sort_add_dice = true
        @d66_sort_type = D66SortType::ASC
      end

      def replace_text(string)
        string = string.gsub(/(\d+)MD6/i) { "#{Regexp.last_match(1)}R6" }
        string = string.gsub(/(\d+)MD/i) { "#{Regexp.last_match(1)}R6" }
        return string
      end

      def result_2d6(total, dice_total, _dice_list, cmp_op, target)
        return nil unless cmp_op == :>=

        if dice_total <= 2
          Result.fumble("絶対失敗")
        elsif dice_total >= 12
          Result.critical("絶対成功")
        elsif target == "?"
          Result.nothing
        elsif total >= target
          Result.success("成功")
        else
          Result.failure("失敗")
        end
      end

      def checkRoll(string)
        string = replace_text(string)

        debug("checkRoll string", string)
        unless (m = /(^|\s)S?((\d+)[rR]6([+\-\d]*)(([>=]+)(\d+))?)(\s|$)/i.match(string))
          debug("not mutch")
          return nil
        end

        string = m[2]
        dice_c = m[3].to_i
        bonus = 0
        signOfInequality = ""
        diff = 0

        bonusText = m[4]
        bonus = ArithmeticEvaluator.eval(bonusText) unless bonusText.nil?

        signOfInequality = m[6] if m[6]
        diff = m[7].to_i if m[7]

        dice_num = @randomizer.roll_barabara(dice_c, 6).sort
        dice_str = dice_num.join(",")

        dice_now = dice_num[dice_c - 2] + dice_num[dice_c - 1]
        total_n = dice_now + bonus

        dice_str = "[#{dice_str}]"

        output = "#{dice_now}#{dice_str}"

        if bonus > 0
          output += "+#{bonus}"
        elsif bonus < 0
          output += bonus.to_s
        end

        if /[^\d\[\]]+/ =~ output
          output = "(#{string}) ＞ #{output} ＞ #{total_n}"
        else
          output = "(#{string}) ＞ #{total_n}"
        end

        if signOfInequality != "" # 成功度判定処理
          cmp_op = Normalize.comparison_operator(signOfInequality)
          result = result_2d6(total_n, dice_now, dice_num, cmp_op, diff)
          output += " ＞ #{result.text}" if result
        end

        return output
      end

      ####################           迷宮デイズ          ########################
      def eval_game_system_specific_command(command)
        if (result = roll_tables(command, TABLES))
          result
        else
          checkRoll(command)
        end
      end

      TABLES = {
        "DRT" => DiceTable::Table.new(
          "散策表",
          "2D6",
          [
            '次に挑む迷宮の迷宮支配者を倒さなければ人類文明が滅ぶことを偶然知ってしまう。《気力》を最大値まで回復する。',
            '同じ迷宮を対象とする違う依頼を受ける。シナリオの目的を果たしたときに、追加で1d6MCの報酬を得られるようになる。',
            '他の迷宮屋の評判を耳にする。パーティから好きなキャラクター1人を選び、そのキャラクターに対する《好意》が1点上昇する。',
            '毎日の散歩の成果が出て、体の調子が良い。このゲーム中、《HP》の最大値が5点上昇し、《HP》が5点回復する。',
            'メディアの取材を受ける。《民の声》を2点得る。',
            '近所からおすそ分けをもらう。【回復薬】を6個手に入れる。',
            '近所の人がきみの噂話をしている。ゲーム中に自分が対象に入った「恋人」「親友」「忠誠」の人間関係を成立させるたび、《民の声》を2点得る。',
            '似たような迷宮に挑んだことがある迷宮屋から話を聞いた。迷宮フェイズでの情報収集の難易度が2下がる。',
            '武具の安売りを見つける。ランダムな武具アイテム1つを半分の値段で購入することができる。',
            '他の迷宮屋と喧嘩になる。パーティの中からランダムに1人を選び、お互いの《敵意》を1点上昇させる。',
            '迷宮屋志望の見習が、1d6人ほど配下として加わる。',
          ]
        ),
        "DBT" => DiceTable::Table.new(
          "休憩表",
          "2D6",
          [
            'アイテムの改善案を出し合ってみる。各キャラクターは、好きなキャラクター1体を選び、1d6を振ってそのキャラクターのアイテムスロットから1つをランダムに選ぶ。出た目のアイテムにレベルがあれば、1上昇する。',
            '何気ない雑談が腹の探り合いに発展する。各キャラクターは、好きなキャラクターに対する《好意》と《敵意》を入れ替え、その属性を自由に変更することができる。',
            '好きな単語表からランダムに単語を1つ選ぶ。その部屋にはそれに関係したものがたくさん置いてあるため、出た単語が「好きなもの」に入っているキャラクターは、《気力》を2点得る。',
            '嫌いな人の話題で盛り上がる。各キャラクターは同じキャラクターに《敵意》を持っている人を1人選び、その人への《好意》を1点上昇させる。',
            '窓の外から報道のヘリコプターがこちらを撮影しているのが見える。格好よく見せるために、各キャラクターは〔魅力〕で難易度13の判定を行う。誰かが成功するたびに《民の声》が1点増加する。',
            '雑談や休息など、思い思いに時間を過ごす。各キャラクターは、好きなキャラクター1体への《好意》を1点上昇させる。',
            '通路の片隅で素材が山を作っているのを見つけた。各キャラクターは〔探索〕で難易度11の判定を行う。誰かが成功するたびに、好きな素材を1種類選び、それを1d6個手に入れる。',
            'チームワークの確認。各プレイヤーは打ち合わせをせずに、一斉にじゃんけんを行う。いちばん出した人が多かった手を出したプレイヤーのPCは、《気力》を2点得る。',
            '仮眠をとって休憩。各キャラクターは〔才覚〕で難易度9の判定を行う。成功すれば《HP》が最大値まで回復する。',
            '各キャラクターは、迷宮化現象に巻き込まれ、身動きがとれない普通の人を1人見つけた。《配下》に加えることができる。',
            '各キャラクターは1d6を振る。出た目の上位2名が唐突に恋に落ちる。同じ目が出て2名をうまく割り出せない場合は、GMの左隣に近い方を優先する。恋に落ちた2人、相手以外に対する《好意》を合計し、その値に対する《好意》に加える。その後、相手以外に対する《好意》をすべて0にする。',
          ]
        ),
        "DNT" => DiceTable::Table.new(
          "交渉表",
          "2D6",
          [
            '中立的な態度は偽装だった。彼らは不意打ちを行う。奇襲扱いで戦闘を開始すること。',
            '交渉は決裂！　戦闘を行うこと。',
            '交渉は決裂！　戦闘を行うこと。',
            '「贄をささげれば話を聞こう」モンスターの中で最もレベルが高いもののレベルと等しい数だけ何らかの素材を減少すれば、友好的になる。減少させない場合、戦闘を開始すること。',
            '「……お前の趣味、なに？」好きな単語表一個を選び、D66を振る。パーティの中に、その項目を好きなものにしているキャラクターがいれば、友好的になる。そうでなければ戦闘を開始すること。',
            '怪物たちは物欲しそうにこちらを見ている。「肉」の素材をモンスターの数だけ消費するか、【お弁当】【フルコース】1個を消費すれば友好的になる。消費しなければ、戦闘を開始すること。',
            '怪物たちは値踏みするようにこちらを見ている。現金で1d6MC支払えば友好的になる。そうでない場合、戦闘を開始すること。',
            '「何かいいもんよこせ」モンスターの中で最もレベルの高いもののレベル以上の価格のアイテムを消費すれば友好的になる。そうでない場合、戦闘を開始すること。',
            '「面白い話を聞かせろよ」プレイヤーたちは面白い話をすること。GMは面白いと思えばモンスターは友好的になる。面白くなかった場合は戦闘を開始する。',
            '「俺に勝てたら話を聞いてやろう」怪物が力比べを挑んできた。モンスターの中で最もレベルが高いものと、パーティの代表がそれぞれ〔武勇〕で判定を行う。パーティの代表の達成値がモンスター以上であれば友好的になる。負けた場合、もう一度交渉するか戦闘するかを決定すること。',
            '運命の出会い。一目見た瞬間に打ち解けあい、友好的になる。',
          ]
        ),
        "DHT" => DiceTable::Table.new(
          "ハプニング表",
          "2D6",
          [
            '急に絶望に襲われる。【お酒】を消費することが出来なければ、このゲーム中、最も高い能力値が1点減少する。',
            '思考に靄がかかってしまう。「散漫」のバッドステータスを受ける。',
            '気がついたら太っていた。「肥満」のバッドステータスを受ける。',
            '無残な失敗に愛想を尽かした配下が2d6人ほど去って行ってしまう。',
            '微妙な空気を読み切れず、パーティ全員の《気力》が1点減少する。',
            '事故だか故意だかで、仲間を殴ってしまう。ランダムに選んだパーティメンバー1名の《HP》を自分の〔武勇〕と同じ値だけ減少させる。',
            '期待が大きければ失望も大きい。あなたに対して《好意》を持っているキャラクター全員は、あなたに対する《好意》を1点減らす。',
            'アイテムを粗末に扱ってしまう。持ち物の中からランダムにアイテムを1つ決定する。そのアイテムにレベルがある場合、レベルが1下がる。',
            '失敗のショックのせいで知的な行動をとれなくなる。「愚か」のバッドステータスを受ける。',
            '過去の行状のせいで人に呪われる。「呪い」のバッドステータスを受ける。',
            '自分の失敗が許せない。このゲームの間、《器》が1点減少したものとして扱う。',
          ]
        ),
        "KST" => DiceTable::Table.new(
          "カーネル停止表",
          "2D6",
          [
            'カーネルが肉体に致命的な迷宮化を引き起こす！致命傷表を振ること。カーネルはまだ停止しない。',
            '〔才覚〕で難易度9の判定を行う。失敗すると記憶が迷宮化を起こし、銀行口座の暗証番号を忘れてしまう。口座に入っているMCはすべて失われる。カーネルは停止しない。',
            '迷宮化エネルギーが装備を直撃。素早く避けるため〔武勇〕で難易度9の判定を行う。失敗した場合、持っているアイテムからランダムに1つを選ぶ。そのアイテムは激しい迷宮化を起こし破壊される。カーネルは停止しない。',
            '正体不明のエネルギーが部屋中を駆け巡る。パーティ全員は1d6ダメージを受ける。カーネルは停止しない。',
            '心象が迷宮化していく。〔魅力〕で難易度9の判定を行う。失敗すると人間関係が迷宮化を起こし、持っている感情値がすべて1点減少する。カーネルは停止しない。',
            '激しい迷宮化に曝され、1d6点のダメージを受ける。〔探索〕で難易度11の判定を行う。成功すれば、怪我を負いながらもカーネルを停止させることに成功する。',
            'パーティ全員は軽い迷宮化に曝され1ダメージを受ける。パーティを統率する為に〔魅力〕で難易度11の判定を行うこと。成功すれば、カーネルは停止する。',
            '素早い一撃でカーネルの息の根を止めるために〔武勇〕で難易度9の判定を行う。成功すれば見事にカーネルを停止させることに成功する。',
            'カーネルの構造を感じ取り、一瞬にして停止させることに成功。さらに迷宮化の副産物としてランダムなレアアイテム1つを入手する。',
            'カーネルは停止した。そして持っているアイテムの中からランダムに1つを選ぶ。そのアイテムにレベルがあれば、いつのまにかレベルが1上昇している。',
            '鮮やかにカーネルを停止させ、傷一つないまま保存することに成功した。このカーネルの売却価格が3d6MC上昇する。',
          ]
        ),
        "CAT" => DiceTable::Table.new(
          "痛打表",
          "2D6",
          [
            '武器の伝説がまた一つ増えた。攻撃に使用した武具アイテムにレベルがあれば、そのレベルが1点上昇する。',
            '偶然ながら敵の弱点をつく。敵の《HP》を現在の半分の値にする。',
            '攻撃が終わった後、攻撃の勢いを利用して、自分を好きなエリアに移動させることができる。',
            '素晴らしい手ごたえに自分でも感動し、自分の《HP》が全快する。',
            '叙事詩的な一撃。《民の声》を1点増やす。',
            'クリーンヒット。攻撃の威力が2d6点上昇する。',
            '敵の動きを封じた。攻撃目標の《回避値》を戦闘終了まで2下げる。この効果は累積する。',
            '敵の勢いを利用し大ダメージ。攻撃の威力が、攻撃目標のレベルと同じだけ上昇する。',
            '敵の技を封じる。攻撃目標のスキル1種類を選び、戦闘中はそのスキルを使用できなくする。',
            '敵の急所をとらえ致命傷を与える。攻撃目標の《HP》を0にする。',
            '戦いの中、武具もまた成長する。持っているアイテムをランダムに1選ぶ。そのアイテムにレベルがあれば、1点上昇する。',
          ]
        ),
        "FWT" => DiceTable::Table.new(
          "致命傷表",
          "2D6",
          [
            '重要器官を粉砕される。キャラクターは即座に死亡する。',
            '傍目にも分かる致命傷。キャラクターは次の自分の行動処理が終わった時点で死亡する。《HP》の回復でこの死亡を防ぐことはできない。',
            '全身に強い衝撃をうける。〔武勇〕で難易度[5+受けたダメージ]の判定に成功すると、行動不能になる。判定に失敗すると死亡する。',
            '出血多量で意識不明。行動不能になる。この戦闘が終了するまでに《HP》を1以上にしないと、キャラクターは死亡する。',
            '重傷を負い昏睡状態。行動不能になる。このクォーターが終了するまでに《HP》を1以上にしないと、キャラクターは死亡する。',
            '攻撃で負った傷により意識を失う。行動不能になる。',
            '緊急回避！　〔探索〕で難易度[7-現在の《HP》]の判定を行う。成功すると、ランダムなバッドステータス1つを受けたうえで攻撃が無効になる。失敗すると、ランダムなバッドステータス1つを受けたうえで行動不能になる。',
            '最後の一撃を見切ることができるかもしれない。〔才覚〕で難易度[9-現在の《HP》]の判定を行う。成功すると《HP》が1になる。失敗すると行動不能になる。',
            'まだここで死ぬ運命ではないのかもしれない。〔魅力〕で難易度[9-現在の《HP》]の判定を行う。成功すると《HP》が1になる。失敗すると行動不能になる。',
            'カウンター！　攻撃をしてきた敵に対して、割り込んで好きな武器またはスキルを使った反撃をすることができる。これらの判定が成功した場合、ダメージやスキルの効果のあとで《HP》が1になる。失敗した場合、ただ行動不能になる。',
            '致命傷を受けたような気がしたが、気のせいだった。',
          ]
        ),
        "CFT" => DiceTable::Table.new(
          "戦闘ファンブル表",
          "2D6",
          [
            'ぶざまな失敗に熱くなる。攻撃の目標のキャラクターに対して《敵意》を4点得る。',
            '急にお腹が痛くなる！　何か回復アイテムを使うまで攻撃を行えなくなる。モンスターの場合、そのラウンドの終わりに未行動にならなくなる。',
            'アイテムが壊れた！　自分が持っているアイテムの中からランダムに1つを選び、そのアイテムが失われる。モンスターの場合、1d6ダメージを受ける。',
            '敵がいい気になる。行動不能になっていない敵軍キャラクター全ての《HP》を6点回復する。',
            '自分に攻撃が命中！　使用した武器のダメージを自分に与える。',
            'なんというか、やる気をなくす。《気力》を1点失う。モンスターの場合、1d6ダメージを受ける。',
            '仲間に攻撃が命中！　使用した武器の射程内の味方から、ランダムに1人を選ぶ。そのキャラクターに武器のダメージを与える。',
            '仲間の邪魔をしてしまう。未行動の自軍キャラクター1体を選び、行動済みにする。',
            'スキルを忘れてしまった！　習得しているスキルからランダムに1種類を選ぶ。そのスキルは戦闘が終了するまで使用できない。',
            '位置取りに失敗してとんでもない場所に。敵陣営プレイヤーまたはGMが、ファンブルしたキャラクターを好きな位置に移す。',
            'ピンチがチャンスに！　《HP》が現在値の半分になり、《気力》が最大値まで貯まる。',
          ]
        ),
        "APT" => DiceTable::Table.new(
          "登場表",
          "2D6",
          [
            '「ここから先に行かせるわけにはいかん」急ぐ途中に敵が立ちふさがる。〔武勇〕で難易度11の判定を行う。成功すればバトルフィールドの好きなエリアにそのキャラクターを配置することができる。失敗した場合、《HP》を1にした状態でバトルフィールドの好きなエリアにそのキャラクターを配置することができる。',
            '「待たせたな！」バトルフィールドの好きなエリアにそのキャラクターを配置することができる。',
            'おっと鉢合わせ！　バトルフィールドの敵軍の本陣に、そのキャラクターを配置すること。',
            '全力で駆けつける！　《HP》を2d6点減少すれば、バトルフィールドの好きなエリアにそのキャラクターを配置することができる。',
            'あいつらはこの先に行ったはず！　GMはそのキャラクターをバトルフィールドの好きなエリアに配置する。',
            'あの聞き覚えのある音は……！　そのキャラクターが【乗騎】を装備していれば、GMはそのキャラクターをバトルフィールドの好きなエリアに配置する。',
            '……間に合ったみたいだな。バトルフィールドの中に、そのキャラクターに対する《好意》が1点以上あるキャラクターがいれば、同じエリアにそのキャラクターを配置することができる。',
            'を！　これはこれは。好きな素材を1個拾う。',
            'いかん！　迷ってしまった。〔探索〕で難易度11の判定を行うこと。成功すればもう一度登場表を振り、結果を適用することができる。',
            'むむむむ？　ここは一度来た道のような……？　疲労して《気力》が1点減少。',
            '……いや、しかしそれどころではない！　そのキャラクターは、この戦闘に登場することはできない。',
          ]
        ),
        "DCT" => DiceTable::Table.new(
          "因縁表",
          "2D6",
          [
            '対象はあなたの父、もしくは母である。幼い頃に家庭を捨てて失踪した対象を、あなたはずっと憎んでいた。対象への《敵意》が1点上昇する。また、対象を戦闘で倒した際に、経験点10点を得ることができる。',
            '対象は、あなたの小学校時代の恩師である。懐かしい顔にこんな形で会うことになろうとは。対象への《好意》もしくは《敵意》が1点上昇する。',
            '対象は、過去にあなたと戦い、あなたの体に古傷を残している。今でもときどき傷は代償を求めて疼く。対象への《敵意》が1点上昇する。',
            'あなたは対象に憧れているが、全く相手にされていない。たとえ敵としてでも対象に認めてもらうことがあなたの願いだ。彼または彼女への《敵意》が1点上昇し、「ライバル」の人間関係を結ぶことが出来れば経験点を10得られるようになる。',
            'あなたは過去、対象のせいで、思い出したくもない大失敗をしたことがある。嫌いなものに絡んだ大失敗を設定すること。対象への《敵意》が1点上昇する。',
            'あなたは対象に手酷く敗北したことがある。あなたは屈辱を晴らすためにできる限りのことをする気でいる。対象への《敵意》が1点上昇する。',
            '対象はあなたの親族を殺した。あなたはいつか訪れる復讐の日を信じて、鍛錬を続けてきた。対象への《敵意》が1点上昇する。',
            '対象は、過去のあなたの仲間だ。意見の違いで袂を分かったが、ここまで対立することになるとは考えてもいなかった。対象への《敵意》が1点上昇する。',
            '対象とあなたは、前世があなたの妻/夫であった。幸せな生涯の記憶が蘇る。対象への《好意》が1点上昇する。',
            'あなたは対象とあなたの通勤・通学路でぶつかったことがあり、そこで一目惚れしている。恋を幸せに成就させるため、もしくは不幸な恋を対象の死によって終わらせるため、あなたは迷宮にめぐる。対象への愛情の《好意》4点と、「片思い」の人間関係を得る。',
            'あなたは過去に対象の恋人であった。対象のどこが好きだったのかは、自分の好きなものからランダムに単語を決め、それに関連した話をでっち上げること。対象への愛情の《好意》4点と、「恋人」の人間関係を得る。',
          ]
        ),
        "MCT" => DiceTable::Table.new(
          "怪物因縁表",
          "2D6",
          [
            '対象はあなたの故郷を滅ぼした。そこは、もうペンペン草すら生えない廃墟となっている。対象への《敵意》が4点上昇する。',
            '対象はあなたのDNA情報をもとに某国が作り出したものである。GMは対象にあなたのスキルから1つを任意に選んで修得させる。対象への《敵意》が1点上昇する。',
            'あなたはかつて対象の同族を絶滅させた。しかし、奴らは死んではいなかったのだ。対象への《敵意》が1点上昇する。',
            'あなたは幼いころに対象と遭遇したが、一顧だにされず見逃された。対象への《敵意》が1点上昇する。',
            '何年も前に死んだ、あなたの親しい人は、ちょうど対象の攻撃手段と同じ方法で殺されている。対象への《敵意》が1点上昇する。',
            '対象はなんとなくあなたが嫌いな特徴をそなえている。嫌いなものに関連した特徴を設定すること。対象への《敵意》が1点上昇する。',
            'あなたは過去に対象と戦い、完敗を喫している。対象への《敵意》が1点上昇する。対象との戦闘に勝利した場合、経験点10点を得る。',
            '対象はあなたの好きなものを穢したり貶めたことがある。好きなものにちなんだ出来事を設定すること。対象への《敵意》が1点上昇する。',
            'あなたは、対象が同族のなかでも強力な個体であることを知っている。対象への《敵意》が2点上昇する。対象の《HP》と威力を6点ずつ上昇させる。',
            '対象はあなたが昔飼っていた生き物や持っていたものが変化したものである。対象への《好意》と《敵意》が1点ずつ上昇する。交渉によって対象との戦闘を終わらせた場合、経験点10点を得る。',
            'かつてあなたは対象と同族であった。対象への《好意》と《敵意》が1点ずつ上昇する。',
          ]
        ),
        "PCT" => DiceTable::Table.new(
          "PC因縁表",
          "2D6",
          [
            '対象はあなたが追い求めていた敵だった。なぜ敵なのか設定すること。対象への《敵意》が4点上昇する。対象を殺害すると経験点100点を得る。',
            '対象は、あなたがあなたのクラスになるきっかけを作った人物である。1分以内に詳細を設定できれば対象への好きな感情値を2点上昇させてよい。',
            '対象と共通の知人がいることが発覚する。好きなものにちなんだ知人を設定すること。対象への《好意》が1点上昇する。',
            '対象と同じ場所に住んでいたり、通っていたことが分かる。対象への《好意》が1点上昇する。',
            'あなたは何らかの種類の迷宮屋ランキングで対象に負けている。対象への《敵意》が1点上昇する。終了フェイズで対象に（何でもいいので）負けを認めさせれば、経験点を1点獲得する。',
            '対象は、なんとなくあなたの好きな特徴を備えているような気がする。好きなものにちなんだ特徴を1つ設定し、対象のプレイヤーの了解をとること。チャンスは１回だ。ＯＫなら対象への《好意》が1点上昇する。',
            '対象は何らかの媒体で、あなたに対して好意的でないコメントを出したことがあるような気がする。コメントの詳細はあなたが決定すること。対象への《敵意》が１点上昇する。',
            'あなたは対象に関する良い噂を聞いたことがある。噂の内容を決定したうえで、対象への《好意》が1点上昇する。',
            '対象は実は幼馴染だったことが明らかになる。容姿の変化などで気付かなかったのだ。対象への《好意》が1点上昇する。',
            '対象が実は兄弟であったことが明らかになる。家庭の事情を1分で考えだせれば、対象への《好意》が1点上昇する。',
            'あなたと対象は、今まで隠していたが実はつきあっている。対象のプレイヤーの了解を15秒以内にとることができれば、お互いへの愛情の《好意》を4点上昇させることができる。',
          ]
        ),
        "LCT" => DiceTable::Table.new(
          "ラブ因縁表",
          "2D6",
          [
            'あなたは対象と過去にいい友人だった。対象への《好意》が2点上昇するが、その属性は友情に変化する。',
            'あなたは対象を本来とは別の性別だと思い込んで片思いしていた。対象への《敵意》が2点、または《好意》が1点上昇する。',
            'あなたはかつて親友であった対象に恋人を奪われたことがある。対象への《敵意》が1点上昇する。',
            '対象は、あなたの好きなものによく似ている。好きなものから１つを選んで、どう似ているか説明できたら、対象への《好意》が1点上昇する。',
            '対象をよく見たらけっこう可愛いような気がしてきた。対象への《好意》が1点上昇し、対象への《好意》をすべて愛情に変換する。',
            'あなたは対象と過去につきあっていたことがある。現在はどうだか分からないが、あのころは本気だった。対象への《好意》が1点上昇する。',
            '対象は、むかしあなたが好きだった人と印象がよく似ている。対象への《好意》が1点上昇する。',
            'あなたは対象に助けられたり、命を救われたことがある。１分以内に設定を作り上げられれば、対象への《好意》が1点上昇する。',
            'あなたは対象に振られ、失意のあまり自殺しようとしたことがある。対象への《好意》と《敵意》が1点上昇する。',
            'あなたは昔から、対象を独占したいと思っていた。対象があなた以外と関わるたびに怒りを募らせていたのだ。対象への《好意》と《敵意》が2点ずつ上昇する。',
            'なんだか良く分からないが、とにかく好きでたまらない。対象への《好意》が3点上昇し、対象への《好意》をすべて愛情に変換する。'
          ]
        ),
        "MPT" => DiceTable::Table.new(
          "相場表",
          "2D6",
          [
            'なし',
            '肉',
            '牙',
            '鉄',
            '魔素',
            '機械',
            '衣料',
            '木',
            '火薬',
            '情報',
            '革',
          ]
        ),
        "T1T" => DiceTable::Table.new(
          "お宝１表",
          "1D6",
          [
            '何もなし。',
            '何もなし。',
            'そのモンスターの素材欄の中から、好きな素材を1個。',
            'そのモンスターの素材欄の中から、好きな素材を2個。',
            'そのモンスターの素材欄の中から、好きな素材を3個。',
            '【お弁当】1個。',
          ]
        ),
        "T2T" => DiceTable::Table.new(
          "お宝２表",
          "1D6",
          [
            'そのモンスターの素材欄の中から、好きな素材を3個。',
            'そのモンスターの素材欄の中から、好きな素材を4個。',
            'そのモンスターの素材欄の中から、好きな素材を5個。',
            'ランダムな回復アイテム1個。',
            'ランダムな武具アイテム1個。そのアイテムにレベルがあれば、レベル1のアイテムとなる。',
            'ランダムなレアアイテム1個。',
          ]
        ),
        "T3T" => DiceTable::Table.new(
          "お宝３表",
          "1D6",
          [
            'そのモンスターの素材欄の中から、好きな素材を5個。',
            'そのモンスターの素材欄の中から、好きな素材を7個。',
            'そのモンスターの素材欄の中から、好きな素材を10個。',
            '好きなコモンアイテムのカテゴリ1種を選ぶ。そのカテゴリの中からランダムなアイテム1個。そのアイテムにレベルがあれば、レベル1のアイテムとなる。',
            'ランダムなレアアイテム1個',
            'ランダムなレアアイテム1個。そのアイテムにレベルがあれば、レベル1のアイテムとなる。',
          ]
        ),
        "T4T" => DiceTable::Table.new(
          "お宝４表",
          "1D6",
          [
            'そのモンスターの素材欄の中から、好きな素材を5個。',
            'そのモンスターの素材欄の中から、好きな素材を10個。',
            '好きなコモンアイテムのカテゴリ1種を選ぶ。そのカテゴリの中からランダムなアイテム1個。そのアイテムにレベルがあれば、レベル2のアイテムとなる。',
            '好きなコモンアイテムのカテゴリ1種を選ぶ。そのカテゴリの中からランダムなアイテム1個。そのアイテムにレベルがあれば、レベル3のアイテムとなる。',
            'ランダムなレアアイテム1個。そのアイテムにレベルがあれば、レベル1のアイテムとなる。',
            'ランダムなレアアイテム1個。そのアイテムにレベルがあれば、レベル2のアイテムとなる。',
          ]
        ),
      }.freeze

      register_prefix('\d+MD6?', '\d+R6', TABLES.keys)
    end
  end
end
