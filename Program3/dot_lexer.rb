require_relative 'token'
class DotLexer
  @@regs = [ #https://regex101.com/ used heavily for this section for testing.
      /^[a-zA-Z0-9]*$/,          #ID => 1
      /(^[0-9][0-9]?)/,          #INT => 2
      /("[^"]*?")/,              #STRING => 3
      /(\{)/,                    #LCURLY => 4
      /(\})/,                    #RCURLY => 5
      /(;)/,                     #SEMI => 6
      /([\[])/,                  #LBRACK => 7
      /([\]])/,                  #RBRACK => 8
      /(\->)/,                   #ARROW => 9
      /(=)/,                     #EQUALS => 10
      /(DIGRAPH|digraph)/,       #DIGRAPH => 11
      /(SUBGRAPH|subgraph)/,     #SUBGRAPH => 12
      /(,)/,                     #COMMA => 13
      /(\s)/                     #WS => 14
  ]

  def initialize
    @tokens = make_tokens(get_all_in_from_stdin)
    @tokens.push(Token.new('', -2))
    @cur_token = 0
  end

  def next_token
    token = @tokens[@cur_token]
    @cur_token += 1
    token
  end

  # @return [String] with all text available in console, joined at line break
  def get_all_in_from_stdin
    ins = []
    input = gets
    until input.nil?
      ins.push(input)
      input = gets
    end
    ins.join()
  end

  def make_tokens(all_text)
    list_of_token_texts = []
    tokens = []
    unwanted_characters = /([\s+,\t+,\n+,\r+])/
    regexp_for_split = Regexp.union(@@regs[2,13])
    all_text.split(regexp_for_split).each do |text_segment|
      possible_token = text_segment.gsub(unwanted_characters, '')
      list_of_token_texts.push(possible_token)
    end
    list_of_token_texts = list_of_token_texts.reject{ |n| n.empty?}
    list_of_token_texts.each do |text|
      tokens.concat make_token(text)

    end
    tokens
  end

  def make_token(token_text)
    if is_token(token_text)
      [Token.new(token_text, get_token_type(token_text))]
    else
      handle_illegal_characters(token_text)
    end
  end

  # @param [String] token_text, text from the input that has not matched any categorization
  # @return [List<Token>] - All invalid and valid tokens available in the provided TOKEN_TEXT
  def handle_illegal_characters(token_text)
    
    return [] if token_text.length == 0

    return [Token.new(token_text, get_token_type(token_text))] if is_token(token_text)

    (0...token_text.length).each do |index_under_evaluation|
      sub_token = token_text[0, index_under_evaluation]
      next if is_token(sub_token)

      tokens = []
      valid_text = token_text[0, index_under_evaluation - 1]
      if valid_text.length > 0
        valid_token = Token.new(valid_text, get_token_type(valid_text))
        tokens.push(valid_token)
      end
      invalid_text = token_text[index_under_evaluation - 1]
      invalid_token = Token.new(invalid_text, -1)
      tokens.push(invalid_token)
      remaining_tokens = handle_illegal_characters(token_text[index_under_evaluation..-1])
      return tokens.concat(remaining_tokens)
    end

    end

  # @param [String] text -> text that should be evaluated and categorized if applicable, true if text is valid token
  # @return [Boolean] True if TEXT is a valid token
  def is_token(text)
    (0...@@regs.length - 1 ).reverse_each do |i|
      regex_pattern = @@regs[i]
      return true if text.match regex_pattern
    end
    false
  end

  def get_token_type(text)
    (0...@@regs.length - 1 ).reverse_each do |i|
      regex_pattern = @@regs[i]
      return i + 1 if text.match regex_pattern
    end
    false
  end
end
