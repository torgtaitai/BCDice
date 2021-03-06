# frozen_string_literal: true

require "strscan"
require "bcdice/normalize"

module BCDice
  module CommonCommand
    class Lexer
      SYMBOLS = {
        "+" => :PLUS,
        "-" => :MINUS,
        "*" => :ASTERISK,
        "/" => :SLASH,
        "(" => :PARENL,
        ")" => :PARENR,
        "[" => :BRACKETL,
        "]" => :BRACKETR,
        "?" => :QUESTION,
        "@" => :AT,
      }.freeze

      def initialize(source)
        # sourceが空文字だとString#splitが空になる
        source = source.split(" ", 2).first || ""
        @scanner = StringScanner.new(source)
      end

      def next_token
        return [false, "$"] if @scanner.eos?

        if (number = @scanner.scan(/\d+/))
          [:NUMBER, number.to_i]
        elsif (cmp_op = @scanner.scan(/[<>!=]+/))
          [:CMP_OP, Normalize.comparison_operator(cmp_op)]
        else
          char = @scanner.getch.upcase
          type = SYMBOLS[char] || char.to_sym
          [type, char]
        end
      end

      def source
        @scanner.string
      end
    end
  end
end
