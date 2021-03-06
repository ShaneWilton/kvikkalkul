require 'kvikkalkul/token'

module Kvikkalkul
  class Lexer
    class UnknownTokenError < RuntimeError; end

    def lex(data)
      tokens = data.split('')
                   .map { |char| tokenize(char) }

      split_on_token(tokens, Token::NEWLINE)
        .map { |line| split_on_token(line, Token::SPACE) }
    end

    private

    def tokenize(character)
      case character
      when "\n"
        Token::NEWLINE
      when " "
        Token::SPACE
      when "0"
        Token::ZERO
      when "1"
        Token::ONE
      when "2"
        Token::TWO
      when "3"
        Token::THREE
      when "4"
        Token::FOUR
      when "5"
        Token::FIVE
      when "6"
        Token::SIX
      when "7"
        Token::SEVEN
      when "8"
        Token::EIGHT
      when "9"
        Token::NINE
      when "."
        Token::PERIOD
      when ","
        Token::COMMA
      when "\""
        Token::QUOTE
      when ":"
        Token::COLON
      when "-"
        Token::DASH
      when "/"
        Token::SLASH
      when "("
        Token::LPAREN
      when ")"
        Token::RPAREN
      else
        raise UnknownTokenError, "Unknown token: #{character}"
      end
    end

    def split_on_token(tokens, delimiter)
      puts tokens
      results, arr = [[]], tokens.dup
      until arr.empty?
        if (idx = arr.index(delimiter))
          results.last.concat(arr.shift(idx))
          arr.shift
          results << []
        else
          results.last.concat(arr.shift(arr.size))
        end
      end

      results
    end
  end
end
