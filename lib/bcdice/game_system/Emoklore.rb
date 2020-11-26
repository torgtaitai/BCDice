# frozen_string_literal: true

require "utils/ArithmeticEvaluator"
require "utils/modifier_formatter"

module BCDice
  module GameSystem
    class Emoklore < Base
      # ゲームシステムの識別子
      ID = "Emoklore"

      # ゲームシステム名
      NAME = "エモクロア"

      # ゲームシステム名の読みがな
      #
      # 「ゲームシステム名の読みがなの設定方法」（docs/dicebot_sort_key.md）を参考にして
      # 設定してください
      SORT_KEY = "えもくろあ"

      # ダイスボットの使い方
      HELP_MESSAGE = <<~MESSAGETEXT
        ・技能値判定（xDM<=y）
          "(個数)DM<=(判定値)"で指定します。
          ダイスの個数は省略可能で、省略した場合1個になります。
          例）2DM<=5 DM<=8
      MESSAGETEXT

      # ダイスボットで使用するコマンドを配列で列挙する
      setPrefixes(['\d*DM<=.*', '\d*DA\d+.*'])

      def initialize
        super
        @critical_value = 1
        @fumble_value = 10
      end

      def changeText(string)
        string
      end

      # ダイスボット固有コマンドの処理を行う
      # @param [String] command コマンド
      # @return [String] ダイスボット固有コマンドの結果
      # @return [nil] 無効なコマンドだった場合
      def rollDiceCommand(command)
        # コマンドを解析して下位に渡す（スペース、'['、']' は削除する）
        case command
        when /\d*DM( )*<=( )*\d/
          return getCheckResult(command.delete(" "))
        when /\d*DA\d+(\+)?\d*/
          return getCheckResultCustom(command.delete(" "))
        end
        return nil
      end

      # 判定ダイスロール
      def execRoll(num_dice, success_threshold)
        # ダイスを振った結果を配列として取得
        values = Array.new(num_dice.to_i) { roll(1, 10)[0] }

        # クリティカルが出た数
        values_critical = values.select { |num| num <= @critical_value }
        delete_num = 1
        values_tmp = values.clone
        while delete_num <= @critical_value
          values_tmp.delete(delete_num)
          delete_num += 1
        end

        # 成功が出た数
        values_success = values_tmp.select { |num| num <= success_threshold }

        # ファンブルが出た数
        values_fumble = values_tmp.select { |num| num >= @fumble_value }

        # 出た目に従って成功値計算
        success_value = 2 * values_critical.size + values_success.size - values_fumble.size
        return_str = ""
        if success_value < 0
          return_str = "ファンブル!"
        elsif success_value == 0
          return_str = "失敗!"
        elsif success_value == 1
          return_str = "成功!"
        elsif success_value == 2
          return_str = "ダブル!"
        elsif success_value == 3
          return_str = "トリプル!"
        elsif success_value >= 4 && success_value <= 9
          return_str = "ミラクル!"
        elsif success_value >= 10
          return_str = "カタストロフ!"
        end

        # ダイスを振った結果を返す
        return "#{values} ＞ #{success_value} ＞ #{return_str}"
      end

      # 技能判定
      # @param [String] command コマンド
      # @return [String] コマンドの結果
      def getCheckResult(command)
        num_dice = 1

        # コマンド解析
        if (m = /(\d*)DM<=(\d+)/i.match(command))
          # ダイスの数は省略可能（省略した場合は1個）
          unless m[1].to_s == "" || m[1].to_s.nil?
            if m[1].to_i <= 0
              return nil
            end

            num_dice = m[1].to_i
          end

          # 判定値
          success_threshold = m[2].to_i

          # ダイスロール本体
          ret_str = execRoll(num_dice, success_threshold)

          # 結果を返す
          return "(#{num_dice}DM<=#{success_threshold}) ＞ " + ret_str
        end
        return nil
      end

      # 取得技能判定
      # @param [String] command コマンド
      # @return [String] コマンドの結果
      def getCheckResultCustom(command)
        skil_level = 0
        num_dice = 1

        # コマンド解析
        if (m = /(\d*)DA(\d+)(\+)?(\d*)/i.match(command))
          # ダイスの数は省略可能（省略した場合は1個）
          unless m[1].to_s == "" || m[1].to_i <= 0
            skil_level = m[1].to_i
            num_dice = m[1].to_i
          end

          # 判定値を計算
          success_threshold = m[2].to_i + skil_level.to_i

          # ボーナスダイス加算
          unless m[4].to_s == "" || m[4].to_i <= 0
            num_dice = num_dice.to_i + m[4].to_i
          end

          # ダイスロール本体
          ret_str = execRoll(num_dice, success_threshold)

          # 結果を返す
          return "(#{m[1]}DA#{m[2]}#{m[3]}#{m[4]}) ＞ (#{num_dice}DM<=#{success_threshold}) ＞ " + ret_str
        end
        return nil
      end
    end
  end
end
