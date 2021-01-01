# frozen_string_literal: true

module BCDice
  module GameSystem
    class MeikyuKingdom
      # 生活散策表(2d6)
      def mk_life_research_table
        get_table_by_2d6([
          "ハグルマ資本主義神聖共和国から使者が現れる。受け入れる場合［生活レベル／９］に成功すると(1d6)ＭＧ獲得。この判定の難易度は、ハグルマとの関係が険悪なら＋２、敵対なら＋４される。使者を受け入れない場合、ハグルマとの関係が１段階悪化する。すでに関係が敵対なら、領土１つを失う",
          "王国の活気にやる気がでる。《気力》+1、もう一度王国フェイズに行動できる",
          "この国の評判を聞いて、旅人がやってくる。このゲームのシナリオの目的を果たしたら、終了フェイズに《民》＋(2d6)人",
          "旅の商人に出会い、昨今の相場を聞く。(2d6)を振り、メモしておく。終了フェイズの収支報告のタイミングに、2d6を振る代わりにその目が出たことにして相場を決定する",
          "主婦たちの井戸端会議によると、生活用品が不足しているらしい。ゲーム中に「革」５個を獲得するたびに《民の声》＋１。終了フェイズの収支報告までに１個も「革」を獲得出来ないと、維持費＋１ＭＧ",
          "食料に対する不安を漏らす民の姿を見かける。ゲーム中に「肉」５個を獲得するたびに《民の声》＋１。終了フェイズの収支報告までに１個も「肉」を獲得出来ないと、維持費＋１ＭＧ",
          "散策の途中、様々な施設が老朽化しているのを発見する。ゲーム中に「木」５個を獲得するたびに《民の声》＋１。終了フェイズの収支報告までに１個も「木」を獲得出来ないと、維持費＋１ＭＧ",
          "お腹の大きくなった女性が、無事戻ったら赤子の名付け親になって欲しいと言う。このゲームのシナリオの目的を果たしたら、終了フェイズに《民》＋(2d6)人",
          "王国内で民とともに汗を流す。［生活レベル／９］の判定に成功すると、（生産施設の数×１）ＭＧを獲得する",
          "「これ、便利だと思うんですけど」　［生活レベル／１１］の判定に成功すると、価格が自国の［生活レベル］以下の生活アイテム１個を１Lvで獲得できる",
          "突然王国に旅人が訪れ、王国の食料庫が乏しくなってくる。［生活レベル／１１］に成功すると、他国から補給を呼んで《民》＋(2d6)人。失敗すると《民》－(2d6)人",
        ])
      end

      # 治安散策表(2d6)
      def mk_order_research_table
        get_table_by_2d6([
          "メトロ汗国から使者が現れる。受け入れる場合、［治安レベル／９］に成功すると《民》＋(2d6)人。失敗すると《民》－(2d6)人。この判定の難易度は、汗国との関係が険悪なら＋２、敵対なら＋４される。使者を受け入れない場合、汗国との関係が１段階悪化する。すでに関係が敵対なら、領土１つを失う",
          "「つまらないものですが、これを冒険に役立ててください……」相場表でランダムに素材１種を選び、それを(1d6)個獲得する",
          "民たちが自分らで、王国を守る相談をしている。この気０無のシナリオの目的を果たしたら、好きなレベルのある施設１軒を選び、その隣の部屋に同じ施設１軒を建設する",
          "毎日の散歩の成果が出て、体の調子が良い。このゲーム中、《ＨＰ》の最大値＋５し、《ＨＰ》５点回復する",
          "王国の民たちが、ランドメイカーの留守を守る人間が少ないことを心配している。ゲーム中に逸材１人を獲得するたびに《民の声》＋１。終了フェイズまでに１人も逸材を獲得出来ないと、維持費＋１ＭＧ",
          "王国周辺の迷宮化が進んでいる。対迷宮化結界を強化せねば…。ゲーム中に「魔素」５個を獲得するたびに《民の声》＋１。終了フェイズの収支報告までに１個も「魔素」を獲得出来ないと、維持費＋１ＭＧ",
          "王国内の施設の稼働率が下がっている。整備が必要そうだ。ゲーム中に「機械」５個を獲得するたびに《民の声》＋１。終了フェイズの収支報告までに１個も「機械」を獲得出来ないと、維持費＋１ＭＧ",
          "周辺諸国の噂を聞く。王国シートの既知の土地欄の中から、関係が同盟・良好・中立の他国があれば、ランダムに国１つを選ぶ、相場表でランダムに素材１種類を選ぶ。その国の相場はその素材となる",
          "王国の平和な光景を見て、手応えを感じる。［治安レベル／９」の判定に成功すると、［公共施設の数×１］ＭＧを獲得する",
          "「迷宮のごかごがありますように……」　［治安レベル／１１］の判定に成功すると、価格が自国の［生活レベル］以下の探索アイテム１個を１Lvで獲得できる",
          "王国の中で不満分子たちがなにやら不穏な話をしているのを耳にする。［治安レベル／１１］の判定に成功すると、あなたは留守中の準備をしておくことができる。そのゲーム中、一度だけ王国災厄表の結果を無効にすることができる。失敗すると、ランダムに施設１軒を選び、それが破壊される",
        ])
      end

      # 文化散策表(2d6)
      def mk_calture_research_table
        get_table_by_2d6([
          "千年王朝から使者が現れる。受け入れる場合、［文化レベル／９］に成功すると《民の声》＋(1d6)、失敗するとすると《民の声》－(1d6)。この判定の難易度は、千年王朝との関係が険悪なら＋２、敵対なら＋４される。使者を受け入れない場合、千年王朝との関係が１段階悪化する。すでに関係が敵対なら、領土１つを失う",
          "民が祭りの準備を進めている。シナリオの目的を果たしていれば、収支報告の時に［収支報告時の《民の声》－ゲーム開始時の《民の声》］ＭＧを獲得できる。ただし、数値がマイナスになった場合は、その分維持費が上昇する",
          "都会に出て行った幼馴染から手紙がくる。王国の様子を知りたがっているようだ。シナリオの目的を果たしたら、終了フェイズにランダムなジョブの逸材１人を獲得する",
          "他のランドおメイカーの噂を聞く。宮廷から好きなキャラクター１人を選び、そのキャラクターに対する《好意》＋１",
          "若者たちの有志が、街を発展させるため諸外国のことを勉強したいと言い出した。ゲーム中に「情報」５個を獲得するたびに《民の声》＋１。終了フェイズの収支報告までに１個も「情報」を獲得出来ないと、維持費＋１ＭＧ",
          "若い娘たちが、流行の衣装について楽しそうに話している。ゲーム中に「衣料」５個を獲得するたびに《民の声》＋１。終了フェイズの収支報告までに１個も「衣料」を獲得出来ないと、維持費＋１ＭＧ",
          "民たちが、君のうわさ話をしている。ゲーム中にあなたにたいして「恋人」「忠義」「親友」の人間関係が成立するたびに《民の声》＋２。終了フェイズの収支報告までに１回も人間関係が成立できないと、維持費＋１ＭＧ",
          "あなたに熱い視線が注がれているのを感じる。宮廷から好きなキャラクター１人を選び、そのキャラクターの自分に対する《好意》＋１",
          "王国内を訪れる旅人たちを見かける。［文化レベル／９］の判定に成功すると、［憩いの施設の数×１］ＭＧを獲得する",
          "「ご無事をお祈りしております……」　［文化レベル／１１］の判定に成功すると、価格が自国の［生活レベル］以下の回復アイテム１個を１Lvで獲得できる",
          "王国の中の民たちの表情に制裁がない。暗い迷宮生活に倦んでいるようだ。［文化レベル／１１］の判定に成功すると民を盛り上げる祭りを開き、《民の声》＋(1d6)。失敗すると維持費＋(1d6)",
        ])
      end

      # 軍事散策表(2d6)
      def mk_army_research_table
        get_table_by_2d6([
          "ダイナマイト帝国から使者が現れる。受け入れる場合、［軍事レベル／９］に成功すると(1d6)ＭＧ獲得、失敗すると維持費＋(1d6)ＭＧ。この判定の難易度は、ダイナマイトとの関係が険悪なら＋２、敵対なら＋４される。使者を受け入れない場合、ダイナマイトとの関係が１段階悪化する。すでに関係が敵対なら、領土１つを失う",
          "長老から迷宮の昔話を聞く。このゲーム中、自分のレベル以下のモンスターを倒すと、そのモンスターをモンスターの《民》にすることができる。この効果は、そのゲーム中に１度だけ使用できる",
          "冒険に向かう君に期待の声がかかる。民たちの期待に、気持ちが引き締まる。このゲーム中、《器》が１点上昇する",
          "くだらないことで口論になる。宮廷の中から１人を選び、互いに対する《敵意》＋１",
          "兵士たちの訓練の様子を見るが、武装がやや乏しい。ゲーム中に「牙」５個を獲得するたびに《民の声》＋１。終了フェイズの収支報告までに１個も「牙」を獲得出来ないと、維持費＋１ＭＧ",
          "旅人から隣国が軍備を拡張していると言う噂を聞く。ゲーム中に「鉄」５個を獲得するたびに《民の声》＋１。終了フェイズの収支報告までに１個も「鉄」を獲得出来ないと、維持費＋１ＭＧ",
          "近隣で凶悪なモンスターたちが大量発生していると言う。ゲーム中に「火薬」５個を獲得するたびに《民の声》＋１。終了フェイズの収支報告までに１個も「火薬」を獲得出来ないと、維持費＋１ＭＧ",
          "周辺諸国で戦争が勃発する。王国シートの既知の土地欄から２つの国を選び、両国間で戦争を行う。それぞれ「領土数＋(1d6)」が戦力。大きい方が勝利して領土１つを獲得し、負けた方の国は領土を１つ失う。どちらかに援軍を送ることができる。［軍事レベル／９＋戦う相手の領土数］の判定に成功すると戦力＋(1d6)。勝敗に関係なく援軍を送った国との関係が１段階友好になり、戦った相手の国との関係が１段階悪化する",
          "隣国からの貢物が届く。［軍事レベル／１１］の判定に成功すると、収支報告の時に価格の（）内の数字が［領土の数×１］以下のレアアイテム１個を獲得する",
          "「こんなものを用意してみました」　［軍事レベル／１１］の判定に成功すると、価格が自国の［生活レベル］以下の武具アイテム１個を１Lvで獲得できる",
          "あなたが他の出発を察知して、何者かが国を襲う！［軍事レベル／１１］の判定に成功するとあなたが他の武勇に歓声が上がり宮廷全員の気力＋(1d6)。失敗すると、宮廷全員の《ＨＰ》と《配下》が(1d6)減少する",
        ])
      end

      # 才覚休憩表（2d6）
      def mk_talent_break_table
        get_table_by_2d6([
          "民との会話の中、経費節約のアイデアが沸く。［才覚/11］の判定に成功すると、維持費が（1d6）MG減少する",
          "嫌いなものが出てくる夢を見て心寂しくなったところに仲間が来てくれる。好きな宮廷内のキャラクター１人への《好意》＋１",
          "好きなものの夢を見る。シチュエーションを表現し、幸せそうだと感じるプレイヤーが居たら《気力》＋２",
          "国に残した家族を心配する民を励ます。［才覚/11］の判定に成功すると、《民の声》＋２",
          "あらん限りの声を力を込めて檄を飛ばす。［才覚/9］の判定に成功すると、宮廷全員のあなたに対する《好意》の合計だけ、《民の声》が回復する",
          "休憩中も休み無く働いていると、配下がお茶を入れてくれる。《民の声》＋１",
          "今後の冒険について口角泡を飛ばして議論する。好きな宮廷内のキャラクター１人を選び、そのキャラの自分に対する《敵意》を好きなだけ上昇させる。上昇した《敵意》と等しい値だけ《民の声》が回復する",
          "たまには料理をしようと思い立つ。【お弁当】か【フルコース】の効果を使用して、食事を取ることが出来る。使用した場合、（1d6）を振る。奇数が出たら料理は美味だった、《民の声》＋１。偶数が出たら料理は非道い味になった、宮廷全員のあなたに対する《敵意》＋１",
          "年若い配下に冒険譚をせがまれる。［才覚/現在の《民の声》の値+3］の判定に成功すると、《民の声》＋（1d6）。失敗すると次の１クォーター行動できない",
          "迷宮に囚われた人々を見つける。助けたいが、食料がやや心配だ。［才覚/9］の判定に成功すると、自分の《配下》＋（1d6）",
          "この迷宮は一筋縄ではいかないようだ。今こそ、用意していたアレが役に立つだろう。自分の習得しているスキル１種を未修得にし、同じスキルグループのスキル１種を修得してもよい。この効果は永続する。",
        ])
      end

      # 魅力休憩表（2d6）
      def mk_charm_break_table
        get_table_by_2d6([
          "妖精のワイン倉を発見し、酒盛りが始まる。宮廷全員の《気力》＋１。［魅力/9］の判定に失敗すると、あなたは脱ぎ出す。（1d6）を振り、奇数なら宮廷全員のあなたに対する《好意》＋１、偶数なら《敵意》＋１",
          "休憩中、意外な寝言を言ってしまう。自分を除く宮廷全員は自分に対する《好意》と《敵意》を入れ替えることが出来る。また、その属性を自由に変更することができる",
          "床の冷たさから、ぬくもりを求めて身体を寄せ合う。あなたに《好意》を持っているキャラの数だけ《気力》と《HP》が回復する",
          "こっそり二人で抜け出して良い雰囲気に。その部屋の中に、好きなものが同じキャラが居ればそのキャラ１体を選び、互いに対する《好意》＋１",
          "星の灯りがあなたの顔をロマンチックに照らし出す。その部屋にいる好きなキャラ１体を選び、［魅力/そのキャラのあなたに対する《好意》+9］の判定に成功すると、そのキャラのあなたに対する《好意》＋１",
          "あいつと目が合う。［魅力/9］の判定に成功したら、宮廷内からランダムに１体選び、そのキャラから自分への《好意》か、または自分のそのキャラへの《好意》いづれかが＋１される",
          "うたた寝をしていると誰かが毛布を掛けてくれた。ランダムにキャラを選び、自分のそのキャラへの《好意》＋１",
          "たき火を囲みながら会話を楽しむ。GMの左隣にいるプレイヤーから順番に、自分のPCが《好意》を持っているキャラ１体を選ぶ。選ばれたキャラは《気力》＋１。誰からも選ばれなかったキャラは《気力》－１、ランダムに選んだ宮廷内のキャラへの《敵意》＋１",
          "着替えを覗かれる。宮廷内からランダムに１体選び、（1d6）を振る。奇数なら大声をだしてしまい宮廷全員のそのキャラに対する《敵意》＋１、偶数ならそのキャラとあなたの互いの《好意》＋１",
          "食べ物の匂いにつられたモンスターと遭遇する。ランダムエンカウント表でモンスターを決定する。［魅力/モンスターの中で最も高いレベル+3］の判定に成功した場合、そのモンスターたちと取引できる。失敗した場合戦闘に突入する",
          "ふとした拍子に唇が触れあう。好きなキャラ１体を選ぶ。そのキャラの自分以外への《好意》の合計を全て自分に対する《好意》に加える。その後、自分以外への《好意》を０にする",
        ])
      end

      # 探索休憩表（2d6）
      def mk_search_break_table
        get_table_by_2d6([
          "一休みの前に道具の手入れ。ランダムに自分のアイテムスロット１つを選ぶ。そのスロットにレベルがあるアイテムがあった場合、そのアイテムのレベルが１上がる",
          "寝床を探していたらアルコープの奥の宝箱を見つける。［探索/11］の判定に成功したら好きな素材１種類を（1d6）個手に入れる",
          "一眠りしたら夢の中で…。［探索/11］の判定に成功したら、好きな部屋のモンスターの名前とトラップの数をGMから教えてもらえる",
          "配下が眠りにつき、静寂が訪れると隣の部屋から妙な物音が聞こえてきた。隣接する好きな部屋を選ぶ。［探索/10］の判定に成功すると、その部屋にモンスターがいるかどうか、いる場合はモンスターの種類と数が分かる",
          "一休みしようと持ったら、モンスターの墓場を発見した。好きな素材を１種類えらび、宮廷全員のあなたにたいする《好意》の合計に等しい個数だけその素材を入手する",
          "この部屋はなぜか落ち着く。もしもその部屋の中にあなたの好きなものがあれば《気力》を（1d6）点回復することができる",
          "壁に書かれた奇妙な壁画が、あなたを見つめている気がする…。［探索/9］の判定に成功したら、【エレベータ】を発見する",
          "白骨化した先客の死体が見つかる。使えそうな装備はありがたく頂戴しておこう。［探索/11］の判定に成功したら、コモンアイテムのカテゴリの中から好きなものを１つ選び、そのカテゴリのアイテムをランダムで１個手に入れる",
          "星の灯りで地図を眺める…部屋の構造からして、この辺りに何かありそうだ。［探索/10］の判定に成功すると、この部屋に仕掛けられたイベント型のトラップを全て発見する",
          "休んでいる間にトイレにいきたくなった。［探索/11］の判定に成功すると、迷宮のほころびを見つける。このゲームの間、この部屋から迷宮の外へ帰還することができる",
          "こ、これは秘密の扉？［探索/11］の判定に成功すると、この部屋に隣接する好きな部屋に通路を延ばすことができる",
        ])
      end

      # 武勇休憩表（2d6）
      def mk_valor_break_table
        get_table_by_2d6([
          "時が満ちるにつれ、闘志が高まる。現在の経過ターン数と等しい数だけ《気力》が回復する",
          "もっと敵と戦いたい、血に飢えた自分を発見する。［武勇/11］の判定に成功すると《気力》が１点、《ＨＰ》が（1d6）点回復する",
          "部屋の片隅にうち捨てられた亡骸を発見する。このマップの支配者の名前が分かっていれば、宮廷全員は支配者への《敵意》を１点上昇させることができる",
          "部屋の隅に隠れていた怪物が襲いかかってきた。［武勇/10］の判定に成功すると怪物を追い払い《民の声》＋１。失敗すると自分の《配下》－（1d6）、《民の声》－１",
          "あいつの短剣がきみの横をかすめて毒蛇を追い払う。好きなキャラ１体を選び、そのキャラに対する《敵意》の分だけ《好意》を上昇させ、その後《敵意》を０にする",
          "実力を付けてきたアイツへとドス黒い気持ちがわき上がる。好きなキャラ１体を選び、そのキャラへの《敵意》＋１",
          "ちょっとした行き違いから軽い口論になる。宮廷内からランダムにキャラ１体を選び、そのキャラとあなたの互いへの《敵意》＋１",
          "ライバルの活躍が気になる。宮廷全員の中で、最も高いあなたに対する《敵意》の値と同じ数だけ《気力》を獲得する",
          "休むべきときにしっかり休む。《ＨＰ》を（2d6）点回復することができる",
          "怪物のいた痕跡を発見する。［武勇/11］の判定を行い、成功するとＧＭからこのゲームで遭遇する予定の、まだ種類の分かっていないモンスターを１種類教えてもらえる",
          "殺気に反応し飛び起きた！ランダムエンカウント表でモンスターを決定し戦闘を行う。そのモンスターを倒した後、ランダムにレアアイテム１個を手に入れる",
        ])
      end

      # お祭り休憩表(2D6)
      def mk_festival_break_table
        get_table_by_2d6([
          "お祭りに向かう旅人たちとすれ違う。1D6MGが手に入る【宿屋】か【夜店】があれば、さらにもう1D6MGが手に入る",
          "なんでこんなときに、ダンジョンに行かなきゃいけないんだ！　「あ、電報でーす」このマップの支配者から、お祭りによせて祝辞の電報がやってくる。そうか、おまえのせいかッ!!　マップの支配者の名前が分かり、そのキャラクターへの《敵意》が1D6点上がる",
          "「そういえば、国のみんなが何かいってたなぁ……」回想シーン。好きな散策表を1つ選び、2D6を振る。表に照らし合わせた結果を処理する",
          "あー。早く帰って、お祭りを楽しみたーい！　この時点でキャンプを終了し、すぐに次の部屋へ移動すれば、このクォーターは、時間の経過が起こらない",
          "どこからか美味しそうな匂いが漂ってくる。「あ、うまそう」死んだふりをしていた民が起き上がる。今回の冒険で消費していた《配下》が1D6人回復する",
          "雰囲気がいつもと違うせいかな。なんかあの人がステキに見える。好きなキャラクター1人を選ぶ。そのキャラクターへの《好意》を1点上げる",
          "あ、こんなところにまで屋台が！　あてくじ屋さんだ。1MG減らして、好きなアイテムカテゴリを選び、さらにそのカテゴリの中からランダムにアイテム1個を選ぶ。そのアイテムをもらえる（レアアイテムは飾ってあるが、絶対当たらない）",
          "お祭りを目指す交易商人と出会う。「あ、王様。これから王国行くんすよ」宮廷の持つ好きな素材を何個でも、同じ数の別の素材と交換してくれる",
          "せっかくお祭りなんだし、肩肘はってないで、ノリノリでGO!!　このゲーム中は食事をするたびに《民の声》が1点回復する",
          "「あ、この歌は……」祭囃子がキミの封印されていたモンスターにまつわる過去の記憶を呼び戻す。好きなモンスター1種類を選ぶ。そのモンスター全般への《敵意》が1点上がる",
          "みんなのワクワクがアイテムに乗り移った？　ランダムに自分のアイテムスロット1つを選ぶ。そこにレベルのあるアイテムがあった場合、そのレベルが1上がる",
        ])
      end

      # お祭り表(2D6)
      def mk_festival_table
        get_table_by_2d6([
          "祈願祭。国や重要人物の無病息災を祈ったり、戦いの勝利などを祈る祭り。災害や飢饉、流行り病が起こった付近で行われる。シナリオの目的をクリアしていれば、《民》が1D6人上昇する",
          "血祭り。戦いに向け、士気を向上させる祭り。戦争だけでなく、迷宮探索に向けて行われることも多い。生贄の血を軍神に捧げたりする。このゲームの間、戦闘に勝利すると《民の声》を1点獲得し、逃走すると《民の声》が1点失われる",
          "記念日。建国記念日や領土獲得などの記念日のお祝い。簡単につくることができるが、気がつくと記念日だらけで、何の記念だったかを忘れてしまう。ほどほどに。このゲームの間、行為判定の目で3でも絶対失敗、11でも絶対成功になる（「呪い」のバッドステータスを受けたものは4でも絶対失敗、【必殺】を使った命中判定なら10でも絶対成功）",
          "星祭。季節のお祭り。冬至や夏至などの祭りや、七夕、お花見、雪祭りなどが含まれる。季節感の少ない迷宮では、殊更にその風情を楽しもうとやたら盛り上がる。宮廷全員、好きなキャラクター1人を選び、そのキャラクターに対する《好意》を1点上げる",
          "民衆の宴。民が自発的に開くお祭り、イベント。アキハバラ電気祭りに餃子祭り、コミックマーケットなど、文化や地域の活性化と結びつくものが多い。このゲームの間、好きな施設1つを選んで、その施設の施設レベルを1上げる",
          "誕生日。ランドメイカーや逸材、国の重要人物の誕生日。聖誕祭や花祭りなど、国教の聖人などを祝う国も多い。現王の誕生日を「父の日」、后の誕生日を「母の日」とする国も多い。そのゲームの間、ケーキやおにぎり、缶ジュースなど、1人分が明確な食べ物を食べきったとき、自分のPCが《気力》1点を獲得する",
          "冠婚葬祭。国の重要人物の元服（成人）、婚礼、葬儀、祖先の慰霊などの儀式。格式の高い王国では、もっとも重要な祭礼である。このゲームの間、国力を使った判定の達成値を1上昇させる",
          "感謝祭。豊漁や豊作などがあったときに自然（迷宮）や精霊、信仰対象など、偉大なるものへの感謝を捧げるお祭り。獲物の毛の一部を切りとって迷宮に感謝する毛祭りや瀬祭り、豊饒を祝う新嘗祭などがある。終了フェイズに「木」や「革」、「肉」のいずれかを1つ消費すると、王国変動表の結果を±1の範囲でずらすことができる",
          "鬼祭り。お正月に旧年の悪を正す修正会、豆をまいて福を呼び込む追儺の儀式、怪物に仮装した子供たちが夜の王国をねり歩くハロウィーンなど、悪魔や悪霊を払うお祭り。モンスター除けに行われる。このゲームの間、ランダムエンカウントの戦闘後に使用するお宝表が1段階、高いレベルのものを使用する",
          "舞踏会。最高の音楽と芸術的な食事、そしてとびきりの衣装で臨む社交界の華。身分や素性を隠してパートナーを探す仮面舞踏会も人気は高い。ちなみに仮面舞踏会では、女性の側から男性をダンスに誘うのが礼儀だぞ。宮廷全員、ランダムにキャラクター1人を選び、そのキャラクターに対する《好意》を1点上げる",
          "競技会。国をあげて、スポーツや芸術、ゲームなど、さまざまなジャンルの一番を決めるお祭り、大会。オリンピックや料理勝負、歌合戦などがある。ランダムに能力値1つを選び、宮廷全員で難易度15の判定を行う。このとき成功した中で、もっとも達成値が高かったキャラクターは、シナリオ終了後、終了フェイズの探索会議で決定されるキャラクターとは別に、勲章を得る",
        ])
      end

      # 王国災厄表（2d6）
      def mk_kingdom_disaster_table
        get_table_by_2d6([
          "王国の悪い噂が蔓延する。既知の土地にある他国との関係が全て１段階悪化する",
          "自国のモンスターが凶暴化する。自国のモンスターの《民》からランダムに１種類選び、そのレベルと等しいだけ《民》が減少する。その後、その種類のモンスターの《民》は全ていなくなる",
          "疫病が大流行する。《民》－（2d6）",
          "自国の迷宮化が進行する。自国の領土のマップ数と等しい値だけ維持費が上昇する",
          "敵国のテロが横行する。［治安レベル/敵対国数×２＋険悪国数＋９］の判定に失敗すると、ランダムに施設を１軒失う",
          "敵国襲来！［軍事レベル/敵対国数×２＋険悪国数＋９］の判定に失敗すると、ランダムに自国の領土を１つ失う",
          "敵国の陰謀。［文化レベル/敵対国数×２＋険悪国数＋９］の判定に失敗すると、ランダムに逸材を１人失う",
          "食糧危機。《民》－（2d6）。王国にある「肉」の素材を１個消費する度に、《民》の減少を１人抑えることができる",
          "住民の不満が爆発する。［生活レベル/敵対国数×２＋険悪国数＋９］の判定に失敗すると《民の声》－１",
          "局地的な迷宮津波が発生。ランダムに自国の領土１つを選び、既知の土地の中からランダムに選んだ場所と場所を入れ替える",
          "敵国の勢力が強大化する。ＧＭは、関係が敵対の国全てについて、その国の領土に接する土地を１つ選び、その土地をその国の領土にする",
        ])
      end

      # 才覚ハプニング表（2d6）
      def mk_talent_happening_table
        get_table_by_2d6([
          "自分に王国を導くことなどできるのだろうか…。【お酒】を消費することができなければ、このゲーム中［才覚］－１",
          "国王の威信が問われる。（2d6）を振り、その値が［《民の声》＋宮廷全員の国王に対する《好意》の合計］以上の場合、《民の声》－（1d6）し、さらに才覚ハプニング表を振る",
          "思考に霧の帳が降りる。「散漫」のバッドステータスを受ける",
          "重大な裏切りを犯してしまう。あなたに対する《好意》が最も高いキャラを１人選ぶ。そのキャラに対する《好意》の分だけそのキャラへの《敵意》を上昇させ、その後《好意》を０にする",
          "この人についていっていいのだろうか…？宮廷全員のあなたに対する《好意》－１（最低０）。その結果、誰かの《好意》が０になると《民の声》－１",
          "宮廷のスキャンダルが暴露される。宮廷全員のあなたに対する《敵意》のうち最も高いものと同じだけ《民の声》が減少する",
          "あなたの失策が噂になる。近隣の国の中からランダムで１つ選ぶ。その国との関係が１段階悪化する",
          "王国の経済に破綻の危機が。［生活レベル/９＋現在の経過ターン数］の判定に失敗すると維持費＋（1d6）ＭＧ",
          "この区画一体の迷宮化が激しくなる。１クォーターが経過する",
          "逸材の賃上げ要求が始まる。終了フェイズの予算会議の時、［今回使用した逸材の数×１］ＭＧだけ維持費が上昇する",
          "今の自分に自信が持てなくなる。生まれ表からランダムにジョブを１つ選び、現在のジョブをそのジョブに変更する",
        ])
      end

      # 魅力ハプニング表（2d6）
      def mk_charm_happening_table
        get_table_by_2d6([
          "民同士の諍いに心を痛め、頭髪にもダメージが！【お酒】を消費することができなければ、このゲーム中［魅力］－１",
          "何気ない一言が不和の種に…。好きなキャラ１人を選び、宮廷全員のそのキャラに対する《敵意》＋１",
          "あなたの美しさに嫉妬した迷宮が、あなたの姿を変える。「呪い」のバッドステータスを受ける",
          "かわいさ余って憎さ百倍。あなたに対する《好意》が最も高いキャラを１人選ぶ。そのキャラに対する《好意》の分だけそのキャラへの《敵意》を上昇させ、その後《好意》を０にする",
          "あなたを巡って不穏な空気が。宮廷全員のあなたに対する「愛情」の《好意》を比べ、高い順に２人選ぶ。その２人の互いに対する《敵意》＋１",
          "いがみ合う宮廷を見て民の士気が減少する。宮廷全員のあなたに対する《敵意》の中で最も高い値と同じだけ《配下》が減少する",
          "宮廷に嫉妬の嵐が巻き起こる。宮廷の中で、あなたに対して愛情を持つキャラクターの数を数える。このゲームの間、行為判定を行うとき、ダイス目の合計がこの値以下なら絶対失敗となる（最低２）",
          "愛想を尽かされる。宮廷全員のあなたに対する《好意》－１（最低０）",
          "あなたの指揮に疑問の声が。［魅力/自分の《配下》の数］の判定に失敗すると［難易度－達成値］人だけ《配下》が減少する",
          "あなたの恋人だという異性が現れる。宮廷全員のあなたに対する《好意》を比べ、最も高いキャラ１人を選ぶ。あなたはそのキャラの［武勇］と同じだけ《ＨＰ》を減少させる",
          "他人が信用できなくなる。このゲームの間、協調行動を行えなくなり、人間関係のルールも使用できなくなる",
        ])
      end

      # 探索ハプニング表（2d6）
      def mk_search_happening_table
        get_table_by_2d6([
          "指の震えが止まらない。【お酒】を消費することができなければ、このゲーム中［探索］－１",
          "流れ星に直撃。《ＨＰ》－（1d6）",
          "敵の過去を知り、同情してしまう。あなたのこのマップの支配者に対する《好意》＋１。このゲームの間、《好意》を持ったキャラに対して攻撃を行い、絶対失敗した場合そのキャラへの《好意》と同じだけ《気力》が減少する",
          "昨日の友は今日の敵。あなたに対する《好意》が最も高いキャラを１人選ぶ。そのキャラに対する《好意》の分だけそのキャラへの《敵意》を上昇させ、その後《好意》を０にする",
          "うっかりアイテムを落として壊す。ランダムにアイテムスロットを１つ選び、そこにアイテムが入っていればそれを全て破壊する",
          "カーネルが活性化しトラップが強化される。このゲームの間、トラップを解除するための難易度＋１",
          "友情にヒビが！宮廷全員のあなたに対する《好意》－１（最低０）、《敵意》＋１",
          "敵の迷宮化攻撃！宮廷全員は［探索/11］を行い、失敗したキャラは（2d6）点のダメージを受ける",
          "つい出来心から国費に手を出してしまう。ＧＭは好きなコモンアイテム１つを選ぶ。あなたはそのアイテムを手に入れるが、維持費＋（1d6）ＭＧ、《民の声》－１。同じ部屋のＰＣは《希望》１点を消費して［探索/９］の判定に成功すれば、それを止めることができる",
          "封印されていたトラップを発動させてしまう。ランダムに災害系トラップから１つを選び、それを発動させる",
          "あなたを憎む迷宮支配者が賞金をかけた。このゲームの間、モンスターの攻撃やトラップの目標をランダムに決める場合、その目標はかならずあなたになる。（この効果を複数人が受けた場合、その中からランダムで決定する）",
        ])
      end

      # 武勇ハプニング表（2d6）
      def mk_valor_happening_table
        get_table_by_2d6([
          "つい幼児退行を起こしそうになる。【お酒】を消費することができなければ、このゲーム中［武勇］－１",
          "不意打ちを食らう。ランダムエンカウントが発生し、奇襲扱いで戦闘を行う",
          "配下の期待が、あなたの重荷となる。［現在の《民の声》－（1d6）］だけ《気力》が減少する",
          "配下があなたをかばう。自分の《配下》が（1d6）人減少する",
          "ムカついたので思わず殴る。自分の《敵意》が最も高いキャラからランダムに１体選び、そのキャラの《ＨＰ》が自分の［武勇］と同じだけ減少する",
          "決闘だっ！宮廷全員のあなたに対する《敵意》の中で、最も高い値と同じだけあなたの《ＨＰ》が減少する",
          "豚どもめ…。宮廷全員に対する《敵意》＋１",
          "古傷が痛み出す。このゲームの間、戦闘で、あなたに対する敵の攻撃が成功すると、常に余分に１点ダメージを受ける",
          "不意に絶望と虚無感が襲い、心が折れる。宮廷全員の《気力》－１",
          "あなたを親の敵と名乗るものたちが現れた。このゲーム中に倒したモンスターからランダムに１種類を選び、そのモンスター（1d6）体と戦闘を行う",
          "自分の失敗が許せない。このゲームの間、《器》が１点減少したものとして扱う",
        ])
      end

      # 王国変動表(2d6)
      def mk_kingdom_change_table
        get_table_by_2d6([
          "列強のプロパガンダが現れる。(1d6)を振り、その目が現在の《民の声》以下で、現在列強の属国になっていたら属国から抜けることができる。上回っていたら、ランダムに列強を１つ選びその属国になる",
          "冒険の成功を祝う民たちが出迎えてくれる。《民の声》＋２。この結果を出したプレイヤー（以下、当ＰＬ）以外の全員は、今回の冒険を振り返り当PLのPCが《好意》を得るとしたら誰が一番ふさわしいかを協議する。決定したキャラへの当PLのPCの《好意》＋１",
          "何者かによる唐突な奇襲攻撃。未知の土地に面している領土からランダムに１つを選ぶ。［軍事レベル/敵対国数×２＋険悪国数＋９］の判定に成功すると返り討ちにして(1d6)ＭＧを得る。失敗するとその領土は施設ごと失われる",
          "民の労働の結果が明らかに。［生活レベル/敵対国数×２＋険悪国数＋９］の判定に成功すると《予算》が自国の領土のマップ数と同じだけ増える。失敗したら《予算》が同じだけ減る",
          "民は領土を渇望していた。５ＭＧを支払えば、隣接する未知の土地１つを領土にできる。(1d6)を振り、その数だけ通路を引くことができる。通路でつながっていない部屋は自国の領土として扱わない",
          "王国の子どもたちが宮廷をあなた方を見て成長する。《民》が［王国に残した《民》の数÷10＋治安レベル］人増える",
          "あなたの活躍を耳にした者たちがやってくる。シナリオの目的を満たしている場合、関係が良好・同盟の国の数だけ(1d6)を振り、［合計値＋治安レベル］人だけ《民》が増える",
          "街の機能に異変が！？［治安レベル/敵対国数×２＋険悪国数＋９］の判定に成功すると、自国の好きな施設１軒を選び、その施設の隣でかつ通路がつながっている部屋に同じ種類の施設がもう１軒できる。失敗したら、自国のタイプ：部屋の施設を１軒選び、破壊する",
          "王国同士の交流が行われた。［文化レベル/敵対国数×２＋険悪国数＋９］の判定に成功すると、生まれ表でランダムにジョブを決めた逸材が１人増え、好きな国１つとの関係を１段階良好にする。失敗すると、自国の逸材１人を選んで失い、ランダムに決めた国１つとの関係が１段階悪化する",
          "ただ、無為に時が過ぎていたわけではない。迷宮フェイズで過ごした１ターンにつき《予算》が１ＭＧ増える",
          "民の意識が大きく揺れる。(1d6)を振り、その目が現在の《民の声》以下だったら、好きな国力が１点上昇する。上回っていたら、好きな国力が１点減少する",
        ])
      end

      # 王国変動失敗表(2d6)
      def mk_kingdom_mischange_table
        get_table_by_2d6([
          "列強のプロパガンダが現れる。(1d6)を振り、その目が現在の《民の声》を上回っていたら、ランダムに列強１つを選びその属国になる",
          "新たな勢力が勃発する。王国シートの基地の土地欄の中から１つ、未知の土地を選ぶ。(1d6)を振り、その結果をその土地に記入する。１：敵対関係の国。２：険悪関係の国。３：凶暴な怪物の巣。４：人間嫌いのダンジョンマスターの庵。５：迷宮化の進んだ大迷宮。６：列強の飛び地",
          "何者かによる唐突な奇襲攻撃。未知の土地に面している領土からランダムに１つを選ぶ。［軍事レベル/敵対国数×２＋険悪国数＋９］の判定に失敗するとその領土は施設ごと失われる",
          "民の労働の結果が明らかに。［生活レベル/敵対国数×２＋険悪国数＋９］の判定に失敗したら《予算》が自国の領土のマップ数と同じだけ減る",
          "他国の使者がやってくる。基地の土地欄の中からランダムに自国以外の国を１つ選ぶ。その国の領土のマップ数を等しい《予算》を消費するとその国との関係が１段階よくなる。消費しないと１段階悪くなる",
          "民の声は離れ、この国を去る者たちがいた。《民》が(1d6)人減少する",
          "過ぎゆく時が王政を帰る。基地の土地欄の中から、経過したターン数と等しい数までランダムに他国を選ぶ。GMは、その国に面する未知の土地１つを選び、それをその国の新たな領土とする。（周囲に未知の土地がない場合は増やせない）",
          "街の機能に異変が！？［治安レベル/敵対国数×２＋険悪国数＋９］の判定に失敗したら、自国のタイプ：部屋の施設を１軒選び、破壊する",
          "王国同士の交流が行われた。［文化レベル/敵対国数×２＋険悪国数＋９］の判定に失敗すると、自国の逸材１人を選んで失い、ランダムに決めた国１つとの関係が１段階悪化する",
          "ただ、無為に時が過ぎていたわけではない。迷宮フェイズで過ごした１ターンにつき《予算》が１ＭＧ増える",
          "民の意識が大きく揺れる。(1d6)を振り、その目が現在の《民の声》を上回っていたら、好きな国力が１点減少する",
        ])
      end

      # 痛打表（2d6）
      def mk_critical_attack_table
        get_table_by_2d6([
          "攻撃の手応えが武器に刻まれる。その攻撃に使用した武具アイテムにレベルがあれば、そのレベルが１点上昇する",
          "電光石火の一撃。攻撃の処理が終了したあと、もう一度行動できる",
          "相手の姿形を変えるほどの一撃。攻撃目標に「呪い」のバッドステータスを与える",
          "乾坤一擲！攻撃の威力が２倍になる",
          "相手を吹き飛ばす一撃。攻撃目標を好きなエリアに移動させる",
          "会心の一撃！攻撃の威力＋（1d6）",
          "相手の勢いを利用した一撃。攻撃の威力が攻撃目標のレベルと同じだけ上昇する",
          "あと１歩まで追いつめる。ダメージを与える代わりに、攻撃目標の残り《ＨＰ》を（1d6）点にすることができる",
          "敵の技を封じる。攻撃目標のスキルを１種選び、その戦闘の間、そのスキルを未修得の状態にする",
          "怒りの一撃！攻撃の威力＋（2d6）",
          "急所をとらえ一撃で切り伏せる。攻撃目標の《ＨＰ》を０にする",
        ])
      end

      # 致命傷表（2d6）
      def mk_fatal_wounds_table
        get_table_by_2d6([
          "圧倒的一撃で急所を貫かれた。死亡する",
          "致命的な一撃が頭をかすめる。［探索/受けたダメージ+5］の判定に失敗すると死亡する",
          "出血多量で昏睡する。行動不能になる。この戦闘が終了するまでに《ＨＰ》を１以上にしないと死亡する",
          "頭を打ちつけ昏睡する。行動不能になる。このクォーターが終了するまでに《ＨＰ》を１以上にしないと死亡する",
          "重傷を負い昏睡する。行動不能になる。（1d6）クォーターが経過するまでに《ＨＰ》を１以上にしないと死亡する",
          "意識を失う。行動不能になる",
          "偶然アイテムに身を守られる。ランダムにアイテムを選び、そのアイテムを破壊してダメージを無効化する。破壊できるアイテムを１個も装備していない場合、行動不能になる",
          "《民》たちが身を挺して庇う。自分の《配下》を（2d6）人減少させ、ダメージを無効化する。《配下》が１人も居ない場合行動不能になる",
          "根性で跳ね返す。［探索/９－現在の《ＨＰ》］の判定に成功すると《ＨＰ》が１になる。失敗すると行動不能になる",
          "精神力だけで耐える。［武勇/９－現在の《ＨＰ》］の判定に成功すると《ＨＰ》が１になる。失敗すると行動不能になる",
          "幸運にもダメージを免れる。ダメージを無効化するが、代わりにランダムにバッドステータス１種を受ける",
        ])
      end

      # 道中表（2d6）
      def mk_travel_table
        get_table_by_2d6([
          "道中の時間が愛を育む。全員、好きなキャラ１体を選びそのキャラに対する《好意》＋１",
          "何かの死体を見つけた。好きな素材１種類を（1d6）手に入れる",
          "辺りが闇に包まれる。宮廷の中からランダムにキャラを選ぶ。そのキャラが【星の欠片】を持っていたら、それが１個破壊される",
          "道に迷いそうになる。全員［才覚/9］の判定を行い、（1d6-成功したキャラ数）クォーター（最低０）、時間が経過する",
          "トラップに引っかかる。全員［探索/9］の判定にを行い、失敗したキャラは《ＨＰ》が（1d6）点減少する",
          "未知の土地の場合、何も起こらない。既知の土地の場合、その土地固有のイベントがある場合はそれが起こる",
          "モンスターの襲撃を受けた。全員［武勇/9］の判定を行い、失敗したキャラは《ＨＰ》が（1d6）点減少する",
          "恐ろしげな咆哮が響き渡る。全員［魅力/9］の判定を行い、失敗したキャラは《配下》が（1d6）人逃走し、自国へ帰る",
          "周辺の迷宮化が進む。宮廷全員は、既知の土地の中からランダムに選んだ土地へ移動する",
          "何かを拾う。コモンアイテムをランダムに１個選び、それを入手する",
          "１ＭＧ拾う",
        ])
      end

      # 交渉表（2d6）
      def mk_negotiation_table
        get_table_by_2d6([
          "中立的な態度は偽装だった。不意を打たれ、奇襲扱いで戦闘を行う",
          "交渉は決裂した。戦闘を行う",
          "交渉は決裂した。戦闘を行う",
          "生け贄を要求された。モンスターの中で最もレベルが高いもののレベルと同じだけ《配下》を減少させれば友好的になる。ただし、《民の声》－（1d6）。《配下》を減らさなければ戦闘を行う",
          "趣味を聞かれた。好きな単語表１つを選びD66を振る。宮廷の中に、その項目を好きなものに指定しているキャラがいれば友好的になる。居なければ戦闘を行う",
          "物欲しそうにこちらを見ている。「肉」の素材（1d6）個か、【お弁当】または【フルコース】１個を消費すれば友好的になる。しなければ戦闘を行う",
          "値踏みするようにこちらを見ている。維持費を（1d6）ＭＧ上昇させれば友好的になる。させなければ戦闘を行う",
          "「何かいいもの」を要求された。モンスターの中で最もレベルが高いもののレベル以上の価格のアイテムを消費すれば友好的になる。レアアイテムは価格を＋１０して扱う。しなければ戦闘を行う",
          "面白い話を要求された。プレイヤー達はモンスター達が興味を引きそうな話をすること。ＧＭがそれを面白いと判断したら［魅力/9］の判定を行い、成功すれば。友好的になる。さもなければ戦闘を行う",
          "一騎打ちを申し込んできた。宮廷の中から代表を１名選び、モンスターの中で最もレベルの高いものと１対１で戦闘を行う（配置は互いに前列）。勝利すれば友好的になる。敗北すれば、再び交渉するか戦闘するかを決断する。この一騎打ちに外野がスキルやアイテムで干渉すると全員で戦闘になる",
          "運命の出会い。モンスター達の宮廷の代表に対する《好意》＋１、友好的になる",
        ])
      end

      # 戦闘ファンブル表（2d6）
      def mk_combat_fumble_table
        get_table_by_2d6([
          "敵に援軍が現れる。敵軍の中で最もレベルの低いモンスターが（1d6）体増える。モンスター側がこの結果になった場合、好きなＰＣの《配下》＋（1d6）",
          "敵の士気が大いに揺らぐ。自軍のキャラは全員１マス後退する",
          "勢い余って仲間を攻撃！自分の居るエリアからランダムに自軍のキャラを１体選び、そのキャラに使用している武器と同じ威力のダメージを与える",
          "つい仲間と口論になる。自軍の未行動キャラの中からランダムに１体選び、行動済みにする",
          "魔法の効果が消える。自軍のキャラが使用したスキルやアイテムの効果で、戦闘中持続するものが全て無効になる",
          "自分を傷つけてしまう。自分に（1d6）ダメージ",
          "攻撃の勢いを逆に利用される。自分の《ＨＰ》を現在値の半分にする",
          "アイテムを落とした。自分が装備しているアイテムからランダムに１個選び、破壊する。モンスター側の場合、自分に（1d6）ダメージ",
          "カーネルが活性化する。戦闘系とラップからランダムに１種類選び、それがその場に配置される",
          "空を切った攻撃に絶望する。自分と、自分に対して１点以上《好意》を持ったキャラ全員の《気力》－１。モンスター側の場合、自分に（1d6）ダメージ",
          "武器がすっぽ抜ける。攻撃に使用していたアイテムが破壊される。モンスター側の場合、自分に（1d6）ダメージ。その後、バトルフィールドにいるキャラの中からランダムに１体選び、そのキャラの《ＨＰ》を１点にする",
        ])
      end

      # 感情表（1d6）
      def mk_emotion_table
        get_table_by_1d3([
          "忠誠／怒り",
          "友情／不信",
          "愛情／侮蔑",
        ])
      end

      # 相場表（2d6）
      def mk_market_price_table
        get_table_by_2d6([
          "無し",
          "肉",
          "牙",
          "鉄",
          "魔素",
          "機械",
          "衣料",
          "木",
          "火薬",
          "情報",
          "革",
        ])
      end

      # お宝表１（1d6）
      def mk_treasure1_table
        get_table_by_1d6([
          "何も無し",
          "何も無し",
          "そのモンスターの素材欄の中から、好きな素材１個",
          "そのモンスターの素材欄の中から、好きな素材２個",
          "そのモンスターの素材欄の中から、好きな素材３個",
          "【お弁当】１個",
        ])
      end

      # お宝表２（1d6）
      def mk_treasure2_table
        get_table_by_1d6([
          "そのモンスターの素材欄の中から、好きな素材３個",
          "そのモンスターの素材欄の中から、好きな素材４個",
          "そのモンスターの素材欄の中から、好きな素材５個",
          "ランダムに回復アイテム１個",
          "ランダムに武具アイテム１個。レベルがあるアイテムなら１レベルのものが手に入る",
          "ランダムにレア一般アイテム１個",
        ])
      end

      # お宝表３（1d6）
      def mk_treasure3_table
        get_table_by_1d6([
          "そのモンスターの素材欄の中から、好きな素材５個",
          "そのモンスターの素材欄の中から、好きな素材７個",
          "そのモンスターの素材欄の中から、好きな素材１０個",
          "好きなコモンアイテムのカテゴリ１種を選び、そのカテゴリからランダムにアイテム１個。レベルがあるアイテムなら１レベルのものが手に入る",
          "ランダムにレア一般アイテム１個。レベルがあるアイテムなら１レベルのものが手に入る",
          "ランダムにレア武具アイテム１個",
        ])
      end

      # お宝表４（1d6）
      def mk_treasure4_table
        get_table_by_1d6([
          "そのモンスターの素材欄の中から、好きな素材５個",
          "そのモンスターの素材欄の中から、好きな素材１０個",
          "好きなコモンアイテムのカテゴリ１種を選び、そのカテゴリからランダムにアイテム１個。レベルがあるアイテムなら２レベルのものが手に入る",
          "好きなコモンアイテムのカテゴリ１種を選び、そのカテゴリからランダムにアイテム１個。レベルがあるアイテムなら３レベルのものが手に入る",
          "ランダムにレア一般アイテム１個。レベルのあるアイテムなら２レベルのものが手に入る",
          "ランダムにレア武具アイテム１個。レベルのあるアイテムなら１レベルのものが手に入る",
        ])
      end

      # お宝表５（1d6）
      def mk_treasure5_table
        get_table_by_1d6([
          "そのモンスターの素材欄の中から、好きな素材１０個",
          "そのモンスターの素材欄の中から、好きな素材１５個",
          "好きなコモンアイテムのカテゴリ１種を選び、そのカテゴリからランダムにアイテム１個。レベルがあるアイテムなら４レベルのものが手に入る",
          "ランダムにレア一般アイテム１個。レベルのあるアイテムなら３レベルのものが手に入る",
          "ランダムにレア武具アイテム１個。レベルのあるアイテムなら２レベルのものが手に入る",
          "好きなレアアイテム１個",
        ])
      end

      # 1レベルランダムエンカウント表(1D6)
      def mk_random_encount1_table(num)
        table = [
          [1, "『守って守って突撃ゴー！』　前衛：ごんぎつね×宮廷の人数、後衛：ノコギリ猪×1"],
          [2, "『じわじわ削る、カボチャの舞』　前衛：焔虫×宮廷の人数、本陣：カボチャ頭×宮廷の人数の半分"],
          [3, "『ものすごくジャマな人たち。』　前衛：小人さん×宮廷の人数、取り替え子×宮廷の人数の半分"],
          [4, "『何かやってくれるかも……』　前衛：兵隊エルフ×宮廷の人数"],
          [5, "『【かばう】で延命しつつ【鉄の勇気】』　前衛：キンギョ×宮廷の人数、本陣：イカロス×宮廷の人数の半分"],
          [6, "『英雄で指示してシュシュシュシュ～～～～ト!!』　前衛：小鬼×宮廷の人数、後衛：小鬼×宮廷の人数、本陣：小鬼大砲×1、小鬼英雄×1"],
        ]

        return get_table_by_number(num, table)
      end

      # 2レベルランダムエンカウント表(1D6)
      def mk_random_encount2_table(num)
        table = [
          [1, "『作戦判定に負けてもOK、そして強い』　前衛：ガーゴイル×宮廷の人数"],
          [2, "『吸い殺せ！　ドレインしまくれ！』　後衛：塚人×宮廷の人数の半分"],
          [3, "『ゴールデンコンビ結成。指揮と【鉄腕】＋【範囲攻撃】で大暴れ』　前衛：牛頭×宮廷の人数の半分、後衛：山羊頭×宮廷の人数の半分"],
          [4, "『クピドは野放しにできないが、ハルキュオネは殺せない。このジレンマが……』　前衛：ハルキュオネ×宮廷の人数、後衛：ハルキュオネ×宮廷の人数、本陣：クピド×宮廷の人数の半分"],
          [5, "『眠りコンボ』　前衛：グレムリン×宮廷の人数、本陣：眠りの精×1"],
          [6, "『回避を減らしてみみずの範囲攻撃』　前衛：みみず×宮廷の人数、本陣：大喰らい×宮廷の人数の半分"],
        ]

        return get_table_by_number(num, table)
      end

      # 3レベルランダムエンカウント表(1D6)
      def mk_random_encount3_table(num)
        table = [
          [1, "『魅了→木霊ハメ』　後衛：淫魔×1、本陣：レーシィ×宮廷の人数"],
          [2, "『素早く【多勢に無勢】をしかけ……たい』　前衛：階賊×宮廷の人数、本陣：抜け忍×1"],
          [3, "『倒しても嬉しくない人柱をどうぞ』　前衛：人柱×宮廷の人数、本陣：恋のぼり×宮廷の人数の半分"],
          [4, "『位置を調整して【抱擁】してみよう』　後衛：霧妾×宮廷の人数、本陣：お化けシーツ×宮廷の人数"],
          [5, "『クリティカルヒットしたい（希望）』　後衛：ヴォーパルバニー×宮廷の人数、本陣：二面人×1"],
          [6, "『なんとか特攻したい（願望）』　前衛：穴人×宮廷の人数、ゴーレム×1"],
        ]

        return get_table_by_number(num, table)
      end

      # 4レベルランダムエンカウント表(1D6)
      def mk_random_encount4_table(num)
        table = [
          [1, "『増やして治す。ド外道タッグが嵐を呼ぶぜ』　前衛：闇双子×1、本陣：坊主子牛×宮廷の人数の半分"],
          [2, "『カリスマ的存在＋平和の使者→エセNGOみたいな？』　前衛：ワリアヒラ×宮廷の人数、後衛：妖精騎士×1"],
          [3, "『【星戦】→攻撃、【星界】→【ベアハッグ】』　前衛：洞窟熊×宮廷の人数、本陣：星人×宮廷の人数の半分"],
          [4, "『さりげなく先攻を取りつつ《民》をバイドバイパー作戦』　前衛：大目玉×宮廷の人数、本陣：笛吹き男×宮廷の人数の半分"],
          [5, "『アンデッドチーム、がんばれ！』　前衛：墓暴き×宮廷の人数、本陣：吸血鬼×1"],
          [6, "『まよセレ、このゲームの代名詞（？）。こいつは欠かせない！』　後衛：マヨネーズキング・ピュアセレクト×宮廷の人数、本陣：メイクイーン×1"],
        ]

        return get_table_by_number(num, table)
      end

      # 5レベルランダムエンカウント表(1D6)
      def mk_random_encount5_table(num)
        table = [
          [1, "『「死ぬが良い」最終鬼畜兵器岸降臨』　前衛：暗黒騎士×1"],
          [2, "『割と痛い。さりげなく魔王が分裂する』　前衛：カミツキ魔王×宮廷の人数の半分、本陣：雷鳥×1"],
          [3, "『ハマると死ぬ。5人パーティだと3体出てザマーミロ』　前衛：ヴァララカール×宮廷の人数の半分"],
          [4, "『不意打ちされたらデンジャー。ひそかにワイヴァーンで先手を取る』　前衛：睨み毒蛇×宮廷の人数の半分、後衛：ワイヴァーン×1"],
          [5, "『ゾンビスペシャル……で、がんばりたい』　前衛：死にぞこない×宮廷の人数の半分、後衛：死にぞこない×宮廷の人数の半分、本陣：屍術師×1"],
          [6, "『とにかく殴れ！　単純明快パワーチーム』　前衛：鮫人×宮廷の人数、夜這い海星×1"],
        ]

        return get_table_by_number(num, table)
      end

      # 6レベルランダムエンカウント表(1D6)
      def mk_random_encount6_table(num)
        table = [
          [1, "『死んでください。【外皮】か【甲冑】がないと相当ヤバい』　本陣：死告天使×宮廷の人数"],
          [2, "『ド迫力。ブレス連発。3体出ちゃったらカーニバル』　本陣：ドラゴン×宮廷の人数の半分"],
          [3, "『死霊のボス。スキル次第でヤバい。GMの悪意が閃くときだ』　本陣：骨龍×1、推奨スキル【不滅の炎】、【困惑】、【ヤバチョンガー】など"],
          [4, "『《好意》を消して【魅了】に持ち込む』　後衛：愛染明王×宮廷の人数"],
          [5, "『真の狙いは【蜘蛛の群れ】』　前衛：アラクネ×宮廷の人数、本陣：蜘蛛の王×1"],
          [6, "『お約束。まあこいつは出るだろうみたいな』　前衛：魔蟹×1、帳魚×1"],
        ]

        return get_table_by_number(num, table)
      end

      def getAftersearchBreakTable()
        get_table_by_2d6([
          "「おつとめ、ご苦労様です」同行する民たちが感謝の言葉をかける。《民の声》が1点回復する。",
          "「おい、サボるな」と仲間から怒られた。いやいや、こっちは今までマジメにやってましたよ。宮廷の中から好きなキャラクター1人を選ぶ。自分のそのキャラクターに対する《敵意》が1点上昇する。",
          "大漁大漁！　色々な素材が見つかる。肉、牙、革、木、鉄の素材（キャラクターシートの上の段の素材）を1個ずつ獲得する。",
          "そこは、もう、使い魔が探索してくれていたようだ。サンキュー相棒！　この捜索の判定に【使い魔】を利用していれば、行動済みにならず、さらにもう1回行動を行うことができる。",
          "危険なトラップを見つけたが、なんとか無力化できた。任務完了。自分の《気力》が1点回復する。",
          "何も見つからなかったか、と思っていたら「いつも、ありがとう」と宮廷の仲間から声をかけられた。まぁ、何もない方がいいか。宮廷の中から好きなキャラクター1人を選ぶ。自分のそのキャラクターに対する《好意》が1点上昇する。",
          "「さすが！　素晴らしいお手並みだ」鮮やかな捜索に、仲間の見る目が変わる。宮廷の中から好きなキャラクター1人を選ぶ。そのキャラクターの自分に対する《好意》が1点上昇する。",
          "よしよし、これはいいものが見つかった。好きな素材を1d6個獲得する。この捜索の判定に【使い魔】を使用していれば、獲得数が1d6個上昇する。",
          "大漁大漁！　色々な素材が見つかる。衣料、魔素、機械、火薬、情報の素材（キャラクターシートの上の段の素材）を1個ずつ獲得する。",
          "うわ！　罠だ。余計なものまで見つけてしまった。宮廷全員は1d6点のダメージを受ける。",
          "「へぇ、こんなヤツだったのか」仲間の意外な一面を見つける。宮廷の中から好きなキャラクター1人を選ぶ。自分のそのキャラクターに対する《好意》か《敵意》を1点上昇させ、その属性を好きなものに変更できる。",
        ])
      end

      def getWholeBreakTable()
        get_table_by_2d6([
          "部屋の中から使えそうな装備をみつくろう。宮廷全員は、それぞれ好きなコモンアイテムのカテゴリを選び、そのランダムにコモンアイテムを1つ獲得する。そのアイテムにレベルがあれば、それは1レベルのものとなる。",
          "みんなで今後の作戦を練る。宮廷全員は、そのターンの間、あらゆる判定の達成値が1上昇する。",
          "手分けして物資の調達を行う。各キャラクターは、好きな素材を1d6個獲得できる。このとき、素材が揃っていれば、各キャラクターにつき1個までアイテムを作成することができる。",
          "体を休めながら他愛もない世間話に花が咲く。宮廷全員は、それぞれ宮廷の中から好きなキャラクター1人を選び、そのキャラクターに対する《好意》が1点上昇する。",
          "宮廷メンバーで交代で見張りを行い、疲労した配下たちを休ませる。《民の声》が宮廷の人数と同じ値だけ回復する。",
          "一行はしっかりと休息を取り、鋭気を養う。宮廷全員の《気力》が1点回復する。",
          "配下たちと一緒に体を休める。《民の声》が1d6点回復する。",
          "配下たちに見張りを任せ、体を休める。宮廷全員の《HP》がすべて回復する。",
          "緊急ミーティング！　国家運営に関してみんなで知恵を出し合う。《予算》を[宮廷の人数*1]MG獲得する。",
          "負傷した配下たちの治療を行う。宮廷全員の《配下》が1d6人回復する。",
          "宮廷の前に光り輝くアイテムが降臨する。レア武具アイテムかレア一般アイテムのどちらかを選ぶ。ランダムにそのアイテムを1つ選び、それを獲得する。",
        ])
      end

      def getLoversBreakTable()
        table = [
          [11, "「あーもう、最悪！」仲良く休憩するつもりが、ひどい喧嘩になってしまう。この表の使用者のお互いに対する《好意》が0になり、その値の分だけお互いに対する《敵意》が上昇する。"],
          [12, "「何もかもがお前が悪かったのかッ！！」大きな誤解が生まれる。受け身キャラの攻め気キャラ以外に対する《敵意》がすべて0になり、その値の分だけ攻め気キャラに対する《敵意》が上昇する。"],
          [13, "「でさぁ、あの人のことなんだけど……」せっかく2人きりなのに、他人の話で盛り上がる。この表の使用者は、宮廷の中からこの表の使用者以外のキャラクター1人を選び、そのキャラクターに対する《好意》が1点上昇する。"],
          [14, "「へぇ、そんなのあるんだ」互いの好きなものについて語り合う。受け身キャラは、攻め気キャラの「好きなもの」1つを選ぶ。受け身キャラは、自分の「好きなもの」1つをそれに変更し、攻め気キャラへの《好意》が1点上昇する。"],
          [15, "「なぁ、オレのことどう思う？」思い切った質問！　受け身キャラは、攻め気キャラに対する《好意》か《敵意》を1点上昇させ、その属性を好きなものに変更できる。"],
          [16, "「だいじょうぶ？　無茶するんだから」少し前の失敗について色々と言われてしまう。ありがたいんだけど、少しムカつく。受け身キャラは、攻め気キャラに対する《好意》と《敵意》が1点ずつ上昇する。"],
          [22, "「え、もうこんな時間！？」一休みするつもりが、気がつくとかなり時間がたっている。宮廷の未行動キャラクターが全員行動済みになったら、通常の時間の経過に加え、さらに1クォーターが経過する。この表の使用者のお互いに対する《好意》が1点上昇する。また、宮廷のこの表の使用者2人に対する《敵意》が1点上昇する。"],
          [23, "「ねぇねぇ、これわかる？」何気ない質問だが、これは難しい。変な答えは出来ないぞ。攻め気キャラは、〔才覚〕で難易度9の判定を行う。成功すると、この表の使用者のお互いに対する《好意》が1点上昇する。失敗すると、なんとか危機を切り抜けることができるが、受け身キャラの攻め気キャラに対する《敵意》が1点上昇する。"],
          [24, "「おいおい、まずは落ち着け」配下同士が喧嘩を始めた。うまく仲裁しないと……。攻め気キャラは、〔魅力〕で難易度9の判定を行う。成功すると、この表の使用者のお互いに対する《好意》が1点上昇する。失敗すると、なんとか危機を切り抜けることができるが、受け身キャラの攻め気キャラに帯する《敵意》が1点上昇する。"],
          [25, "「オレが解除するからちょっと待ってろ」2人で休憩するつもりが、一緒にトラップにひっかかってしまった。互いの体が密着してしまう。攻め気キャラは、〔探索〕で難易度9の判定を行う。成功すると、この表の使用者のお互いに対する《好意》が1点上昇する。失敗すると、なんとか危機を切り抜けることができるが、受け身キャラの攻め気キャラに対する《敵意》が1点上昇する。"],
          [26, "「お前は後ろに下がってろ！」休憩中に怪物に襲われる。攻め気キャラは、〔武勇〕で難易度9の判定を行う。成功すると、この表の使用者のお互いに対する《好意》が1点上昇する。失敗すると、なんとか危機を切り抜けることができるが、受け身キャラの攻め気キャラに対する《敵意》が1点上昇する。"],
          [33, "「なぁ、さっきは悪かったな」誤解が解ける。この表の使用者のお互いに対する《敵意》が0になり、その値のぶんだけお互いに対する《好意》が上昇する。"],
          [34, "「これを言ったのはあなただけです。誰にも言わないでくださいね」受け身キャラが隠している夢や秘密を攻め気キャラが知ってしまう。受け身キャラの攻め気キャラに対する《好意》が1点上昇する。攻め気キャラの受け身キャラに対する《好意》の属性が「忠誠」に変わる。"],
          [35, "「これからも、よろしく頼むぜ。相棒」攻め気キャラが快活に微笑む。受け身キャラの攻め気キャラに対する《好意》が1点上昇する。攻め気キャラの受け身キャラに対する《好意》の属性が「友情」に変わる。"],
          [36, "「わ、わたしは、あなたのことが……」受け身キャラの思わぬ告白！　受け身キャラの攻め気キャラに対する《好意》が1点上昇する。攻め気キャラの受け身キャラに対する《好意》の属性が「愛情」に変わる。"],
          [44, "「大丈夫？　痛くないか？」互いに傷を治療しあう。この表の使用者は、お互いの自分に対する《好意》の分だけ、自分の《HP》を回復することができる。どちらかが《HP》が1点以上回復したら、この表の使用者のお互いに対する《好意》が1点上昇する。"],
          [45, "「この冒険が終わったら、伝えたいことが……あるんだ」攻め気キャラの真剣な言葉。え、それって……？　受け身キャラの攻め気キャラに対する《好意》が1点上昇する。エピローグに攻め気キャラが生きていれば、この表の使用者のお互いに対する《好意》が2点上昇する。ただし、以後このゲームの間、攻め気キャラが「致命傷表」を使用することになった場合、余分に1個サイコロを振り、その中からもっとも低い目2つを選んで、その結果を適用する。"],
          [46, "「蝕ッ！？　……って、どこ触ってるんですかッ！？」あたりが不意に暗くなり、思わず変なところを触ってしまう。攻め気キャラの受け身キャラに対する《好意》が2点上昇し、受け身キャラの攻め気キャラに対する《敵意》が2点上昇する。この表の使用者が持っている【星の欠片】1個を破壊すれば、このイベントをなかったことにできる。"],
          [55, "「これ、はんぶんこしない？」2人仲良く、アイテムを分け合う。この表の使用者が、使用するとなくなる回復アイテムを持っていれば、それを1個使用出来る。ただし、その効果の大賞は、この表を使用した2人に変更される。この表の使用者のお互いに対する《好意》が1点上昇する。"],
          [56, "「え？　え？　えぇぇぇぇッ！？」ふとした拍子に唇がふれあう。受け身キャラの攻め気キャラ以外に対する《好意》がすべて0になり、その値のぶんだけ攻め気キャラに対する《好意》が上昇する。"],
          [66, "「…………」気がつくとお互い、目をそらせなくなってしまう。そのまま顔を寄せ合い……。この表の使用者のお互いに対する《好意》が2点上昇し、その属性を「愛情」にする。"],
        ]

        value = @randomizer.roll_d66(D66SortType::ASC)
        return get_table_by_number(value, table), value
      end
    end
  end
end
