require 'minitest/autorun'
require_relative '../dot_lexer'
require_relative '../token'

class TestDotLexerTest < MiniTest::Unit::TestCase
  def setup
    # Do nothing
  end

  def teardown
    # Do nothing
  end

  def test_3
    text = "Ca#t"
    expectedTokens = [
        Token.new("Ca", 1),
        Token.new("#", -1),
        Token.new("t", 1),
    ]

    actualTokens = DotLexer.new().handle_illegal_characters(text)
    puts actualTokens

    assert expectedTokens == actualTokens
  end

  def test_1
    text = "Ca#&t"
    expectedTokens = [
        Token.new("Ca", 1),
        Token.new("#", -1),
        Token.new("&", -1),
        Token.new("t", 1),
    ]

    actualTokens = DotLexer.new( ).handle_illegal_characters(text)
    puts actualTokens

    assert expectedTokens == actualTokens
  end

  def test_2
    text = "C#a&t"
    expectedTokens = [
        Token.new("C", 1),
        Token.new("#", -1),
        Token.new("a", 1),
        Token.new("&", -1),
        Token.new("t", 1),
    ]

    actualTokens = DotLexer.new( ).handle_illegal_characters(text)
    puts actualTokens

    assert expectedTokens == actualTokens
  end
end