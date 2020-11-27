require_relative 'dot_lexer'


class LexicalUnitIterator
  attr_accessor :current_index
  # @param [DotLexer] lexer
  def initialize(lexer)
    super()
    @tokens = lexer.all_tokens
    @current_index = 0
  end

  def peek_next
    in_range(@current_index + 1) ? @tokens[@current_index + 1] : nil
  end



  def prev
    can_backtrack = in_range(@current_index - 1)
    if can_backtrack
      @current_index -= 1
    end
    can_backtrack ? @tokens[@current_index] : nil
  end

  def current
    @tokens[@current_index]
  end

  def next

    can_advance = in_range(@current_index + 1)
    if can_advance
      @current_index += 1
    end
    can_advance ? @tokens[@current_index] : nil
  end

  # @param [Object] index
  def in_range(index)
    index >= 0 and index < @tokens.length
  end
end