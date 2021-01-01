# frozen_string_literal: true

module BCDice
  module GameSystem
    class OneWayHeroics < Base
      class GoldFlow
        def initialize(times, action)
          @times = times
          @action = action
        end

        def roll(randomizer)
          dice_list = randomizer.roll_barabara(@times, 6)
          dice_total = dice_list.sum()
          gold = dice_total * 100

          sequence = [
            "#{@times}D6に100を掛け、それだけの【所持金】を#{@action}",
            "#{@times}D6[#{dice_list.join(',')}]*100",
            "【所持金】#{gold} を#{@action}"
          ]

          return sequence.join(" ＞ ")
        end
      end

      class StatusDown
        def initialize(status, times)
          @status = status
          @times = times
        end

        def roll(randomizer)
          dice_list = randomizer.roll_barabara(@times, 6)
          total = dice_list.sum()

          sequence = [
            "#{@status}が#{@times}D6減少する",
            "#{@times}D6[#{dice_list.join(',')}]",
            "#{@status}が #{total} 減少する"
          ]

          return sequence.join(" ＞ ")
        end
      end

      class MoveToTable
        def initialize(text, table_key)
          @text = text
          @table_key = table_key
        end

        def roll(randomizer)
          <<~RESULT.chomp
            #{@text} ＞
             #{@table_key} ＞ #{TABLES[@table_key].roll(randomizer)}
          RESULT
        end
      end

      TABLES = {
        "FT" => DiceTable::ChainTable.new(
          "ファンブル表",
          "1D6",
          [
            "装備以外のアイテムのうちプレイヤー指定の１つを失う",
            "装備のうちプレイヤー指定の１つを失う",
            GoldFlow.new(1, "失う"),  # "1D6に100を掛け、それだけの【所持金】を失う",
            GoldFlow.new(1, "拾う"),  # "1D6に100を掛け、それだけの【所持金】を拾う",
            "【経験値】２を獲得する",
            "【経験値】４を獲得する",
          ]
        ),
        "DC" => DiceTable::ChainTable.new(
          "魔王追撃表",
          "1D6",
          [
            "装備以外のアイテムのうちＧＭ指定の１つを失う",
            "装備のうちＧＭ指定の１つを失う",
            GoldFlow.new(2, "失う"),  # "2D6に100を掛け、それだけの【所持金】を失う",
            StatusDown.new("【ＬＩＦＥ】", 1), # 【ＬＩＦＥ】が1D6減少する
            StatusDown.new("【ＳＴ】", 1), # 【ＳＴ】が1D6減少する
            StatusDown.new("【ＬＩＦＥ】", 2) # 【ＬＩＦＥ】が2D6減少する
          ]
        ),
        "PR" => DiceTable::Table.new(
          "進行ルート表",
          "1D6",
          [
            "少し荒れた地形が続く。【日数】から【筋力】を引いただけ【ＳＴ】が減少する（最低０）",
            "穏やかな地形が続く。【日数】から【敏捷】を引いただけ【ＳＴ】が減少する（最低０）",
            "険しい岩山だ。【日数】に１を足して【生命】を引いただけ【ＳＴ】が減少する（最低０）「登山」",
            "山で迷った。【日数】に２を足して【知力】を引いただけ【ＳＴ】が減少する（最低０）「登山」",
            "川を泳ぐ。【日数】に１を足して【意志】を引いただけ【ＳＴ】が減少する（最低０）「水泳」",
            "広い川を船で渡る。【日数】に２を足して【魅力】を引いただけ【ＳＴ】が減少する（最低０）「水泳」"
          ]
        ),
        "TT" => DiceTable::Table.new(
          "会話テーマ表",
          "1D6",
          [
            "身体の悩みごとについて話す。【筋力】で判定。",
            "仕事の悩みごとについて話す。【敏捷】で判定。",
            "家族の悩みごとについて話す。【生命】で判定。",
            "勇者としてこれでいいのか的悩みごとを話す。【知力】で判定。",
            "友人関係の悩みごとを話す。【意志】で判定。",
            "恋の悩みごとを話す。【魅力】で判定。"
          ]
        ),
        "EC" => DiceTable::Table.new(
          "逃走判定表",
          "1D6",
          [
            "崖を登れば逃げられそうだ。【筋力】を使用する。",
            "障害物はない。走るしかない。【敏捷】を使用する。",
            "しつこく追われる。【生命】を使用する。",
            "隠れられる地形がある。【知力】を使用する。",
            "背中を向ける勇気が出るか？　【意志】を使用す",
            "もう人徳しか頼れない。【魅力】を使用する。"
          ]
        ),
        "RNPC" => DiceTable::Table.new(
          "ランダムNPC特徴表",
          "2D6",
          [
            "【物持ちの】",
            "【目のいい】",
            "【弱そうな】",
            "【宝石好きな】",
            "【エッチな】",
            "【ケチな】",
            "【変態の】",
            "【金持ちの】",
            "【強そうな】",
            "【目の悪い】",
            "【すばやい】"
          ]
        ),
        "SCT" => DiceTable::Table.new(
          "偵察表",
          "1D6",
          [
            "山に突き当たる。「登山」判定：【筋力】　ジャッジ：山を登る描写。",
            "川を流れ下る。「水泳」判定：【敏捷】　ジャッジ：川でピンチに陥る描写。",
            "広い湖だ……。「水泳」判定：【生命】　ジャッジ：湖面を泳ぐ描写。",
            "山の楽なルートを探そう。「登山」判定：【知力】　ジャッジ：山の豆知識。",
            "迫る闇から恐怖のあまり目を離せない。判定：【意志】　ジャッジ：勇者としての決意。",
            "任意のＮＰＣに会って情報を聞く。判定：【魅力】　ジャッジ：相手を立てる会話。"
          ]
        ),
        "FCLT" => DiceTable::Table.new(
          "施設表",
          "2D6",
          [
            "聖なる神殿（１５２ページ）。",
            "魔王の力を封じた神殿（１５２ページ）。",
            "耳長たちの村（１５２ページ）。",
            "「村遭遇表」へ移動。大きな街なので村遭遇表を２回使用し、好きな結果を選べる。",
            "「村遭遇表」へ移動。小さな村だ。",
            "エリアの地形が「雪原」なら雪国の小屋（１５２ページ）。エリアの地形が「山岳」なら山小屋（１５２ページ）。それ以外の地形なら「村遭遇表」へ移動。この村は「石の小屋」だ。",
            "村遭遇表」へ移動。小さな村だ。",
            "村遭遇表」へ移動。大きな街なので村遭遇表を２回使用し、好きな結果を選べる。",
            "滅びた石の小屋（１５２ページ）。",
            "滅びた小さな村（１５２ページ）。",
            "闇ギルド（１５２ページ）。"
          ]
        ),
        "FCLTP" => DiceTable::D66Table.new(
          "施設表プラス",
          D66SortType::ASC,
          {
            11 => "聖なる神殿（基本１５２ページ）",
            12 => "魔王の力を封じた神殿（基本１５２ページ）",
            13 => "耳長たちの村（基本１５２ページ）判定成功時に【耳長の軽い弓】【耳長の杖】を購入可能",
            14 => "村遭遇表へ移動（基本１５１ページ）大きな街なので村遭遇表を2回振り、好きな結果を選べる",
            15 => "村遭遇表へ移動（基本１５１ページ）小さな村",
            16 => "エリアの地形が雪原なら雪国の小屋（基本１５２ページ）エリアの地形が山岳なら山小屋（基本１５２ページ）それ以外の地形なら石の小屋、村遭遇表へ移動（基本１５１ページ）",
            22 => "村遭遇表へ移動（基本１５１ページ）小さな村",
            23 => "村遭遇表へ移動（基本１５１ページ）大きな街なので村遭遇表を2回振り、好きな結果を選べる",
            24 => "滅びた石の小屋（基本１５２ページ）",
            25 => "滅びた小さな村（基本１５２ページ）",
            26 => "闇ギルド（基本１５２ページ）判定成功時に一度だけ【闇ギルド袋屋】に３０００シルバ支払い【所持重量】を１増加することができる。",
            33 => "小さな店遭遇表プラスへ移動（０２３ページ）",
            34 => "酒場遭遇表プラスへ移動",
            35 => "酒場遭遇表プラスへ移動",
            36 => "錬金おばばの家（０２４ページ）",
            44 => "鍛冶屋の家（０２４ページ）",
            45 => "半獣人の隠れ家（０２４ページ）",
            46 => "罪人の街（０２４ページ）",
            55 => "封印の街（０２４ページ）",
            56 => "水上の街（０２４ページ）",
            66 => "人魚の集落（０２４ページ）",
          }
        ),
        "OUTENC" => DiceTable::ChainTable.new(
          "野外遭遇表",
          "1D6",
          [
            MoveToTable.new("エリアの地形ごとの野外モンスター表へ移動。モンスターのうち１体にランダムな特徴がつく。モンスター特徴表（１５６ページ）を使用する。", "MONFT"),
            "エリアの地形ごとの野外モンスター表へ移動",
            "エリアの地形ごとの野外モンスター表へ移動",
            "アンデッドの群れ（１５６ページ）",
            "盗賊の群れ（１５６ページ）",
            MoveToTable.new("希少動物表（基本１５６ページ）へ移動", "RANI"),
          ]
        ),
        "OUTENCP" => DiceTable::ChainTable.new(
          "野外遭遇表プラス",
          "1D6",
          [

            MoveToTable.new("エリアの地形ごとの野外モンスター表プラスへ移動。モンスターのうち1体にランダムな特徴がつく。モンスター特徴表プラス（０２７ページ）を使用する。", "MONFTP"),
            "エリアの地形ごとの野外モンスター表プラスへ移動し、出現したモンスターとの戦闘が発生する",
            "スライムモンスター表プラス（０２７ページ）へ移動",
            "アンデッドの群れ（基本１５６ページ）",
            "盗賊の群れ（基本１５６ページ）",
            MoveToTable.new("希少動物表（基本１５６ページ）へ移動", "RANI"),
          ]
        ),
        "MONFT" => DiceTable::D66Table.new(
          "モンスター特徴表",
          D66SortType::ASC,
          {
            11 => "【エッチな】",
            12 => "【変態の】",
            13 => "【弱そうな】",
            14 => "【目のいい】",
            15 => "【目の悪い】",
            16 => "【強そうな】",
            22 => "【強そうな】",
            23 => "【宝石好きな】",
            24 => "【幻の】",
            25 => "【違法な】",
            26 => "【イカした】",
            33 => "【物持ちの】",
            34 => "【炎を吐く】",
            35 => "【必中の】",
            36 => "【すばやい】",
            44 => "【やたら硬い】",
            45 => "【名の知れた】",
            46 => "【凶悪な】",
            55 => "【賞金首の】",
            56 => "【古代種の】",
            66 => "【最強の】",
          }
        ),
        "MONFTP" => DiceTable::D66Table.new(
          "モンスター特徴表プラス",
          D66SortType::ASC,
          {
            11 => "【エッチな】（基本１７８ページ）",
            12 => "【変態の】（基本１７８ページ）",
            13 => "【目のいい】（基本１７８ページ）",
            14 => "【目の悪い】（基本１７８ページ）",
            15 => "【強そうな】（基本１７８ページ）",
            16 => "【宝石好きな】（基本１７８ページ）",
            22 => "【幻の】（基本１７８ページ）",
            23 => "【違法な】（基本１７８ページ）",
            24 => "【イカした】（基本１７８ページ）",
            25 => "【物持ちの】（基本１７８ページ）",
            26 => "【炎を吐く】（基本１７８ページ）",
            33 => "【やたら硬い】（基本１７８ページ）",
            34 => "【古代種の】（基本１７８ページ）",
            35 => "【最強の】（基本１７８ページ）",
            36 => "【異国風の】（０４７ページ）",
            44 => "【毛深い】（０４７ページ）",
            45 => "【耐火の】（０４７ページ）",
            46 => "【耐雷の】（０４７ページ） ",
            55 => "【浮遊の】（０４７ページ）",
            56 => "【臭い】（０４７ページ）",
            66 => "【恐怖の】（０４７ページ）",
          }
        ),
        "RANI" => DiceTable::RangeTable.new(
          "希少動物表",
          "1D6",
          [
            [1, "【『緑の森』隊長】1体と遭遇する。今回のセッションで【雪ウサギ】【山岳ゴート】【遺跡白馬】【草原カワウソ】【砂漠キツネ】のいずれかを倒したことがあれば、戦闘が発生する。戦闘にならなかった場合はなごやかに別れる。"],
            [2..3, "【『緑の森』団員】1体と遭遇する。今回のセッションで【雪ウサギ】【山岳ゴート】【遺跡白馬】【草原カワウソ】【砂漠キツネ】のいずれかを倒したことがあれば、戦闘が発生する。戦闘にならなかった場合はなごやかに別れる。"],
            [4..6, "地形によって異なる希少動物が1体出現する。雪原なら【雪ウサギ】、山岳なら【山岳ゴート】、遺跡なら【遺跡白馬】、草原なら【草原カワウソ】、砂漠と荒野は【砂漠キツネ】。それ以外は【緑の森団員】となる。戦闘を挑んでもいいし、見送ってもいい。"]
          ]
        ),
        "DROP" => DiceTable::ChainTable.new(
          "ドロップアイテム表",
          "1D6",
          [
            MoveToTable.new("武器ドロップ表へ移動", "DROPWP"),
            MoveToTable.new("武器ドロップ表へ移動", "DROPWP"),
            MoveToTable.new("防具ドロップ表へ移動", "DROPAR"),
            MoveToTable.new("食品ドロップ表へ移動", "DROPFD"),
            MoveToTable.new("巻物ドロップ表へ移動", "DROPSC"),
            MoveToTable.new("その他ドロップ表へ移動", "DROPOT"),
          ]
        ),
        "DROPWP" => DiceTable::D66Table.new(
          "武器ドロップ表",
          D66SortType::ASC,
          {
            11 => "【さびた小剣】",
            12 => "【さびた長剣】",
            13 => "【さびた大剣】",
            14 => "【長い棒】",
            15 => "【ダガー】",
            16 => "【木こりの大斧】",
            22 => "【ショートブレイド】",
            23 => "【木の杖】",
            24 => "【狩人の弓】",
            25 => "【レイピア】",
            26 => "【携帯弓】",
            33 => "【ロングブレイド】",
            34 => "【スレンドスピア】",
            35 => "【バトルアックス】",
            36 => "【軍用剛弓】",
            44 => "【グランドブレイド】",
            45 => "【祈りの杖】",
            46 => "【ヘビィボウガン】",
            55 => "【シルバーランス】",
            56 => "【イーグルブレイド】",
            66 => "【クレセントアクス】"
          }
        ),
        "DROPAR" => DiceTable::D66Table.new(
          "防具ドロップ表",
          D66SortType::ASC,
          {
            11 => "【旅人の服】",
            12 => "【旅人の服】",
            13 => "【旅人の服】",
            14 => "【レザーシールド】",
            15 => "【レザーシールド】",
            16 => "【騎士のコート】",
            22 => "【騎士のコート】",
            23 => "【スケイルシールド】",
            24 => "【スケイルシールド】",
            25 => "【レザーベスト】",
            26 => "【レザーベスト】",
            33 => "【ヘビィシールド】",
            34 => "【チェインクロス】",
            35 => "【チェインクロス】",
            36 => "【試練の腕輪】",
            44 => "【精霊のローブ】",
            45 => "【必殺の腕輪】",
            46 => "【ギガントプレート】",
            55 => "【破壊の腕輪】",
            56 => "【理力の腕輪】",
            66 => "【加速の腕輪】"
          }
        ),
        "DROPHW" => DiceTable::Table.new(
          "聖武具ドロップ表",
          "2D6",
          [
            "【紅き太陽の剣】",
            "【紅き太陽の剣】",
            "【聖剣カレドヴルフ】 ",
            "【聖斧エルサーベス】 ",
            "【水霊のマント】",
            "【大地の鎧】",
            "【大気の盾】",
            "【聖弓ル・アルシャ】",
            "【聖槍ヴァルキウス】",
            "【聖なる月の剣】",
            "【聖なる月の剣】"
          ]
        ),
        "DROPFD" => DiceTable::D66Table.new(
          "食品ドロップ表",
          D66SortType::ASC,
          {
            11 => "【枯れた草】",
            12 => "【こげた草】",
            13 => "【サボテンの肉】",
            14 => "【動物の肉】",
            15 => "【癒しの草】、地形が火山なら【こげた草】",
            16 => "【癒しの草】、地形が火山なら【こげた草】、地形が雪原なら【スノークリスタ草】",
            22 => "【スタミナ草】、地形が火山なら【こげた草】",
            23 => "【スタミナ草】、地形が火山なら【こげた草】、地形が雪原なら【スノークリスタ草】",
            24 => "【触手の草】、地形が火山なら【こげた草】",
            25 => "【触手の草】、地形が火山なら【こげた草】、地形が雪原なら【スノークリスタ草】",
            26 => "【スタミナのアンプル】",
            33 => "【癒しのアンプル】",
            34 => "【癒しのアンプル】",
            35 => "【ナユタの実】、地形が火山なら【こげた草】",
            36 => "【ナユタの実】、地形が火山なら【こげた草】",
            44 => "【火炎のアンプル】",
            45 => "【強酸のアンプル】",
            46 => "【とぶクスリ】",
            55 => "【竜炎のアンプル】",
            56 => "【おいしいお弁当】",
            66 => "【自然治癒のアンプル】"
          }
        ),
        "DROPSC" => DiceTable::D66Table.new(
          "巻物ドロップ表",
          D66SortType::ASC,
          {
            11 => "【石壁の巻物】",
            12 => "【石壁の巻物】",
            13 => "【周辺の地図】",
            14 => "【周辺の地図】",
            15 => "【周辺の地図】",
            16 => "【火炎付与の巻物】",
            22 => "【混乱の巻物】",
            23 => "【剣の巻物】",
            24 => "【剣の巻物】",
            25 => "【鎧の巻物】",
            26 => "【鎧の巻物】",
            33 => "【応急修理の巻物】",
            34 => "【応急修理の巻物】",
            35 => "【移動不能付与の巻物】",
            36 => "【移動不能付与の巻物】",
            44 => "【宝の地図】",
            45 => "【宝の地図】",
            46 => "【召喚の巻物】",
            55 => "【剣の王の巻物】",
            56 => "【守りの神の巻物】",
            66 => "【高度修復の巻物】"
          }
        ),
        "DROPOT" => DiceTable::D66Table.new(
          "その他ドロップ表",
          D66SortType::ASC,
          {
            11 => "【大きな石】、地形が火山なら【くすんだ宝石】",
            12 => "【大きな石】、地形が火山なら【くすんだ宝石】",
            13 => "【大きな石】、地形が火山なら【美しい宝石】",
            14 => "【木製の矢】",
            15 => "【理力の矢】",
            16 => "【鉄製の矢】",
            22 => "【投げナイフ】",
            23 => "【爆弾矢】",
            24 => "【くすんだ宝石】",
            25 => "【盾修復キット】",
            26 => "【上質の研ぎ石】",
            33 => "【エルザイト爆弾】",
            34 => "【セーブクリスタル】",
            35 => "【試練の腕輪】",
            36 => "【必殺の腕輪】",
            44 => "【破壊の腕輪】",
            45 => "【理力の腕輪】",
            46 => "【加速の腕輪】",
            55 => "【美しい宝石】",
            56 => "【封印のカギ】",
            66 => "【闇ギルド会員証】"
          }
        ),
        "DROPP" => DiceTable::D66Table.new(
          "ドロップアイテム表プラス",
          D66SortType::ASC,
          {
            11 => MoveToTable.new("武器ドロップ表", "DROPWP"),
            12 => MoveToTable.new("武器ドロップ表", "DROPWP"),
            13 => MoveToTable.new("武器ドロップ表2", "DROPWP2"),
            14 => MoveToTable.new("武器ドロップ表2", "DROPWP2"),
            15 => MoveToTable.new("防具ドロップ表", "DROPAR"),
            16 => MoveToTable.new("防具ドロップ表", "DROPAR"),
            22 => MoveToTable.new("防具ドロップ表2", "DROPAR2"),
            23 => MoveToTable.new("防具ドロップ表2", "DROPAR2"),
            24 => MoveToTable.new("食品ドロップ表", "DROPFD"),
            25 => MoveToTable.new("食品ドロップ表", "DROPFD"),
            26 => MoveToTable.new("食品ドロップ表2", "DROPFD2"),
            33 => MoveToTable.new("食品ドロップ表2", "DROPFD2"),
            34 => MoveToTable.new("薬品ドロップ表プラス", "DROPDRP"),
            35 => MoveToTable.new("薬品ドロップ表プラス", "DROPDRP"),
            36 => MoveToTable.new("巻物ドロップ表", "DROPSC"),
            44 => MoveToTable.new("巻物ドロップ表", "DROPSC"),
            45 => MoveToTable.new("巻物ドロップ表2", "DROPSC2"),
            46 => MoveToTable.new("巻物ドロップ表2", "DROPSC2"),
            55 => MoveToTable.new("その他ドロップ表", "DROPOT"),
            56 => MoveToTable.new("その他ドロップ表", "DROPOT"),
            66 => MoveToTable.new("その他ドロップ表2", "DROPOT2")
          }
        ),
        "DROPDRP" => DiceTable::D66Table.new(
          "薬品ドロップ表プラス",
          D66SortType::ASC,
          {
            11 => "【燃料油のビン】",
            12 => "【燃料油のビン】",
            13 => "【燃料油のビン】",
            14 => "【弱体の薬】",
            15 => "【弱体の薬】",
            16 => "【弱体の薬】",
            22 => "【成長の薬】",
            23 => "【ベルセルクアンプル】",
            24 => "【ベルセルクアンプル】",
            25 => "【浮遊の薬】",
            26 => "【浮遊の薬】",
            33 => "【反動解消の薬】",
            34 => "【反動解消の薬】",
            35 => "【癒しの大ボトル】",
            36 => "【癒しの大ボトル】",
            44 => "【超元気のアンプル】",
            45 => "【超元気のアンプル】",
            46 => "【薬命酒】",
            55 => "【薬命酒】",
            56 => "【洗脳のクスリ】",
            66 => "【洗脳のクスリ】"
          }
        ),
        "DROPSC2" => DiceTable::D66Table.new(
          "巻物ドロップ表2",
          D66SortType::ASC,
          {
            11 => "【火炎波の巻物】",
            12 => "【悟りの巻物】",
            13 => "【理盾の巻物】",
            14 => "【泉の巻物】",
            15 => "【雷神の巻物】",
            16 => "【超激震の巻物】",
            22 => "【闇を阻む巻物】",
            23 => "【引きこもりの巻物】",
            24 => "【鋼鉄の巻物】",
            25 => "【回廊の巻物】",
            26 => "【騎士団の巻物】",
            33 => "【水泳能力の巻物】",
            34 => "【浮遊能力の巻物】",
            35 => "【治癒の書】",
            36 => "【浮遊の書】",
            44 => "【突風の書】",
            45 => "【睡眠の書】",
            46 => "【火炎の書】",
            55 => "【鋼鉄の書】",
            56 => "【加速の書】",
            66 => "【闇払いの書】"
          }
        ),
        "DROPWP2" => DiceTable::D66Table.new(
          "武器ドロップ表2",
          D66SortType::ASC,
          {
            11 => "【さびた巨大斧】",
            12 => "【さびた巨大斧】",
            13 => "【モコモコのバトン】",
            14 => "【モコモコのバトン】",
            15 => "【ベルセルクアクス】",
            16 => "【ベルセルクアクス】",
            22 => "【クナイ】",
            23 => "【クナイ】",
            24 => "【術殺槍】",
            25 => "【ウィンドスピア】",
            26 => "【ウィンドスピア】",
            33 => "【つるはし】",
            34 => "【つるはし】",
            35 => "【理力の剣】",
            36 => "【蒼い短刀】",
            44 => "【クリムゾンクロウ】",
            45 => "【ナユタの杖】",
            46 => "【ナユタの杖】",
            55 => "【一撃斧】",
            56 => "【ファイアブランド】",
            66 => "【ソードクロスボウ】"
          }
        ),
        "DROPAR2" => DiceTable::D66Table.new(
          "防具ドロップ表2",
          D66SortType::ASC,
          {
            11 => "【ボロボロの服】",
            12 => "【ボロボロの服】",
            13 => "【穴だらけの鎧】",
            14 => "【穴だらけの鎧】",
            15 => "【木製の追加装甲】",
            16 => "【木製の追加装甲】",
            22 => "【ガラスの鎧】",
            23 => "【ガラスの鎧】",
            24 => "【鉄板の追加装甲】",
            25 => "【鉄板の追加装甲】",
            26 => "【太陽のランタン】",
            33 => "【耐火服】",
            34 => "【獣の革のバッグ】",
            35 => "【重量ブーツ】",
            36 => "【冒険者のブーツ】",
            44 => "【ラバーブーツ】",
            45 => "【風のマント】",
            46 => "【狩人の服】",
            55 => "【ドラゴンスケイル】",
            56 => "【不育の腕輪】",
            66 => "【竜革の大きなバッグ】"
          }
        ),
        "DROPHWP" => DiceTable::D66Table.new(
          "聖武具ドロップ表プラス",
          D66SortType::ASC,
          {
            11 => "【大気の盾】",
            23 => "【聖剣カレドヴルフ】",
            36 => "【紅蓮の書】",
            12 => "【大気の盾】",
            24 => "【聖斧エルサーベス】",
            44 => "【聖弓ル・アルシャ】",
            13 => "【大地の鎧】",
            25 => "【聖斧エルサーベス】",
            45 => "【聖弓ル・アルシャ】",
            14 => "【大地の鎧】",
            26 => "【聖槍ヴァルキウス】",
            46 => "【聖なる月の剣】",
            15 => "【水霊のマント】",
            33 => "【聖槍ヴァルキウス】",
            55 => "【紅き太陽の剣】",
            16 => "【水霊のマント】",
            34 => "【聖槍ヴァルキウス】",
            56 => "【嵐の聖剣】",
            22 => "【聖剣カレドヴルフ】",
            35 => "【紅蓮の書】",
            66 => "【超重の聖斧】"
          }
        ),
        "DROPFD2" => DiceTable::Table.new(
          "食品ドロップ表2",
          "1D6",
          [
            "【解毒の草】、地形が火 山なら【こげた草】、地 形が海岸なら【おいし い海藻】",
            "【気付けの草】、地形が 火山なら【こげた草】、 地形が海岸なら【おい しい海藻】",
            "【夜目の草】",
            "【力が湧く草】",
            "【集中の草】",
            "【牛乳】"
          ]
        ),
        "DROPOT2" => DiceTable::Table.new(
          "その他 ドロップ表2",
          "2D6",
          [
            "【五連の矢】",
            "【炎の矢】",
            "【聖なる投げ刃】",
            "【物体破壊爆弾】",
            "【閃光弾】",
            "【聖なる短剣の破片】",
            "【閃光弾】",
            "【旋風の投げ刃】",
            "【スーパーエルザイト 爆弾】",
            "【炎の矢】",
            "【五連の矢】"
          ]
        ),
        "DROPRAREBOX2" => DiceTable::Table.new(
          "珍しい箱ドロップ表2",
          "2D6",
          [
            "聖武具ドロップ表プラ スへ",
            "【耐久力の結晶】",
            "【偉大な筋力の結晶】",
            "【偉大な敏捷の結晶】",
            "【偉大な生命の結晶】",
            "【竜鱗の追加装甲】",
            "【偉大な魅力の結晶】",
            "【偉大な意志の結晶】",
            "【偉大な知力の結晶】",
            "【スタミナの結晶】",
            "【闇払いの書】"
          ]
        ),
        "KNGFTP" => DiceTable::Table.new(
          "王特徴表プラス",
          "1D6",
          [
            "【力の王の】（０４７ページ）",
            "【力の王の】（０４７ページ）",
            "【疾風の王の】（０４７ページ）",
            "【疾風の王の】（０４７ページ）",
            "【炎の王の】（０４７ページ）",
            "【絶望の王の】（０４７ページ）"
          ]
        ),
      }.freeze
    end
  end
end
