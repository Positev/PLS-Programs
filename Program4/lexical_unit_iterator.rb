require_relative 'dot_lexer'


class LexicalUnitIterator
  attr_accessor :current_index
  # @param [DotLexer] lexer
  def initialize(lexer)
    super()
    @tokens = lexer.all_tokens
    @current_index = -1
  end

  def peek_next
    in_range(@current_index + 1) ? @tokens[@current_index + 1] : nil
  end

  def look_ahead(n)
    return @tokens[@current_index + n]
  end



  def prev
    can_backtrack = in_range(@current_index - 1)
    if can_backtrack
      @current_index -= 1
    end
    can_backtrack ? @tokens[@current_index] : nil
  end

  def current

    #puts "Current: #{@tokens[@current_index]}"
    @tokens[@current_index]
  end

  def next

    can_advance = in_range(@current_index + 1)
    if can_advance
      @current_index += 1
    end

    #puts "Next: #{@tokens[@current_index]}"
    can_advance ? @tokens[@current_index] : nil
  end

  # @param [Object] index
  def in_range(index)
    index >= -1 and index < @tokens.length
  end
end