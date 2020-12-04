require_relative 'dot_lexer'

# Author: Trevor Keegan
# Date: 12/4/2020
# Iterator to traverse a list of tokens, used for traversal in both directions of a list of tokens
class LexicalUnitIterator
  attr_accessor :current_index
  # @param [DotLexer] lexer
  def initialize(lexer)
    super()
    @tokens = lexer.all_tokens
    @current_index = -1
  end

  #Look at next token without iterating
  def peek_next
    in_range(@current_index + 1) ? @tokens[@current_index + 1] : nil
  end

  # back up one token and return current token after backing up
  def prev
    can_backtrack = in_range(@current_index - 1)
    if can_backtrack
      @current_index -= 1
    end
    can_backtrack ? @tokens[@current_index] : nil
  end

  # Look at current token 
  def current
    @tokens[@current_index]
  end

  # get next token and set next token to the next next token
  def next

    can_advance = in_range(@current_index + 1)
    if can_advance
      @current_index += 1
    end

    #puts "Next: #{@tokens[@current_index]}"
    can_advance ? @tokens[@current_index] : nil
  end

  # check that index is in range of list of tokens
  # @param [Object] index
  def in_range(index)
    index >= -1 and index < @tokens.length
  end
end