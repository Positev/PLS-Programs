# Author: Trevor Keegan
# Date: 11/6/2020
# The Token is a pair of text and a category identifier

class Token
  attr_accessor :type

  EOF = -2
  INVALID = -1
  ID = 1
  INT = 2
  STRING = 3
  LCURLY = 4
  RCURLY = 5
  SEMI = 6
  LBRACK = 7
  RBRACK = 8
  ARROW = 9
  EQUALS = 10
  DIGRAPH = 11
  SUBGRAPH = 12
  COMMA = 13
  WHITESPACE = 14

  # build the Token object
  def initialize (text, id)
    super()
    @text = text
    @type = id
  end

  # Serialize the token to a string, if the token is valid, thus type != -1, expect ['text':'type'].
  # Otherwise expect illegal char: #{@type}
  def to_s
    if @type != INVALID
      "[#{@text}:#{@type}]"
    else
      "illegal char: #{@text}"
    end
  end

end